import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:online_doctor/src/models/reservation_model.dart';
import 'package:online_doctor/src/models/specialty_model.dart';
import 'package:online_doctor/src/providers/reservation_provider.dart';
import 'package:online_doctor/src/providers/specialty_provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Details(),
        ],
      ),
    );
  }
}

class Details extends StatelessWidget {
  const Details({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: 20,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          ReservationSwiper(),
          SizedBox(
            height: 16,
          ),
          Specialties()
        ],
      ),
    );
  }
}

class ReservationSwiper extends StatelessWidget {
  ReservationSwiper({Key? key}) : super(key: key);
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
                  width: MediaQuery.of(context).size.width * 2 / 3,
                  height: MediaQuery.of(context).size.height * 2 / 5,
                  child: Center(
                    child: Text(
                      'No hay Reservas.',
                      style: TextStyle(color: Colors.black54, fontSize: 16),
                    ),
                  ),
                )
              : Swiper(
                  itemWidth: MediaQuery.of(context).size.width * 9 / 10,
                  itemHeight: MediaQuery.of(context).size.height * 3 / 8,
                  itemBuilder: (BuildContext context, int index) {
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(30),
                      child: Container(
                        padding: EdgeInsets.all(26),
                        color: Color.fromRGBO(8, 87, 223, 1),
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
                                          (reservations[index]
                                                  .persona!
                                                  .nombres ??
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
                                      reservations[index]
                                              .especialidad!
                                              .nombre ??
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
                            Expanded(child: Container()),
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 14, vertical: 30),
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
                      ),
                    );
                  },
                  itemCount: reservations.length,
                  layout: SwiperLayout.TINDER,
                );
        } else {
          return Container(
            width: MediaQuery.of(context).size.width * 2 / 3,
            height: MediaQuery.of(context).size.height * 2 / 5,
            child: Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
              ),
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

class Specialties extends StatelessWidget {
  Specialties({Key? key}) : super(key: key);
  final SpecialtyProvider specialtyProvider = new SpecialtyProvider();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: specialtyProvider.getSpecialties(),
      builder: (BuildContext context, AsyncSnapshot<List<Specialty>> snapshot) {
        if (snapshot.hasData) {
          final specialties = snapshot.data;
          return (specialties!.length == 0)
              ? Container(
                  width: MediaQuery.of(context).size.width * 2 / 3,
                  height: MediaQuery.of(context).size.height * 2 / 5,
                  child: Center(
                    child: Text(
                      'No hay Especialidades.',
                      style: TextStyle(color: Colors.black54, fontSize: 16),
                    ),
                  ),
                )
              : Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            'Qué estás buscando?',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          Expanded(child: Container()),
                          TextButton(
                            onPressed: () =>
                                Navigator.of(context).pushNamed('specialties'),
                            child: Text(
                              'Ver mas',
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Column(
                            children: [
                              _createSpecialtyButton(context, specialties[0]),
                              SizedBox(
                                height: 10,
                              ),
                              _createSpecialtyButton(context, specialties[1]),
                            ],
                          ),
                          Expanded(child: Container()),
                          Column(
                            children: [
                              _createSpecialtyButton(context, specialties[6]),
                              SizedBox(
                                height: 10,
                              ),
                              _createSpecialtyButton(context, specialties[3]),
                            ],
                          ),
                          Expanded(child: Container()),
                          Column(
                            children: [
                              _createSpecialtyButton(context, specialties[4]),
                              SizedBox(
                                height: 10,
                              ),
                              _createSpecialtyButton(context, specialties[5]),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                );
        } else {
          return Container(
            width: MediaQuery.of(context).size.width * 2 / 3,
            height: MediaQuery.of(context).size.height * 2 / 5,
            child: Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
              ),
            ),
          );
        }
      },
    );
  }

  Widget _createSpecialtyButton(BuildContext context, Specialty specialty) {
    return GestureDetector(
      child: Container(
        height: MediaQuery.of(context).size.height * 1 / 6,
        width: MediaQuery.of(context).size.width * 2 / 7,
        child: Card(
          elevation: 10,
          child: Container(
            padding: EdgeInsets.all(5),
            child: Column(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 1 / 10,
                  width: MediaQuery.of(context).size.width * 2 / 7,
                  child: Image(
                    image: AssetImage(
                        'assets/' + specialty.nombre!.toLowerCase() + '.png'),
                  ),
                ),
                Expanded(child: Container()),
                Text(
                  specialty.nombre ?? '',
                  style: TextStyle(fontSize: 13),
                )
              ],
            ),
          ),
        ),
      ),
      onTap: () =>
          Navigator.of(context).pushNamed('doctors', arguments: specialty),
    );
  }
}
