import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _hexAndOperatorRegex = RegExp(r"[0-9A-Fa-f+-/*]");
  String inputValue = "";

  void _calculate(String value) {
    inputValue = value
        .replaceAll("+", " + ")
        .replaceAll("-", " - ")
        .replaceAll("*", " * ")
        .replaceAll("/", " / ");

    String result;
    try {
      result = _calculaHexa(inputValue);
      result = "$inputValue = $result";
    } catch (e) {
      result = "Expressao invalida";
    }

    setState(() {
      inputValue = result;
    });
  }

  String _calculaHexa(String equacao) {
    List<String> operacoes = equacao.split(" ");
    double resultado = int.parse(operacoes[0], radix: 16).toDouble();

    for (int i = 1; i < operacoes.length; i += 2) {
      String operador = operacoes[i];
      String operando = operacoes[i + 1];

      double operandoInt = int.parse(operando, radix: 16).toDouble();

      switch (operador) {
        case "+":
          resultado += operandoInt;
          break;
        case "-":
          resultado -= operandoInt;
          break;
        case "*":
          resultado *= operandoInt;
          break;
        case "/":
          resultado /= operandoInt;
          break;
      }
    }

    int intValue = resultado.toInt();
    String hexValue = intValue.toRadixString(16).toUpperCase();
    double decimalValue = resultado - intValue;
    String decimalHexValue = fracaoHex(decimalValue);

    if (decimalHexValue.isNotEmpty) {
      decimalHexValue = decimalHexValue.replaceAll(RegExp(r'0*$'), '');
      if (decimalHexValue.isNotEmpty) {
        return "$hexValue.$decimalHexValue";
      }
    }
    return hexValue;
  }

  String fracaoHex(double valor) {
    String resultado = "";
    for (int i = 0; i < 3; i++) {
      valor *= 16;
      int inteiro = valor.toInt();
      resultado += inteiro.toRadixString(16).toUpperCase();
      valor -= inteiro.toDouble();
    }

    return resultado;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const Text("Calculadora Hexadecimal"),
            backgroundColor: Colors.green),
        body: Center(
          child: Container(
            margin: const EdgeInsets.all(20),
            child: Column(children: [
              Container(
                  margin: const EdgeInsets.all(15),
                  padding: const EdgeInsets.only(left: 10),
                  alignment: Alignment.topLeft,
                  decoration: ShapeDecoration(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      color: Colors.green),
                  child: Text(inputValue,
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold))),
              TextField(
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(_hexAndOperatorRegex)
                ],
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Insira uma expressao Hexadecimal",
                ),
                onSubmitted: (value) {
                  _calculate(value);
                },
              ),
              Row(children: [
                ElevatedButton(
                    onPressed: () {},
                    style: const ButtonStyle(
                        fixedSize: MaterialStatePropertyAll(Size.square(50))),
                    child: const Text("A"))
              ]),
              const Row(children: [Text("data")]),
              const Row(children: [Text("data")]),
              const Row(children: [Text("data")]),
            ]),
          ),
        ));
  }
}
