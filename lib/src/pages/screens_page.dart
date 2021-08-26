import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:online_doctor/src/pages/date_page.dart';
import 'package:online_doctor/src/pages/home_page.dart';
import 'package:online_doctor/src/pages/reservations_page.dart';
import 'package:online_doctor/src/pages/user_page.dart';

class MainScreen extends StatefulWidget {
  MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int pageIndex = 0;
  List<Widget> pageList = <Widget>[
    HomePage(),
    ReservationsPage(),
    DatePage(),
    UserPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageTransitionSwitcher(
        transitionBuilder: (child, primaryAnimation, secondaryAnimation) =>
            FadeScaleTransition(
          animation: primaryAnimation,
          child: child,
        ),
        duration: Duration(seconds: 1, milliseconds: 40),
        child: pageList[pageIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: pageIndex,
        backgroundColor: Colors.lightBlue[200],
        selectedItemColor: Colors.white70,
        showUnselectedLabels: false,
        onTap: (value) {
          setState(() {
            pageIndex = value;
          });
        },
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text(
              'Inicio',
              style: TextStyle(fontSize: 10),
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bookmark),
            title: Text(
              'Reservas',
              style: TextStyle(fontSize: 10),
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.confirmation_number),
            title: Text(
              'Citas',
              style: TextStyle(fontSize: 10),
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            title: Text(
              'Perfil',
              style: TextStyle(fontSize: 10),
            ),
          ),
        ],
      ),
    );
  }
}
