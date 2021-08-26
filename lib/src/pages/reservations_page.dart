import 'package:flutter/material.dart';
import 'package:online_doctor/src/models/reservation_model.dart';
import 'package:online_doctor/src/providers/reservation_provider.dart';

class ReservationsPage extends StatelessWidget {
  const ReservationsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _createBackground(context),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Reservas:',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(
                right: 10,
                left: 10,
                top: MediaQuery.of(context).size.height / 10),
            child: ReservationInformation(),
          ),
        ],
      ),
    );
  }

  Widget _createBackground(BuildContext context) {
    return Positioned(
      left: -200,
      right: -200,
      top: -450,
      child: Container(
        height: MediaQuery.of(context).size.height,
        width: 1000,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(360), color: Colors.blue),
      ),
    );
  }
}

class ReservationInformation extends StatelessWidget {
  ReservationInformation({Key? key}) : super(key: key);
  final ReservationProvider reservationProvider = new ReservationProvider();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: reservationProvider.getReservations(context),
      builder:
          (BuildContext context, AsyncSnapshot<List<Reservation>> snapshot) {
        if (snapshot.hasData) {
          final reservations = snapshot.data;

          return (reservations!.length == 0)
              ? Container(
                  child: Center(
                    child: Text(
                      'No hay Reservas.',
                      style: TextStyle(color: Colors.black54, fontSize: 16),
                    ),
                  ),
                )
              : ListView.builder(
                  itemCount: reservations.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      margin: EdgeInsets.all(10),
                      padding: EdgeInsets.all(26),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Color.fromRGBO(8, 87, 223, 1),
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 80,
                                height: 80,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.grey[100]),
                                child: Image(
                                    image: AssetImage('assets/doctor.png')),
                              ),
                              SizedBox(
                                width: 16,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Dr. ' +
                                        (reservations[index].persona!.nombres ??
                                            '') +
                                        ' ' +
                                        (reservations[index]
                                                .persona!
                                                .apellidos ??
                                            ''),
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                  Text(
                                    reservations[index].especialidad!.nombre ??
                                        '',
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.white),
                                  )
                                ],
                              )
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 14, vertical: 24),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Color.fromRGBO(0, 76, 211, 1)),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.watch_later,
                                  color: Colors.white30,
                                ),
                                Expanded(child: Container()),
                                Text(
                                  reservations[index].horario!.dia! +
                                      ', ' +
                                      _getDate(reservations[index]
                                              .reserva!
                                              .fechaCita ??
                                          '') +
                                      ', ' +
                                      _getTime(reservations[index]
                                              .horario!
                                              .horaInicio ??
                                          '') +
                                      ' - ' +
                                      _getTime(reservations[index]
                                              .horario!
                                              .horaFin ??
                                          ''),
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
        } else {
          return Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
            ),
          );
        }
      },
    );
  }

  String _getDate(String dateTime) {
    if (dateTime.length == 0) return "";
    List<String> separateDateTime = dateTime.split('T');
    List<String> date = separateDateTime[0].split('-');
    String result = '';
    switch (date[1]) {
      case "01":
        result += 'Ene ';
        break;
      case "02":
        result += 'Feb ';
        break;
      case "03":
        result += 'Mar ';
        break;
      case "04":
        result += 'Abr ';
        break;
      case "05":
        result += 'May ';
        break;
      case "06":
        result += 'Jun ';
        break;
      case "07":
        result += 'Jul ';
        break;
      case "08":
        result += 'Ago ';
        break;
      case "09":
        result += 'Sep ';
        break;
      case "10":
        result += 'Oct ';
        break;
      case "11":
        result += 'Nov ';
        break;
      case "12":
        result += 'Dic ';
        break;
    }
    result += date[2];
    return result;
  }

  String _getTime(String dateTime) {
    if (dateTime.length == 0) return "";
    List<String> separateDateTime = dateTime.split('T');
    List<String> time = separateDateTime[1].split(':');

    String result = time[0] + ':' + time[1];
    return result;
  }
}
