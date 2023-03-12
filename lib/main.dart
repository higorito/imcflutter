import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Widget buildTextField(String label, TextEditingController txtControler) {
    return TextField(
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Colors.black, fontSize: 25),
        border: OutlineInputBorder(),
      ),
      style: TextStyle(color: Colors.black87, fontSize: 25),
      keyboardType: TextInputType.number,
      controller: txtControler,
    );
  }

  String infoText = "Informe Seus Dados";

  TextEditingController pesoControlador = TextEditingController();
  TextEditingController alturaControlador = TextEditingController();

  void _calcularImc() {
    double altura = double.parse(alturaControlador.text) /
        100; //o texto do controlador vai ser transformado em double
    double peso = double.parse(pesoControlador.text);

    double imc = peso / (altura * altura);

    setState(() {
      if (imc < 17) {
        infoText = "Muito abaixo do peso (${imc.toStringAsPrecision(2)})";
      } else if (imc >= 17 && imc <= 18.49) {
        infoText = "Abaixo do peso (${imc.toStringAsPrecision(2)})";
      } else if (imc >= 18.5 && imc <= 24.99) {
        infoText = "Peso normal (${imc.toStringAsPrecision(2)})";
      } else if (imc >= 25 && imc <= 29.99) {
        infoText = "Acima do peso (${imc.toStringAsPrecision(2)})";
      } else if (imc >= 30 && imc <= 34.99) {
        infoText = "Obesidade I (${imc.toStringAsPrecision(2)})";
      } else if (imc >= 35 && imc <= 39.99) {
        infoText = "Obesidade II (severa) (${imc.toStringAsPrecision(2)})";
      } else if (imc > 40) {
        infoText = "Obesidade III (mórbida) (${imc.toStringAsPrecision(2)})";
      }
    });
  }

  void resetarCampos() {
    setState(() {
      alturaControlador.text = "";
      pesoControlador.text = "";
      infoText = "Informe Seus Dados";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text("Calculadora de IMC"),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              resetarCampos();
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Image.asset(
              'assets/iconSaude.png',
              width: 250,
              height: 250,
            ),
            buildTextField("Peso", pesoControlador),
            Divider(),
            buildTextField("Altura", alturaControlador),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    _calcularImc();
                  },
                  child: Text(
                    "Calcular",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 30,
                        fontWeight: FontWeight.bold),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromRGBO(14, 38, 81, 1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Text(
                infoText,
                style: TextStyle(color: Colors.black, fontSize: 25),
                textAlign: TextAlign.center,
              ),
            )
          ],
        ),
      ),
    );
  }
}
