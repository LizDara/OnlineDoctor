import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:online_doctor/src/models/reserva_model.dart';
import 'package:online_doctor/src/models/reservation_model.dart';
import 'package:online_doctor/src/providers/global.dart';
import 'package:online_doctor/src/providers/user_provider.dart';
import 'package:provider/provider.dart';

class ReservationProvider {
  Future<List<Reservation>> getReservations(BuildContext context) async {
    final UserProvider userProvider =
        Provider.of<UserProvider>(context, listen: false);
    final token = await userProvider.readToken();
    final response = await http.get(
      Uri.parse('$baseUrl/reservas/paciente/'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': token
      },
    );

    if (response.statusCode == 200) {
      final List<Reservation> reservation = reservationFromJson(response.body);
      return reservation;
    }
    return [];
  }

  Future<bool> createReservation(BuildContext context, Reservas reserva) async {
    final UserProvider userProvider =
        Provider.of<UserProvider>(context, listen: false);
    final token = await userProvider.readToken();
    final response = await http.post(Uri.parse('$baseUrl/reservas/'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': token
        },
        body: reservasToJson(reserva));

    if (response.statusCode == 200) {
      return true;
    }
    return false;
  }
}
