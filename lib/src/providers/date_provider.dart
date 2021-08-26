import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:online_doctor/src/models/date_model.dart';
import 'package:online_doctor/src/providers/global.dart';
import 'package:online_doctor/src/providers/user_provider.dart';
import 'package:provider/provider.dart';

class DateProvider {
  Future<List<Date>> getDates(BuildContext context) async {
    final UserProvider userProvider =
        Provider.of<UserProvider>(context, listen: false);
    final token = await userProvider.readToken();
    final response =
        await http.get(Uri.parse('$baseUrl/citas/paciente/'), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': token
    });

    if (response.statusCode == 200) {
      final dates = dateFromJson(response.body);
      return dates;
    }
    return [];
  }

  Future<Cita> getDate(int id, BuildContext context) async {
    final data = {"id": id};
    final UserProvider userProvider =
        Provider.of<UserProvider>(context, listen: false);
    final token = await userProvider.readToken();
    final response = await http.post(Uri.parse('$baseUrl/citas/'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': token
        },
        body: json.encode(data));

    if (response.statusCode == 200) {
      print(response.body);
      final date = meetingFromJson(response.body);
      return date;
    }
    return new Cita();
  }
}
