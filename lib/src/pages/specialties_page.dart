import 'package:flutter/material.dart';
import 'package:online_doctor/src/models/specialty_model.dart';
import 'package:online_doctor/src/providers/specialty_provider.dart';

class SpecialtyPage extends StatelessWidget {
  const SpecialtyPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
            child: Column(
              children: [
                Text(
                  'ESPECIALIDADES',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          Container(
              margin: EdgeInsets.only(
                  right: 10,
                  left: 10,
                  top: MediaQuery.of(context).size.height / 12),
              child: SpecialtyInformation()),
        ],
      ),
    );
  }
}

class SpecialtyInformation extends StatelessWidget {
  SpecialtyInformation({
    Key? key,
  }) : super(key: key);
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
                  child: Center(
                    child: Text(
                      'No hay Especialidades.',
                      style: TextStyle(color: Colors.black54, fontSize: 16),
                    ),
                  ),
                )
              : ListView.builder(
                  itemCount: specialties.length,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      child: Container(
                        margin: EdgeInsets.all(10),
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Color.fromRGBO(8, 87, 223, 1),
                        ),
                        child: Row(
                          children: [
                            Container(
                              padding: EdgeInsets.all(10),
                              height:
                                  MediaQuery.of(context).size.height * 1 / 10,
                              width: MediaQuery.of(context).size.width * 2 / 11,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.grey[100]),
                              child: Image(
                                image: AssetImage('assets/' +
                                    specialties[index].nombre!.toLowerCase() +
                                    '.png'),
                              ),
                            ),
                            SizedBox(
                              width: 16,
                            ),
                            Text(
                              specialties[index].nombre ?? '',
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                      onTap: () => Navigator.of(context)
                          .pushNamed('doctors', arguments: specialties[index]),
                    );
                  },
                );
        } else {
          return Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white54),
            ),
          );
        }
      },
    );
  }
}
