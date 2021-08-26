import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:online_doctor/src/models/schedule_model.dart';
import 'package:online_doctor/src/providers/global.dart';
import 'package:online_doctor/src/providers/user_provider.dart';
import 'package:provider/provider.dart';

class ScheduleProvider {
  Future<List<Schedule>> getSchedules(int id, BuildContext context) async {
    final UserProvider userProvider =
        Provider.of<UserProvider>(context, listen: false);
    final token = await userProvider.readToken();

    final data = json.encode({"persona_id": id});
    final response = await http.post(Uri.parse('$baseUrl/horarios/doctor/'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': token
        },
        body: data);
    print('ID: ' + id.toString());
    print(response.statusCode);
    print(response.body);

    if (response.statusCode == 200) {
      final schedules = scheduleFromJson(response.body);
      return schedules;
    }
    return [];
  }
}
