import 'package:flutter/material.dart';

class Resultado extends StatefulWidget {
  final String imagemApp;
  final String textoResultado;
  const Resultado(this.imagemApp, this.textoResultado, {super.key});
  @override
  State<Resultado> createState() => _ResultadoState();
}

class _ResultadoState extends State<Resultado> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Resultado da moeda"),
          backgroundColor: Colors.amberAccent,
        ),
        body: Container(
          margin: const EdgeInsets.all(15),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  widget.imagemApp,
                  scale: 1,
                ),
                const Padding(padding: EdgeInsets.only(top: 32)),
                Text(
                  widget.textoResultado,
                  style: const TextStyle(
                      fontSize: 32, fontWeight: FontWeight.bold),
                ),
                const Padding(padding: EdgeInsets.only(top: 80)),
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: TextButton.styleFrom(
                        fixedSize: const Size(200, 75),
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.blueGrey,
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(230)),
                        textStyle: const TextStyle(
                            fontSize: 40, fontFamily: "Courier New")),
                    child: const Text("Voltar")),
              ],
            ),
          ),
        ));
  }
}
