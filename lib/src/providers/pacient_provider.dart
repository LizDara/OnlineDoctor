import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:online_doctor/src/models/code_model.dart';
import 'package:online_doctor/src/models/pacient_model.dart';
import 'package:online_doctor/src/models/user_model.dart';
import 'package:online_doctor/src/providers/global.dart';
import 'package:online_doctor/src/providers/user_provider.dart';
import 'package:provider/provider.dart';

class PacientProvider {
  Future<Pacient?> register(Pacient pacient) async {
    final response = await http.post(Uri.parse('$baseUrl/pacientes/'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json'
        },
        body: pacientToJson(pacient));

    if (response.statusCode == 201) {
      final Pacient pacient = pacientFromJson(response.body);
      return pacient;
    }
    return null;
  }

  Future<bool> checkData(Code code) async {
    final response = await http.post(Uri.parse('$baseUrl/verificar-datos/'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json'
        },
        body: codeToJson(code));

    if (response.statusCode == 200) {
      return true;
    }
    return false;
  }

  Future<bool> uploadImage(File image, int id) async {
    if (image == null) return false;

    final imageUploadRequest = http.MultipartRequest(
        'POST', Uri.parse('$baseUrl/pacientes/archivos/'));
    final file = await http.MultipartFile.fromPath('img', image.path);

    imageUploadRequest.files.add(file);
    imageUploadRequest.fields.addAll({'persona_id': id.toString()});

    final streamResponse = await imageUploadRequest.send();
    final response = await http.Response.fromStream(streamResponse);

    print(response.statusCode);
    if (response.statusCode == 200) {
      return true;
    }
    return false;
  }

  Future<User> getPacient(BuildContext context) async {
    final UserProvider userProvider =
        Provider.of<UserProvider>(context, listen: false);
    final token = await userProvider.readToken();
    final response = await http.get(Uri.parse('$baseUrl/usuario/'), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': token
    });

    if (response.statusCode == 200) {
      final user = userFromJson(response.body);
      return user;
    }
    return new User();
  }

  Future<bool> updatePacient(Pacient pacient, BuildContext context) async {
    final UserProvider userProvider =
        Provider.of<UserProvider>(context, listen: false);
    final token = await userProvider.readToken();
    final response = await http.put(Uri.parse('$baseUrl/pacientes/'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': token
        },
        body: pacientToJson(pacient));

    if (response.statusCode == 200) {
      return true;
    }
    return false;
  }
}
