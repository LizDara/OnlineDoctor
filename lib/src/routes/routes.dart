import 'package:flutter/cupertino.dart';
import 'package:online_doctor/src/pages/account_page.dart';
import 'package:online_doctor/src/pages/confirmation_page.dart';
import 'package:online_doctor/src/pages/doctors_page.dart';
import 'package:online_doctor/src/pages/home_page.dart';
import 'package:online_doctor/src/pages/loading_page.dart';
import 'package:online_doctor/src/pages/meeting_page.dart';
import 'package:online_doctor/src/pages/password_page.dart';
import 'package:online_doctor/src/pages/schedules_page.dart';
import 'package:online_doctor/src/pages/screens_page.dart';
import 'package:online_doctor/src/pages/signin_page.dart';
import 'package:online_doctor/src/pages/signup_page.dart';
import 'package:online_doctor/src/pages/specialties_page.dart';

Map<String, WidgetBuilder> getApplicationRoutes() {
  return <String, WidgetBuilder>{
    'loading': (BuildContext context) => LoadingPage(),
    'main': (BuildContext context) => MainScreen(),
    'signin': (BuildContext context) => SignInPage(),
    'signup': (BuildContext context) => SignUpPage(),
    'confirmation': (BuildContext context) => ConfirmationPage(),
    'account': (BuildContext context) => AccountPage(),
    'password': (BuildContext context) => ChangePasswordPage(),
    'doctors': (BuildContext context) => DoctorPage(),
    'schedules': (BuildContext context) => SchedulePage(),
    'specialties': (BuildContext context) => SpecialtyPage(),
    'meeting': (BuildContext context) => MeetingPage(),
  };
}
