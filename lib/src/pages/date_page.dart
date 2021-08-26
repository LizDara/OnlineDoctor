import 'package:flutter/material.dart';
import 'package:online_doctor/src/models/date_model.dart';
import 'package:online_doctor/src/providers/date_provider.dart';
import 'package:online_doctor/src/providers/pacient_provider.dart';
import 'package:jitsi_meet/jitsi_meet.dart';
import 'dart:io';

class DatePage extends StatelessWidget {
  DatePage({Key? key}) : super(key: key);
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
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
                  'Citas:',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(
                right: 10,
                left: 10,
                top: MediaQuery.of(context).size.height / 11),
            child: DateInformation(
              scaffoldKey: scaffoldKey,
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

class DateInformation extends StatelessWidget {
  DateInformation({Key? key, this.scaffoldKey}) : super(key: key);
  final DateProvider dateProvider = new DateProvider();
  final scaffoldKey;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: dateProvider.getDates(context),
      builder: (BuildContext context, AsyncSnapshot<List<Date>> snapshot) {
        if (snapshot.hasData) {
          final dates = snapshot.data;

          return (dates!.length == 0)
              ? Container(
                  child: Center(
                    child: Text(
                      'No hay Citas.',
                      style: TextStyle(color: Colors.black54, fontSize: 16),
                    ),
                  ),
                )
              : ListView.builder(
                  itemCount: dates.length,
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
                                        (dates[index].persona.nombres ?? '') +
                                        ' ' +
                                        (dates[index].persona.apellidos ?? ''),
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                  Text(
                                    dates[index].especialidad.nombre ?? '',
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
                                horizontal: 14, vertical: 20),
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
                                  dates[index].horario.dia! +
                                      ', ' +
                                      _getDate(
                                          dates[index].cita.fechaHora ?? '') +
                                      ', ' +
                                      _getTime(
                                          dates[index].horario.horaInicio ??
                                              '') +
                                      ' - ' +
                                      _getTime(
                                          dates[index].horario.horaFin ?? ''),
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              ElevatedButton(
                                onPressed: () =>
                                    _joinMeeting(context, dates[index]),
                                child: Text('Ingresar',
                                    style: TextStyle(color: Colors.white)),
                              )
                            ],
                          )
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

  _joinMeeting(BuildContext context, Date date) async {
    final DateProvider dateProvider = new DateProvider();
    final cita = await dateProvider.getDate(date.cita.id ?? 0, context);
    print(cita.estado);
    if (cita.estado != 'En curso') {
      _showMessage('LA CITA TODAVÍA NO HA SIDO INICIADA.');
      return;
    }

    final PacientProvider pacientProvider = new PacientProvider();
    final pacient = await pacientProvider.getPacient(context);

    final url = date.cita.enlace!.split('/');

    Map<FeatureFlagEnum, bool> featureFlags = {
      FeatureFlagEnum.WELCOME_PAGE_ENABLED: false,
    };

    if (Platform.isAndroid) {
      featureFlags[FeatureFlagEnum.CALL_INTEGRATION_ENABLED] = false;
    } else if (Platform.isIOS) {
      featureFlags[FeatureFlagEnum.PIP_ENABLED] = false;
    }

    //Define meetings options here
    var options = JitsiMeetingOptions(room: url[url.length - 1])
      ..serverURL = null
      ..subject = "Tópicos avanzados de programación"
      ..userDisplayName = pacient.nombres
      ..userEmail = "usuario@gmail.com"
      ..iosAppBarRGBAColor = "#0080FF80"
      ..audioOnly = false
      ..audioMuted = false
      ..videoMuted = false
      ..featureFlags.addAll(featureFlags)
      ..webOptions = {
        "roomName": url[url.length - 1],
        "width": "100%",
        "height": "100%",
        "enableWelcomePage": false,
        "chromeExtensionBanner": null,
        "userInfo": {"displayName": pacient.nombres}
      };

    debugPrint("JitsiMeetingOptions: $options");
    await JitsiMeet.joinMeeting(options,
        listener: JitsiMeetingListener(
            onConferenceWillJoin: (message) {
              debugPrint("${options.room} will join with message: $message");
            },
            onConferenceJoined: (message) {
              debugPrint("${options.room} joined with message: $message");
            },
            onConferenceTerminated: (message) {
              debugPrint("${options.room} terminated with message: $message");
            },
            genericListeners: [
              JitsiGenericListener(
                  eventName: "readyToClose",
                  callback: (dynamic message) {
                    debugPrint("readyToClose callback");
                  })
            ]));
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

  _showMessage(String message) {
    final snackBar = SnackBar(
      content: Text(message),
      duration: Duration(milliseconds: 1500),
    );
    scaffoldKey.currentState.showSnackBar(snackBar);
  }
}
