import 'dart:io';

import 'package:flutter/material.dart';
import 'package:online_doctor/src/models/pacient_model.dart';
import 'package:online_doctor/src/providers/pacient_provider.dart';
import 'package:image_picker/image_picker.dart';

class SignUpPage extends StatefulWidget {
  SignUpPage({Key? key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  File image = new File('');

  bool _existImage = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      body: Stack(
        children: [
          _createBackground(context),
          _createPhoto(),
          SignupForm(
            scaffoldKey: scaffoldKey,
            image: image,
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

  Widget _createPhoto() {
    return Container(
      clipBehavior: Clip.antiAlias,
      margin: EdgeInsets.all(20),
      height: 100,
      width: 100,
      decoration: BoxDecoration(
          color: Colors.grey[100], borderRadius: BorderRadius.circular(180)),
      child: (!_existImage)
          ? IconButton(
              icon: Icon(
                Icons.add,
                size: 40,
              ),
              onPressed: () async {
                final picker = new ImagePicker();
                final XFile? pickedFile =
                    await picker.pickImage(source: ImageSource.gallery);

                if (pickedFile == null) {
                  print('No se seleccionó nada');
                  return;
                }
                print('Tenemos imagen ${pickedFile.path}');
                image = File.fromUri(Uri(path: pickedFile.path));
                _existImage = true;
                setState(() {});
              },
            )
          : Image(
              image: FileImage(image),
              fit: BoxFit.contain,
            ),
    );
  }
}

class SignupForm extends StatefulWidget {
  SignupForm({Key? key, this.scaffoldKey, this.image}) : super(key: key);
  final scaffoldKey;
  final image;

  @override
  _SignupFormState createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
  Pacient pacient = new Pacient(
      persona: new Persona(),
      usuario: new Usuario(),
      paciente: new Paciente(sexo: 'F'));

  final formKey = GlobalKey<FormState>();
  final controller = new TextEditingController(text: '');
  List<String> genders = ['Femenino', 'Masculino'];
  String _confirmPassword = '';

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(
              horizontal: 15, vertical: MediaQuery.of(context).size.height / 5),
          child: Card(
            color: Colors.white,
            elevation: 20,
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 24, horizontal: 18),
              child: Form(
                key: formKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Registrate Aquí!',
                      style: TextStyle(
                          color: Colors.blue,
                          fontSize: 30,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    _createInputName(),
                    SizedBox(
                      height: 20,
                    ),
                    _createInputLastName(),
                    SizedBox(
                      height: 20,
                    ),
                    _createInputCI(),
                    SizedBox(
                      height: 20,
                    ),
                    _createInputGender(),
                    SizedBox(
                      height: 20,
                    ),
                    _createInputBirth(),
                    SizedBox(
                      height: 20,
                    ),
                    _createInputTelephone(),
                    SizedBox(
                      height: 20,
                    ),
                    _createInputDirection(),
                    SizedBox(
                      height: 20,
                    ),
                    _createInputEmail(),
                    SizedBox(
                      height: 20,
                    ),
                    _createInputPassword(),
                    SizedBox(
                      height: 20,
                    ),
                    _createInputConfirmPassword(),
                    SizedBox(
                      height: 30,
                    ),
                    _createRegisterButton(context),
                    SizedBox(
                      height: 10,
                    ),
                    _createSignInButton(context),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _createInputName() {
    return TextFormField(
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        labelText: 'Nombres',
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
      ),
      onSaved: (value) => pacient.persona.nombres = value,
    );
  }

  Widget _createInputLastName() {
    return TextFormField(
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        labelText: 'Apellidos',
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
      ),
      onSaved: (value) => pacient.persona.apellidos = value,
    );
  }

  Widget _createInputCI() {
    return TextFormField(
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: 'CI',
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
      ),
      onSaved: (value) => pacient.persona.ci = int.parse(value!),
    );
  }

  Widget _createInputGender() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5.5),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(20)),
      child: DropdownButton(
        isExpanded: true,
        underline: Container(),
        value: pacient.paciente.sexo,
        items: _getOptions(),
        onChanged: (opt) {
          setState(() {
            pacient.paciente.sexo = opt.toString();
          });
        },
      ),
    );
  }

