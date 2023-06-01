import 'dart:math';

import 'package:flutter/material.dart';

import 'resultado.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  void _resultado() {
    int face = Random().nextInt(2);
    String textoResultado = "";
    String imagemApp = "images/moeda_cara.png";
    if (face == 0) {
      textoResultado = "Cara";
    } else {
      textoResultado = "Coroa";
      imagemApp = "images/moeda_coroa.png";
    }
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => Resultado(imagemApp, textoResultado)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Cara ou Coroa"),
          backgroundColor: Colors.amber,
        ),
        body: Center(
          child: Container(
            margin: const EdgeInsets.all(15),
            child: Column(
              children: [
                Image.asset(
                  "images/logo.png",
                ),
                const Padding(padding: EdgeInsets.only(top: 150)),
                TextButton(
                    onPressed: () {
                      _resultado();
                    },
                    style: TextButton.styleFrom(
                      fixedSize: const Size(200, 75),
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.lightGreen,
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(230)),
                      textStyle: const TextStyle(
                        fontFamily: "Courier New",
                        fontSize: 50,
                      ),
                    ),
                    child: const Text("Jogar")),
              ],
            ),
          ),
        ));
  }
}
