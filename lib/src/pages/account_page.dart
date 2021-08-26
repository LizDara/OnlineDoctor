import 'package:flutter/material.dart';
import 'package:online_doctor/src/models/pacient_model.dart';
import 'package:online_doctor/src/models/user_model.dart';
import 'package:online_doctor/src/providers/pacient_provider.dart';

class AccountPage extends StatelessWidget {
  AccountPage({Key? key}) : super(key: key);
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      body: Stack(
        children: [
          _createBackground(context),
          AccountForm(
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

class AccountForm extends StatefulWidget {
  AccountForm({Key? key, this.scaffoldKey}) : super(key: key);
  final scaffoldKey;

  @override
  _AccountFormState createState() => _AccountFormState();
}

class _AccountFormState extends State<AccountForm> {
  final formKey = GlobalKey<FormState>();
  final controller = new TextEditingController(text: '');
  List<String> genders = ['Femenino', 'Masculino'];
  final PacientProvider pacientProvider = new PacientProvider();

  User user = new User();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: pacientProvider.getPacient(context),
      builder: (BuildContext context, AsyncSnapshot<User> snapshot) {
        if (snapshot.hasData) {
          user = snapshot.data!;
          controller.text = user.fechaNacimiento!.substring(0, 10);
          user.fechaNacimiento = user.fechaNacimiento!.substring(0, 10);

          return Center(
            child: SingleChildScrollView(
              child: Container(
                margin: EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: MediaQuery.of(context).size.height / 5),
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
                            'Mi perfil',
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
                          _createRegisterButton(context),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
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

  Widget _createInputName() {
    return TextFormField(
      keyboardType: TextInputType.text,
      initialValue: user.nombres,
      decoration: InputDecoration(
        labelText: 'Nombres',
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
      ),
      onSaved: (value) => user.nombres = value,
    );
  }

  Widget _createInputLastName() {
    return TextFormField(
      keyboardType: TextInputType.text,
      initialValue: user.apellidos,
      decoration: InputDecoration(
        labelText: 'Apellidos',
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
      ),
      onSaved: (value) => user.apellidos = value,
    );
  }

  Widget _createInputCI() {
    return TextFormField(
      keyboardType: TextInputType.number,
      initialValue: user.ci.toString(),
      decoration: InputDecoration(
        labelText: 'CI',
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
      ),
      onSaved: (value) => user.ci = int.parse(value!),
    );
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
      onSaved: (value) => user.fechaNacimiento = value,
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
      user.fechaNacimiento = controller.text;
    }
  }

  Widget _createInputTelephone() {
    return TextFormField(
      keyboardType: TextInputType.number,
      initialValue: user.telefono.toString(),
      decoration: InputDecoration(
        labelText: 'Teléfono',
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
      ),
      onSaved: (value) => user.telefono = int.parse(value!),
    );
  }

  Widget _createInputDirection() {
    return TextFormField(
      keyboardType: TextInputType.text,
      initialValue: user.direccionDomicilio,
      decoration: InputDecoration(
        labelText: 'Dirección de Domicilio',
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
      ),
      onSaved: (value) => user.direccionDomicilio = value,
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
                'GUARDAR',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ),
      ],
    );
  }

  _register(BuildContext context) async {
    final PacientProvider pacientProvider = new PacientProvider();
    final Pacient pacient = new Pacient(
        persona: new Persona(
            nombres: user.nombres,
            apellidos: user.apellidos,
            telefono: user.telefono,
            ci: user.ci),
        paciente: new Paciente(
            direccionDomicilio: user.direccionDomicilio,
            fechaNacimiento: user.fechaNacimiento),
        usuario: new Usuario());
    final result = await pacientProvider.updatePacient(pacient, context);
    if (result) {
      Navigator.of(context).pushReplacementNamed('main');
    } else {
      _showMessage(
          'NO SE PUDO MODIFICAR LA CUENTA. INTÉNTELO NUEVAMENTE POR FAVOR.');
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
