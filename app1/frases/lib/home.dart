import 'dart:math';

import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String _text = "Clique abaixo para gerar uma frase!";

  final List<String> _frases = [
    "Todos veem o que você parece ser, mas poucos sabem o que você realmente é. \n(Maquiavel)",
    "A solidão é a sorte de todos os espíritos excepcionais. \n(Schopenhaur)",
    "Quanto mais nos elevamos, menores parecemos aos olhos daqueles que não sabem voar. \n(Nietzsche)",
    "A liberdade é a possibilidade do isolamento. Se te é impossível viver só, nasceste escravo. \n(Fernando Pessoa)"
  ];

  void _changeText() {
    int i = Random().nextInt(_frases.length);
    setState(() {
      _text = _frases[i];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Frases Aleatorias")),
        body: Center(
            child: Container(
                padding: const EdgeInsets.all(20),
                margin: const EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset("assets/title.jpeg", fit: BoxFit.fill),
                    Text(_text,
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center),
                    TextButton(
                        onPressed: () {
                          _changeText();
                        },
                        style: const ButtonStyle(
                            backgroundColor:
                                MaterialStatePropertyAll(Colors.green)),
                        child: const Text(
                          "Clique Aqui",
                          style: TextStyle(color: Colors.white),
                        ))
                  ],
                ))));
  }
}
