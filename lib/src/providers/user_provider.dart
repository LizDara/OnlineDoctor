import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:online_doctor/src/models/pacient_model.dart';
import 'package:online_doctor/src/providers/global.dart';
import 'package:provider/provider.dart';

class UserProvider extends ChangeNotifier {
  final storage = FlutterSecureStorage();

  Future<bool> login(Usuario usuario) async {
    final response = await http.post(Uri.parse('$baseUrl/iniciar-sesion/'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json'
        },
        body: userToJson(usuario));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      await storage.write(key: 'token', value: data["token"]);
      return true;
    }
    return false;
  }

  Future<bool> updatePassword(BuildContext context, Usuario user) async {
    final UserProvider userProvider =
        Provider.of<UserProvider>(context, listen: false);
    final token = await userProvider.readToken();
    final response = await http.put(Uri.parse('$baseUrl/usuario/'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': token
        },
        body: userToJson(user));

    if (response.statusCode == 200) {
      return true;
    }
    return false;
  }

  Future clearTokens() async {
    return await storage.deleteAll();
  }

  Future<String> readToken() async {
    String token = await storage.read(key: 'token') ?? '';
    return token;
  }

  Future<bool> existToken() async {
    final token = await storage.read(key: 'token') ?? '';
    return token != '';
  }
}
