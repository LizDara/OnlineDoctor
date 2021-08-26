import 'package:flutter/material.dart';
import 'package:online_doctor/src/providers/user_provider.dart';
import 'package:provider/provider.dart';

class UserPage extends StatelessWidget {
  UserPage({Key? key}) : super(key: key);
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [FormButton(scaffoldKey: scaffoldKey)],
      ),
    );
  }
}

class FormButton extends StatefulWidget {
  const FormButton({Key? key, @required this.scaffoldKey}) : super(key: key);
  final scaffoldKey;
  @override
  _FormButtonState createState() => _FormButtonState();
}

class _FormButtonState extends State<FormButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 60, bottom: 20, left: 25, right: 14),
      child: Column(
        children: <Widget>[
          _createInformation(),
          SizedBox(
            height: 20,
          ),
          _createEditProfileButton(context),
          _createChangePasswordButton(context),
          _createLine(),
          _createLogoutButton(context),
        ],
      ),
    );
  }

  Widget _createInformation() {
    return Row(
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              height: 70,
              width: 70,
              child: Image(
                image: AssetImage('assets/psiquiatría.png'),
                fit: BoxFit.contain,
              ),
            ),
            Text(
              'Usuario',
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ],
    );
  }

  Widget _createEditProfileButton(BuildContext context) {
    return Row(
      children: <Widget>[
        Icon(Icons.edit, size: 30, color: Colors.black87),
        SizedBox(
          width: 14,
        ),
        Text(
          'Editar perfil',
          style: TextStyle(fontSize: 16, color: Colors.black87),
        ),
        Expanded(child: Container()),
        IconButton(
            icon:
                Icon(Icons.arrow_forward_ios, size: 16, color: Colors.black87),
            onPressed: () => Navigator.pushNamed(context, 'account'))
      ],
    );
  }

  Widget _createChangePasswordButton(BuildContext context) {
    return Row(
      children: <Widget>[
        Icon(Icons.lock_outline, size: 30, color: Colors.black87),
        SizedBox(
          width: 14,
        ),
        Text(
          'Cambiar contraseña',
          style: TextStyle(fontSize: 16, color: Colors.black87),
        ),
        Expanded(child: Container()),
        IconButton(
            icon:
                Icon(Icons.arrow_forward_ios, size: 16, color: Colors.black87),
            onPressed: () => Navigator.pushNamed(context, 'password'))
      ],
    );
  }

  Widget _createLine() {
    return Row(
      children: <Widget>[
        Expanded(
            child: Container(
          margin: EdgeInsets.only(top: 20, bottom: 20, left: 4, right: 18),
          height: 1.5,
          color: Colors.black87,
        )),
      ],
    );
  }

  Widget _createLogoutButton(BuildContext context) {
    return Row(
      children: <Widget>[
        Icon(Icons.exit_to_app, size: 30, color: Colors.black87),
        SizedBox(
          width: 14,
        ),
        Text(
          'Cerrar sesión',
          style: TextStyle(fontSize: 16, color: Colors.black87),
        ),
        Expanded(child: Container()),
        IconButton(
            icon:
                Icon(Icons.arrow_forward_ios, size: 16, color: Colors.black87),
            onPressed: () => _logout(context))
      ],
    );
  }

  _logout(BuildContext context) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    await userProvider.clearTokens();
    Navigator.pushReplacementNamed(context, 'signin');
  }
}
