import 'package:flutter/material.dart';
import 'package:online_doctor/src/models/doctor_model.dart';
import 'package:online_doctor/src/models/specialty_model.dart';
import 'package:online_doctor/src/providers/doctor_provider.dart';

class DoctorPage extends StatelessWidget {
  const DoctorPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Specialty specialty =
        ModalRoute.of(context)!.settings.arguments as Specialty;

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
                  specialty.nombre ?? '',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                Text(
                  'Doctores:',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(
                right: 10,
                left: 10,
                top: MediaQuery.of(context).size.height / 8),
            child: DoctorInformation(
              id: specialty.id ?? 0,
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
}

class DoctorInformation extends StatelessWidget {
  DoctorInformation({Key? key, required this.id}) : super(key: key);
  final int id;
  final DoctorProvider doctorProvider = new DoctorProvider();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: doctorProvider.getDoctors(id, context),
      builder: (BuildContext context, AsyncSnapshot<List<Doctor>> snapshot) {
        if (snapshot.hasData) {
          final doctors = snapshot.data;

          return (doctors!.length == 0)
              ? Container(
                  child: Center(
                    child: Text(
                      'No hay Doctores.',
                      style: TextStyle(color: Colors.black54, fontSize: 16),
                    ),
                  ),
                )
              : ListView.builder(
                  itemCount: doctors.length,
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
                              (doctors[index].persona.nombres ?? '') +
                                  ' ' +
                                  (doctors[index].persona.apellidos ?? ''),
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              doctors[index].persona.telefono.toString() +
                                  ' - ' +
                                  (doctors[index].doctor.direccionLaboral ??
                                      ''),
                              style:
                                  TextStyle(fontSize: 14, color: Colors.white),
                            )
                          ],
                        ),
                      ),
                      onTap: () => Navigator.of(context)
                          .pushNamed('schedules', arguments: doctors[index]),
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
}
