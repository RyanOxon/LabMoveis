import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _text = "";
  final String _pedra = "assets/pedra.png";
  final String _papel = "assets/papel.png";
  final String _tesoura = "assets/tesoura.png";
  String _default = "assets/default.png";
  Color _cor = Colors.white;

  List<String> get _imgs => [_pedra, _papel, _tesoura];

  void _changeImg(int op) {
    int i = Random().nextInt(_imgs.length);
    setState(() {
      _default = _imgs[i];
      switch (op) {
        case 0:
          if (i == 0) {
            _text = "EMPATE";
            _cor = Colors.yellow;
          } else if (i == 1) {
            _text = "DERROTA";
            _cor = Colors.red;
          } else if (i == 2) {
            _text = "VITORIA";
            _cor = Colors.green;
          }
          break;
        case 1:
          if (i == 1) {
            _text = "EMPATE";
            _cor = Colors.yellow;
          } else if (i == 2) {
            _text = "DERROTA";
            _cor = Colors.red;
          } else if (i == 0) {
            _text = "VITORIA";
            _cor = Colors.green;
          }
          break;
        case 2:
          if (i == 2) {
            _text = "EMPATE";
            _cor = Colors.yellow;
          } else if (i == 0) {
            _text = "DERROTA";
            _cor = Colors.red;
          } else if (i == 1) {
            _text = "VITORIA";
            _cor = Colors.green;
          }
          break;

        default:
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("JokenPo")),
        body: Center(
          child: Container(
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TextButton(
                      onPressed: null,
                      style: ButtonStyle(
                          backgroundColor: MaterialStatePropertyAll(_cor)),
                      child: Text(
                        _text,
                        style: const TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold),
                      )),
                  Image.asset(_default, width: 250),
                  const Text(
                    "Escolha:",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      IconButton(
                          onPressed: () {
                            _changeImg(0);
                          },
                          padding: const EdgeInsets.all(2),
                          iconSize: 100,
                          icon: Image.asset(_pedra)),
                      IconButton(
                          onPressed: () {
                            _changeImg(1);
                          },
                          padding: const EdgeInsets.all(2),
                          iconSize: 100,
                          icon: Image.asset(_papel)),
                      IconButton(
                          onPressed: () {
                            _changeImg(2);
                          },
                          padding: const EdgeInsets.all(2),
                          iconSize: 100,
                          icon: Image.asset(_tesoura))
                    ],
                  )
                ],
              )),
        ));
  }
}
