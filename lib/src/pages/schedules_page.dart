import 'package:flutter/material.dart';
import 'package:online_doctor/src/models/doctor_model.dart';
import 'package:online_doctor/src/models/reserva_model.dart';
import 'package:online_doctor/src/models/schedule_model.dart';
import 'package:online_doctor/src/providers/reservation_provider.dart';
import 'package:online_doctor/src/providers/schedule_provider.dart';

class SchedulePage extends StatefulWidget {
  SchedulePage({Key? key}) : super(key: key);

  @override
  _SchedulePageState createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  final controller = new TextEditingController(text: '');
  String date = '';

  @override
  Widget build(BuildContext context) {
    final Doctor doctor = ModalRoute.of(context)!.settings.arguments as Doctor;

    return Scaffold(
      key: scaffoldKey,
      body: Stack(
        children: [
          _createBackground(context),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  (doctor.persona.nombres ?? '') +
                      ' ' +
                      (doctor.persona.apellidos ?? ''),
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                Text(
                  'Horarios:',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  height: 18,
                ),
                _createDate(),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(
                right: 10,
                left: 10,
                top: MediaQuery.of(context).size.height * 3 / 11),
            child: ScheduleInformation(
              id: doctor.persona.id ?? 0,
              scaffoldKey: scaffoldKey,
              date: date,
            ),
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

  Widget _createDate() {
    return TextField(
      decoration: InputDecoration(
          labelText: 'Fecha',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
          )),
      controller: controller,
      onTap: () {
        FocusScope.of(context).requestFocus(new FocusNode());
        _selectDate(context);
      },
      onChanged: (value) => date = value,
    );
  }

  _selectDate(BuildContext context) async {
    DateTime now = new DateTime.now();
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: new DateTime(now.year),
      firstDate: new DateTime(now.year),
      lastDate: new DateTime(now.year + 1),
      //locale: Locale('es', 'ES'),
    );
    if (picked != null) {
      controller.text = picked.toString().substring(0, 10);
      date = controller.text;
    }
  }
}

class ScheduleInformation extends StatefulWidget {
  ScheduleInformation(
      {Key? key, required this.id, this.scaffoldKey, required this.date})
      : super(key: key);
  final int id;
  final scaffoldKey;
  String date;

  @override
  _ScheduleInformationState createState() => _ScheduleInformationState();
}

class _ScheduleInformationState extends State<ScheduleInformation> {
  final ScheduleProvider scheduleProvider = new ScheduleProvider();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: scheduleProvider.getSchedules(widget.id, context),
      builder: (BuildContext context, AsyncSnapshot<List<Schedule>> snapshot) {
        if (snapshot.hasData) {
          final schedules = snapshot.data;

          return (schedules!.length == 0)
              ? Container(
                  child: Center(
                    child: Text(
                      'No hay Horarios.',
                      style: TextStyle(color: Colors.black54, fontSize: 16),
                    ),
                  ),
                )
              : ListView.builder(
                  itemCount: schedules.length,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      child: Container(
                        margin: EdgeInsets.all(10),
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Color.fromRGBO(0, 76, 211, 1),
                        ),
                        child: Column(
                          children: [
                            Text(
                              (schedules[index].dia ?? ''),
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500),
                            ),
                            SizedBox(
                              height: 12,
                            ),
                            Row(
                              children: [
                                Text(
                                  schedules[index]
                                      .horaInicio!
                                      .substring(11)
                                      .replaceAll(new RegExp('Z'), ''),
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                                Expanded(child: Container()),
                                Icon(Icons.arrow_forward),
                                Expanded(child: Container()),
                                Text(
                                  schedules[index]
                                      .horaFin!
                                      .substring(11)
                                      .replaceAll(new RegExp('Z'), ''),
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                      onTap: () =>
                          _createReservation(context, schedules[index]),
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

  _createReservation(BuildContext context, Schedule schedule) async {
    final ReservationProvider reservationProvider = new ReservationProvider();
    print(widget.date);
    final Reservas reserva = new Reservas(
        doctorId: widget.id, horarioId: schedule.id, fecha: widget.date);
    final result =
        await reservationProvider.createReservation(context, reserva);
    if (result) {
      Navigator.of(context).pushReplacementNamed('main');
    } else {
      _showMessage(
          'NO SE PUDO REGISTRAR SU RESERVA. INTÉNTELO NUEVAMENTE POR FAVOR.');
    }
  }

  _showMessage(String message) {
    final snackBar = SnackBar(
      content: Text(message),
      duration: Duration(milliseconds: 1500),
    );
    widget.scaffoldKey.currentState.showSnackBar(snackBar);
  }
}
