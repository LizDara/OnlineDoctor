import 'package:flutter/material.dart';
import 'package:online_doctor/src/models/pacient_model.dart';
import 'package:online_doctor/src/providers/user_provider.dart';
import 'package:provider/provider.dart';

class ChangePasswordPage extends StatefulWidget {
  ChangePasswordPage({Key? key}) : super(key: key);

  @override
  _ChangePasswordPageState createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      body: Stack(
        children: [
          _createBackground(context),
          FormChangePassword(
            scaffoldKey: scaffoldKey,
          ),
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
}

class FormChangePassword extends StatefulWidget {
  const FormChangePassword({Key? key, this.scaffoldKey}) : super(key: key);
  final scaffoldKey;

  @override
  _FormChangePasswordState createState() => _FormChangePasswordState();
}

class _FormChangePasswordState extends State<FormChangePassword> {
  final Usuario user = new Usuario();
  String _confirmPassword = '';

  final formKey = GlobalKey<FormState>();

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
                      'Modificar Contraseña',
                      style: TextStyle(
                          color: Colors.blue,
                          fontSize: 30,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    _createNewPassword(),
                    SizedBox(
                      height: 20,
                    ),
                    _createConfirmPassword(),
                    SizedBox(
                      height: 30,
                    ),
                    _createSignUpButton(context),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _createNewPassword() {
    return TextFormField(
      keyboardType: TextInputType.text,
      autocorrect: false,
      obscureText: true,
      decoration: InputDecoration(
        labelText: 'Nueva Contraseña',
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
      ),
      validator: (value) {
        return (value != null && value.length >= 6)
            ? null
            : 'La contraseña debe tener más de 6 caracteres por favor';
      },
      onSaved: (value) => user.contrasena = value!,
    );
  }

  Widget _createConfirmPassword() {
    return TextFormField(
      keyboardType: TextInputType.text,
      obscureText: true,
      decoration: InputDecoration(
        labelText: 'Confirmar Contraseña',
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
      ),
      onSaved: (value) => _confirmPassword = value!,
    );
  }

  Widget _createSignUpButton(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            clipBehavior: Clip.antiAlias,
            padding: EdgeInsets.symmetric(vertical: 5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.blue,
            ),
            child: TextButton(
              onPressed: () {
                if (!formKey.currentState!.validate()) return;
                formKey.currentState!.save();
                _save(context);
              },
              child: Text(
                'GUARDAR',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ),
      ],
    );
  }

  _save(BuildContext context) async {
    if (_confirmPassword == user.contrasena) {
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      final result = await userProvider.updatePassword(context, user);
      if (result) {
        await userProvider.clearTokens();
        Navigator.pushReplacementNamed(context, 'signin');
      } else {
        _showMessage(
            'No se pudo modificar la contraseña. Inténtelo nuevamente por favor.');
      }
    } else {
      _showMessage('Las contraseñas no coinciden. Favor de verificar.');
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
