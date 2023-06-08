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
  bool finish = false;

  void _calculate(String value) {
    finish = true;
    inputValue = value.trim();
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

  ElevatedButton botao(String texto, bool isOperator,
      {bool isBackspace = false,
      bool isDouble = false,
      bool isEquals = false}) {
    return ElevatedButton(
        onPressed: () {
          if (finish) {
            setState(() {
              inputValue = "";
              finish = false;
            });
          }
          if (isEquals && inputValue.isNotEmpty) {
            _calculate(inputValue);
          } else if (isBackspace) {
            setState(() {
              if (inputValue.isNotEmpty) {
                inputValue = inputValue.substring(0, inputValue.length - 1);
                inputValue = inputValue.trim();
              }
            });
          } else if (!isEquals) {
            setState(() {
              if (isOperator && inputValue.isNotEmpty) {
                inputValue += " $texto ";
              } else {
                inputValue += texto;
              }
            });
          }
        },
        style: ButtonStyle(
            backgroundColor: isOperator
                ? const MaterialStatePropertyAll(Colors.red)
                : const MaterialStatePropertyAll(Colors.blueGrey),
            elevation: const MaterialStatePropertyAll(2),
            shape: const MaterialStatePropertyAll(RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)))),
            fixedSize: MaterialStatePropertyAll(
                isDouble ? const Size(182, 70) : const Size(90, 70))),
        child: Text(texto,
            style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text("Calculadora Hexadecimal"),
          backgroundColor: Colors.blueGrey),
      backgroundColor: const Color.fromARGB(255, 255, 255, 245),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(20),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            Container(
                constraints: const BoxConstraints(
                    minHeight: 70,
                    maxHeight: 140,
                    minWidth: double.infinity,
                    maxWidth: double.infinity),
                margin:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                padding: const EdgeInsets.only(left: 10, right: 10, top: 5),
                decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    color: Colors.green),
                child: Text(inputValue,
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold))),
            TextField(
              keyboardType: TextInputType.text,
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
            const Padding(padding: EdgeInsets.all(10)),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                botao("1", false),
                const Padding(padding: EdgeInsets.all(1)),
                botao("2", false),
                const Padding(padding: EdgeInsets.all(1)),
                botao("3", false),
                const Padding(padding: EdgeInsets.all(1)),
                botao("⟵", true, isBackspace: true)
              ],
            ),
            const Padding(padding: EdgeInsets.all(2)),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                botao("4", false),
                const Padding(padding: EdgeInsets.all(1)),
                botao("5", false),
                const Padding(padding: EdgeInsets.all(1)),
                botao("6", false),
                const Padding(padding: EdgeInsets.all(1)),
                botao("+", true)
              ],
            ),
            const Padding(padding: EdgeInsets.all(2)),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                botao("7", false),
                const Padding(padding: EdgeInsets.all(1)),
                botao("8", false),
                const Padding(padding: EdgeInsets.all(1)),
                botao("9", false),
                const Padding(padding: EdgeInsets.all(1)),
                botao("-", true)
              ],
            ),
            const Padding(padding: EdgeInsets.all(2)),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                botao("A", false),
                const Padding(padding: EdgeInsets.all(1)),
                botao("B", false),
                const Padding(padding: EdgeInsets.all(1)),
                botao("C", false),
                const Padding(padding: EdgeInsets.all(1)),
                botao("*", true)
              ],
            ),
            const Padding(padding: EdgeInsets.all(2)),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              botao("D", false),
              const Padding(padding: EdgeInsets.all(1)),
              botao("E", false),
              const Padding(padding: EdgeInsets.all(1)),
              botao("F", false),
              const Padding(padding: EdgeInsets.all(1)),
              botao("/", true)
            ]),
            const Padding(padding: EdgeInsets.all(2)),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                botao("0", false, isDouble: true),
                const Padding(padding: EdgeInsets.all(1)),
                botao("=", true, isDouble: true, isEquals: true)
              ],
            )
          ]),
        ),
      ),
    );
  }
}