  List<DropdownMenuItem<String>> _getOptions() {
    List<DropdownMenuItem<String>> list = [];
    genders.forEach((option) {
      list.add(DropdownMenuItem(
        child: Text(option),
        value: (option == 'Femenino') ? 'F' : 'M',
      ));
    });
    return list;
  }

  Widget _createInputBirth() {
    return TextFormField(
      decoration: InputDecoration(
          labelText: 'Fecha de Nacimiento',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
          )),
      controller: controller,
      onTap: () {
        FocusScope.of(context).requestFocus(new FocusNode());
        _selectDate(context);
      },
      onSaved: (value) => pacient.paciente.fechaNacimiento = value,
    );
  }

  _selectDate(BuildContext context) async {
    DateTime now = new DateTime.now();
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: new DateTime(now.year - 11),
      firstDate: new DateTime(now.year - 80),
      lastDate: new DateTime(now.year - 10),
      //locale: Locale('es', 'ES'),
    );
    if (picked != null) {
      controller.text = picked.toString().substring(0, 10);
    }
  }

  Widget _createInputTelephone() {
    return TextFormField(
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: 'Teléfono',
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
      ),
      onSaved: (value) => pacient.persona.telefono = int.parse(value!),
    );
  }

  Widget _createInputDirection() {
    return TextFormField(
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        labelText: 'Dirección de Domicilio',
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
      ),
      onSaved: (value) => pacient.paciente.direccionDomicilio = value,
    );
  }

  Widget _createInputEmail() {
    return TextFormField(
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
      onSaved: (value) => pacient.usuario.correoElectronico = value,
    );
  }

  Widget _createInputPassword() {
    return TextFormField(
      obscureText: true,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        labelText: 'Contraseña',
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
      ),
      validator: (value) {
        return (value != null && value.length >= 8)
            ? null
            : 'La contraseña debe tener más de 8 caracteres por favor';
      },
      onSaved: (value) => pacient.usuario.contrasena = value,
    );
  }

  Widget _createInputConfirmPassword() {
    return TextFormField(
      obscureText: true,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        labelText: 'Confimar Contraseña',
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
      ),
      validator: (value) {
        return (value != null && value.length >= 8)
            ? null
            : 'La contraseña debe tener más de 8 caracteres por favor';
      },
      onSaved: (value) => _confirmPassword = value!,
    );
  }

  Widget _createRegisterButton(BuildContext context) {
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
                _register(context);
              },
              child: Text(
                'REGISTRAR',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ),
      ],
    );
  }

  _register(BuildContext context) async {
    if (_confirmPassword == pacient.usuario.contrasena) {
      final PacientProvider pacientProvider = new PacientProvider();
      final result = await pacientProvider.register(pacient);
      if (result != null) {
        await pacientProvider.uploadImage(widget.image, result.persona.id ?? 0);
        Navigator.of(context)
            .pushReplacementNamed('confirmation', arguments: result.persona.id);
      } else {
        _showMessage(
            'NO SE PUDO REGISTRAR LA CUENTA. INTÉNTELO NUEVAMENTE POR FAVOR.');
      }
    } else {
      _showMessage('LAS CONTRASEÑAS NO COINCIDEN');
    }
  }

  Widget _createSignInButton(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Ya tienes una cuenta?',
                style: TextStyle(fontSize: 13),
              ),
              TextButton(
                onPressed: () =>
                    Navigator.of(context).pushReplacementNamed('signin'),
                child: Text(
                  'Inicia Sesión aquí.',
                  style: TextStyle(fontSize: 13),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }

  _showMessage(String message) {
    final snackBar = SnackBar(
      content: Text(message),
      duration: Duration(milliseconds: 1500),
    );
    widget.scaffoldKey.currentState.showSnackBar(snackBar);
  }
}
