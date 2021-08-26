import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:online_doctor/src/models/code_model.dart';
import 'package:online_doctor/src/providers/pacient_provider.dart';

class ConfirmationPage extends StatelessWidget {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context)?.settings.arguments as int;
    return Scaffold(
      key: scaffoldKey,
      body: Stack(
        children: [
          _createBackground(context),
          ConfirmForm(
            id: id,
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

class ConfirmForm extends StatefulWidget {
  ConfirmForm({Key? key, required this.id, this.scaffoldKey}) : super(key: key);
  final int id;
  final scaffoldKey;

  @override
  _ConfirmFormState createState() => _ConfirmFormState();
}

class _ConfirmFormState extends State<ConfirmForm> {
  final formKey = GlobalKey<FormState>();
  Code code = new Code();

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
                      'Código de Verificación',
                      style: TextStyle(
                          color: Colors.blue,
                          fontSize: 30,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    _createInputTelephone(),
                    SizedBox(
                      height: 20,
                    ),
                    _createInputEmail(),
                    SizedBox(
                      height: 30,
                    ),
                    _createConfirmButton(context),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _createInputTelephone() {
    return TextFormField(
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: 'Código Teléfono',
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
      ),
      onSaved: (value) => code.telefonoCodigo = int.parse(value!),
    );
  }

  Widget _createInputEmail() {
    return TextFormField(
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: 'Código Correo',
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
      ),
      onSaved: (value) => code.correoElectronicoCodigo = int.parse(value!),
    );
  }

  Widget _createConfirmButton(BuildContext context) {
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
                _confirmCode(context);
              },
              child: Text(
                'CONFIRMAR',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ),
      ],
    );
  }

  _confirmCode(BuildContext context) async {
    print(widget.id);
    code.personaId = widget.id;
    final PacientProvider pacientProvider = new PacientProvider();
    final result = await pacientProvider.checkData(code);
    if (result) {
      Navigator.of(context).pushReplacementNamed('signin');
    } else {
      _showMessage(
          'LOS CÓDIGOS SON INCORRECTOS, INTÉNTELO NUEVAMENTE POR FAVOR.');
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
