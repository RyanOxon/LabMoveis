import 'package:flutter/material.dart';

class Contato extends StatefulWidget {
  const Contato({super.key});

  @override
  State<Contato> createState() => _ContatoState();
}

class _ContatoState extends State<Contato> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Contato"),
        backgroundColor: Colors.green[300],
      ),
      body: Container(
        margin: const EdgeInsets.all(10),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(
            children: [
              Image.asset(
                "images/detalhe_contato.png",
                scale: 0.7,
              ),
              const Text(
                "Contato",
                style: TextStyle(fontSize: 20),
              ),
            ],
          ),
          const Padding(
            padding: EdgeInsets.only(bottom: 10),
          ),
          const Text("atendimento@atmconsultoria.com.br"),
          const Padding(padding: EdgeInsets.only(bottom: 10)),
          const Text("Telefone: (21) 1234-5678"),
          const Padding(padding: EdgeInsets.only(bottom: 10)),
          const Text("Celular: (21) 9876-5432"),
          const Padding(padding: EdgeInsets.only(bottom: 10)),
        ]),
      ),
    );
  }
}
