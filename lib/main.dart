import 'package:flutter/material.dart';

void main() => runApp(
      MaterialApp(
        home: Home(),
        debugShowCheckedModeBanner: false,
      ),
    );

class Home extends StatefulWidget {
  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _nome = TextEditingController();

  final TextEditingController _sexo = TextEditingController();

  final TextEditingController _altura = TextEditingController();

  final TextEditingController _peso = TextEditingController();

  String _result = "";

  @override
  void initState() {
    super.initState();

    limpaCampos();
  }

  void limpaCampos() {
    _nome.text = '';

    _sexo.text = '';

    _altura.text = '';

    _peso.text = '';

    setState(() {
      _result = '';
    });
  }

  void calcularImc() {
    final num peso = num.parse(_peso.text);

    final num altura = num.parse(_altura.text);

    final num imc = (peso / (altura * altura));

    if (imc < 18.5) {
      setState(() {
        _result =
            "IMC=${imc.toStringAsFixed(1)}\n\n Você está abaixo do IMC, classificado como 'Muito magro'";
      });
    }
    if (imc > 18.5 && imc < 24.9) {
      setState(() {
        _result =
            "IMC=${imc.toStringAsFixed(1)}\n\n IMC normal, classificado como 'Normal'";
      });
    }
    if (imc > 25 && imc < 29.9) {
      setState(() {
        _result =
            "IMC=${imc.toStringAsFixed(1)}\n\n Você está acima do IMC, classificado como 'Sobrepeso'";
      });
    }
    if (imc > 30 && imc < 34.9) {
      setState(() {
        _result =
            "IMC=${imc.toStringAsFixed(1)}\n\n Você está bem acima do IMC, classificado como 'Obeso grau I'";
      });
    }
    if (imc > 35 && imc < 39.9) {
      setState(() {
        _result =
            "IMC=${imc.toStringAsFixed(1)}\n\n Você está muito do IMC, classificado como 'Obeso grau II'";
      });
    }
    if (imc > 40) {
      setState(() {
        _result =
            "IMC=${imc.toStringAsFixed(1)}\n\n Você está extremamente acima do IMC, classificado como 'Obeso grau III ou Mórbido'";
      });
    }
  }

  Widget buildCalcularButton() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 36.0),
      child: RaisedButton(
        onPressed: () {
          if (_formKey.currentState != null) {
            calcularImc();
          }
        },
        child: Text('Calcular',
            style: TextStyle(color: Color.fromARGB(255, 0, 0, 0))),
      ),
    );
  }

  Widget buildTextResult() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 36.0),
      child: Text(
        _result,
        textAlign: TextAlign.center,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: buildAppBar(),
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
        body: SingleChildScrollView(
            padding: EdgeInsets.all(20.0), child: buildForm()));
  }

  AppBar buildAppBar() {
    return AppBar(
      title: Text('Calculadora de IMC'),
      backgroundColor: Color.fromARGB(255, 248, 246, 117),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.calculate_outlined),
          onPressed: () {
            limpaCampos();
          },
        )
      ],
    );
  }

  Form buildForm() {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          buildTextFormField(
              label: "Nome", error: "Insira o seu nome.", controller: _nome),
          buildTextFormField(
              label: "Sexo", error: "Insira o seu sexo.", controller: _sexo),
          buildTextFormField(
              label: "Altura",
              error: "Insira a sua altura.",
              controller: _altura),
          buildTextFormField(
              label: "Peso", error: "Insira o seu peso.", controller: _peso),
          buildTextResult(),
          buildCalcularButton(),
        ],
      ),
    );
  }

  TextFormField buildTextFormField(
      {required TextEditingController controller,
      required String error,
      required String label}) {
    return TextFormField(
      keyboardType: TextInputType.number,
      decoration: InputDecoration(labelText: label),
      controller: controller,
      validator: (text) {
        //verifica se o valor foi digitado

        return text!.isEmpty ? error : null;
      },
    );
  }
}
