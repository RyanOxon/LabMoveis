import 'package:flutter/material.dart';

class Servico extends StatefulWidget {
  const Servico({super.key});

  @override
  State<Servico> createState() => _ServicoState();
}

class _ServicoState extends State<Servico> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Servicos"),
        backgroundColor: Colors.blueAccent,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(padding: EdgeInsets.only(bottom: 15)),
          Row(
            children: [
              Image.asset(
                "images/detalhe_servico.png",
                scale: 0.6,
              ),
              const Padding(padding: EdgeInsets.only(left: 10)),
              const Text(
                "Nossos Servicos",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              )
            ],
          ),
          const Padding(padding: EdgeInsets.all(10)),
          const Text(
            "  Consultoria",
            style: TextStyle(fontSize: 15),
          ),
          const Padding(padding: EdgeInsets.all(10)),
          const Text(
            "  Calculo de Precos",
            style: TextStyle(fontSize: 15),
          ),
          const Padding(padding: EdgeInsets.all(10)),
          const Text(
            "  Acompanhamento de projetos",
            style: TextStyle(fontSize: 15),
          )
        ],
      ),
    );
  }
}
