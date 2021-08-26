import 'package:flutter/material.dart';
import 'package:online_doctor/src/pages/home_page.dart';
import 'package:online_doctor/src/pages/screens_page.dart';
import 'package:online_doctor/src/pages/signin_page.dart';
import 'package:online_doctor/src/providers/user_provider.dart';
import 'package:provider/provider.dart';

class LoadingPage extends StatelessWidget {
  const LoadingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final UserProvider userProvider =
        Provider.of<UserProvider>(context, listen: false);

    return Scaffold(
      body: FutureBuilder(
        future: userProvider.readToken(),
        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
          if (!snapshot.hasData) {
            return Center(child: Text('ESPERE...'));
          }

          if (snapshot.data == '') {
            Future.microtask(() {
              Navigator.pushReplacement(
                context,
                PageRouteBuilder(
                  pageBuilder: (_, __, ___) => SignInPage(),
                  transitionDuration: Duration(seconds: 0),
                ),
              );
            });
          } else {
            Future.microtask(() {
              Navigator.pushReplacement(
                context,
                PageRouteBuilder(
                  pageBuilder: (_, __, ___) => MainScreen(),
                  transitionDuration: Duration(seconds: 0),
                ),
              );
            });
          }

          return Container();
        },
      ),
    );
  }
}
