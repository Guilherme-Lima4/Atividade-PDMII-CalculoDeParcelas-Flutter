import 'package:flutter/material.dart';

void main() {
  // ignore: prefer_const_constructors
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _info =
      "Informe o valor da primeira prestação para calcular em quantos anos o valor ultrapassará 5000 reais";

  GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  TextEditingController desccontroller = TextEditingController();
  TextEditingController typecontroller = TextEditingController();

  void _resetFields() {
    desccontroller.text = "";
    typecontroller.text = "";
    setState(() {
      _info = "Informe o valor da primeira prestação";
      _formkey = GlobalKey<FormState>();
    });
  }

  void _calcular() {
    setState(() {
      double valParc = double.parse(desccontroller.text);
      double contAno = 1;

      while (valParc < 5000) {
        valParc = valParc + valParc;
        contAno = contAno + 1;
      }

      _info =
          "Em: (${contAno}) ano(s) o valor da prestação inserida será maior que 5000 atingindo o valor de: ${valParc}";
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(
                title: const Text("Calculadora de Parcelas"),
                centerTitle: true,
                backgroundColor: Color.fromARGB(255, 105, 74, 126),
                actions: <Widget>[
                  IconButton(
                      onPressed: _resetFields, icon: const Icon(Icons.refresh))
                ]),
            backgroundColor: Color.fromARGB(255, 215, 240, 204),
            body: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: Form(
                  key: _formkey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      const Icon(Icons.paid,
                          size: 120.0, color: Color.fromARGB(255, 19, 180, 73)),
                      TextFormField(
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                            labelText: "Valor",
                            labelStyle: TextStyle(
                                color: Color.fromARGB(255, 15, 116, 73))),
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            color: Color.fromARGB(255, 100, 171, 230),
                            fontSize: 25.0),
                        controller: desccontroller,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Insira o valor da primeira prestação";
                          }
                          return null;
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                        child: SizedBox(
                          height: 50,
                          child: ElevatedButton(
                            onPressed: () {
                              if (_formkey.currentState!.validate()) {
                                _calcular();
                              }
                            },
                            child: const Text(
                              'Calcular',
                              style: TextStyle(
                                  color: Colors.white, fontSize: 25.0),
                            ),
                          ),
                        ),
                      ),
                      Text(
                        _info,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            color: Color.fromARGB(255, 5, 34, 116),
                            fontSize: 25),
                      )
                    ],
                  ),
                ))));
  }
}
