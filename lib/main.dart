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
  final TextEditingController _salarioBruto = TextEditingController();

  String _result = "";
  @override
  void initState() {
    super.initState();
    limpaCampos();
  }

  void limpaCampos() {
    _salarioBruto.text = '';
    setState(() {
      _result = '';
    });
  }

  void calcularSalarioLiquido() {
    final double salarioLiquido = (double.parse(_salarioBruto.text) - (double.parse(_salarioBruto.text)*0.15));
    setState(() {
      _result =
          "Salário Líquido = ${salarioLiquido.toStringAsFixed(2)}\n";
    });
  }

  Widget buildCalcularButton() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 36.0),
      child: RaisedButton(
        onPressed: () {
          if (_formKey.currentState != null) {
            calcularSalarioLiquido();
          }
        },
        child: Text('Calcular Valor líquido', style: TextStyle(color: Colors.red)),
      ),
    );
  }

  //método para configurar o resultado em uma Text
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
        backgroundColor: Colors.blue[100],
        body: SingleChildScrollView(
            padding: EdgeInsets.all(20.0), child: buildForm()));
  }

  AppBar buildAppBar() {
    return AppBar(
      title: Text('Calculadora de Salário'),
      backgroundColor: Colors.blue,
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.clear),
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
              label: "Salário bruto",
              error: "Informe o valor do salário bruto!",
              controller: _salarioBruto),
          buildTextResult(),
          buildCalcularButton(),
        ],
      ),
    );
  }

  //formatar e exibir msg de erro nos inputs (entrada
  //de dados)
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
