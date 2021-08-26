import 'package:flutter/material.dart';
import 'package:online_doctor/src/models/pacient_model.dart';
import 'package:online_doctor/src/providers/user_provider.dart';
import 'package:provider/provider.dart';

class SignInPage extends StatelessWidget {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      body: Stack(
        children: [
          _createBackground(context),
          SigninForm(
            scaffoldKey: scaffoldKey,
          ),
          _createSignUpButton(context),
        ],
      ),
    );
  }

  Widget _createBackground(BuildContext context) {
    return Positioned(
      left: -200,
      right: -200,
      top: -250,
      child: Container(
        height: MediaQuery.of(context).size.height,
        width: 1000,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(360), color: Colors.blue),
      ),
    );
  }

  Widget _createSignUpButton(BuildContext context) {
    return Positioned(
      top: MediaQuery.of(context).size.height - 100,
      left: 12,
      right: 12,
      child: Row(
        children: [
          Text('Todavía no tienes una cuenta?'),
          TextButton(
            onPressed: () => Navigator.of(context).pushNamed('signup'),
            child: Text('Regístrate aquí.'),
          )
        ],
      ),
    );
  }
}

class SigninForm extends StatefulWidget {
  SigninForm({this.scaffoldKey});
  final scaffoldKey;
  @override
  _SigninFormState createState() => _SigninFormState();
}

class _SigninFormState extends State<SigninForm> {
  final formKey = GlobalKey<FormState>();
  Usuario user = new Usuario();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(
              horizontal: 20, vertical: MediaQuery.of(context).size.height / 5),
          child: Card(
            color: Colors.white,
            elevation: 20,
            child: Container(
              padding: EdgeInsets.all(20),
              child: Form(
                key: formKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Inicia Sesión!',
                      style: TextStyle(
                          color: Colors.blue,
                          fontSize: 30,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    _createInputEmail(),
                    SizedBox(
                      height: 20,
                    ),
                    _createInputPassword(),
                    SizedBox(
                      height: 30,
                    ),
                    _createLoginButton(context),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _createInputEmail() {
    return TextFormField(
      autocorrect: false,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        labelText: 'Correo Electrónico',
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
      ),
      validator: (value) {
        String pattern =
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
        RegExp regExp = new RegExp(pattern);
        return regExp.hasMatch(value ?? '') ? null : 'El correo es inválido.';
      },
      onSaved: (value) => user.correoElectronico = value,
    );
  }

  Widget _createInputPassword() {
    return TextFormField(
      obscureText: true,
      decoration: InputDecoration(
        labelText: 'Contraseña',
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
      ),
      onSaved: (value) => user.contrasena = value,
    );
  }

  Widget _createLoginButton(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            clipBehavior: Clip.antiAlias,
            padding: EdgeInsets.symmetric(vertical: 4),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.blue,
            ),
            child: TextButton(
              onPressed: () {
                if (!formKey.currentState!.validate()) return;
                formKey.currentState!.save();
                _login(context);
              },
              child: Text(
                'LOGIN',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ),
      ],
    );
  }

  _login(BuildContext context) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final result = await userProvider.login(user);
    if (result) {
      Navigator.of(context).pushReplacementNamed('main');
    } else {
      _showMessage(
          'NO SE PUDO INICIAR SESIÓN. INTÉNTELO NUEVAMENTE POR FAVOR.');
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
