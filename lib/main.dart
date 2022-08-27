import 'package:flutter/material.dart';
import 'package:dart_math/algebra.dart';

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
  final TextEditingController _a = TextEditingController();
  final TextEditingController _b = TextEditingController();
  final TextEditingController _c = TextEditingController();

  String _result = "";
  @override
  void initState() {
    super.initState();
    limpaCampos();
  }

  void limpaCampos() {
    _a.text = '';
    _b.text = '';
    _c.text = '';
    setState(() {
      _result = '';
    });
  }

  void calcularSalarioLiquido() {
    final a = double.parse(_a.text);
    final b = double.parse(_b.text);
    final c = double.parse(_c.text);
    final raizes = Quadratic(a, b, c);
    setState(() {
      _result = "Delta = ${raizes.discriminant()}\n Raízes: ${raizes.roots()}";
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
        child: Text('Calcular Equação', style: TextStyle(color: Colors.red)),
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
      title: Text('Calculadora de Equação'),
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
          buildTextFormField(label: "A²", error: "Informe A²!", controller: _a),
          buildTextFormField(label: "B", error: "Informe o B!", controller: _b),
          buildTextFormField(label: "C", error: "Informe o C!", controller: _c),
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