import 'dart:io';

import 'package:flutter/material.dart';
import 'package:jitsi_meet/jitsi_meet.dart';

class MeetingPage extends StatefulWidget {
  const MeetingPage({Key? key}) : super(key: key);

  @override
  _MeetingPageState createState() => _MeetingPageState();
}

class _MeetingPageState extends State<MeetingPage> {
  final roomText = TextEditingController(text: "elc103-215057376");
  final subjectText = TextEditingController(
      text: "Tópicos avanzados de programación"); //ESPECIALIDAD
  final nameText = TextEditingController(text: "Diego Ilich");
  final emailText = TextEditingController(text: "usuario@gmail.com");
  bool? isAudioOnly = true;
  bool? isAudioMuted = true;
  bool? isVideoMuted = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    JitsiMeet.addListener(JitsiMeetingListener(
        onConferenceWillJoin: _onConferenceWillJoin,
        onConferenceJoined: _onConferenceJoined,
        onConferenceTerminated: _onConferenceTerminated,
        onError: _onError));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    JitsiMeet.removeAllListeners();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Unirse a una reunión'),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 16.0,
        ),
        child: meetConfig(),
      ),
    );
  }

  Widget meetConfig() {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: 14.0,
          ),
          TextField(
            controller: roomText,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: "Nombre de la sala",
            ),
          ),
          SizedBox(
            height: 14.0,
          ),
          TextField(
            controller: subjectText,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: "Asunto de la reunión",
            ),
          ),
          SizedBox(
            height: 14.0,
          ),
          TextField(
            controller: nameText,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: "Nombre(s)",
            ),
          ),
          SizedBox(
            height: 14.0,
          ),
          TextField(
            controller: emailText,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: "Correo electrónico",
            ),
          ),
          SizedBox(
            height: 14.0,
          ),
          CheckboxListTile(
              title: Text("Solo audio"),
              value: isAudioOnly,
              onChanged: _onAudioOnlyChanged),
          SizedBox(
            height: 14.0,
          ),
          CheckboxListTile(
            title: Text("Desactivar micrófono"),
            value: isAudioMuted,
            onChanged: _onAudioMutedChanged,
          ),
          SizedBox(
            height: 14.0,
          ),
          CheckboxListTile(
            title: Text("Desactivar vídeo"),
            value: isVideoMuted,
            onChanged: _onVideoMutedChanged,
          ),
          Divider(
            height: 48.0,
            thickness: 2.0,
          ),
          SizedBox(
            height: 64.0,
            width: double.maxFinite,
            child: ElevatedButton(
              onPressed: () {
                _joinMeeting();
              },
              child: Text("UNIRSE", style: TextStyle(color: Colors.white)),
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateColor.resolveWith((states) => Colors.blue)),
            ),
          ),
          SizedBox(
            height: 48.0,
          )
        ],
      ),
    );
  }

  _onAudioOnlyChanged(bool? value) {
    setState(() {
      isAudioOnly = value;
    });
  }

  _onAudioMutedChanged(bool? value) {
    setState(() {
      isAudioMuted = value;
    });
  }

  _onVideoMutedChanged(bool? value) {
    setState(() {
      isVideoMuted = value;
    });
  }

  _joinMeeting() async {
    Map<FeatureFlagEnum, bool> featureFlags = {
      FeatureFlagEnum.WELCOME_PAGE_ENABLED: false,
    };

    if (Platform.isAndroid) {
      featureFlags[FeatureFlagEnum.CALL_INTEGRATION_ENABLED] = false;
    } else if (Platform.isIOS) {
      featureFlags[FeatureFlagEnum.PIP_ENABLED] = false;
    }

    //Define meetings options here
    var options = JitsiMeetingOptions(room: roomText.text)
      ..serverURL = null
      ..subject = subjectText.text
      ..userDisplayName = nameText.text
      ..userEmail = emailText.text
      ..iosAppBarRGBAColor = "#0080FF80"
      ..audioOnly = isAudioOnly
      ..audioMuted = isAudioMuted
      ..videoMuted = isVideoMuted
      ..featureFlags.addAll(featureFlags)
      ..webOptions = {
        "roomName": roomText.text,
        "width": "100%",
        "height": "100%",
        "enableWelcomePage": false,
        "chromeExtensionBanner": null,
        "userInfo": {"displayName": nameText.text}
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

  void _onConferenceWillJoin(message) {
    debugPrint("_onConferenceWillJoin broadcasted with message: $message");
  }

  void _onConferenceJoined(message) {
    debugPrint("_onConferenceJoined broadcasted with message: $message");
  }

  void _onConferenceTerminated(message) {
    debugPrint("_onConferenceTerminated broadcasted with message: $message");
  }

  _onError(error) {
    debugPrint("_onError broadcasted: $error");
  }
}
