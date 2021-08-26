import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:online_doctor/src/models/doctor_model.dart';
import 'package:online_doctor/src/providers/global.dart';
import 'package:online_doctor/src/providers/user_provider.dart';
import 'package:provider/provider.dart';

class DoctorProvider {
  Future<List<Doctor>> getDoctors(int id, BuildContext context) async {
    final UserProvider userProvider =
        Provider.of<UserProvider>(context, listen: false);
    final token = await userProvider.readToken();
    final data = json.encode({"especialidad_id": id});
    final response =
        await http.post(Uri.parse('$baseUrl/doctores/especialidad/'),
            headers: {
              'Content-Type': 'application/json',
              'Accept': 'application/json',
              'Authorization': token
            },
            body: data);

    if (response.statusCode == 200) {
      final doctors = doctorFromJson(response.body);
      return doctors;
    }
    return [];
  }
}
