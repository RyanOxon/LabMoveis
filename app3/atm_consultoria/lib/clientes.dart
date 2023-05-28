import 'package:flutter/material.dart';

class Clientes extends StatefulWidget {
  const Clientes({super.key});

  @override
  State<Clientes> createState() => _ClientesState();
}

class _ClientesState extends State<Clientes> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Clientes"),
        backgroundColor: Colors.yellowAccent,
      ),
      body: Container(
        margin: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Image.asset(
                  "images/detalhe_cliente.png",
                  scale: 0.7,
                ),
                const Padding(padding: EdgeInsets.only(left: 10)),
                const Text(
                  "Clientes",
                  style: TextStyle(fontSize: 20),
                )
              ],
            ),
            const Padding(padding: EdgeInsets.only(bottom: 10)),
            Image.asset("images/cliente1.png"),
            const Text("Empresa de software"),
            const Padding(padding: EdgeInsets.only(bottom: 10)),
            Image.asset("images/cliente2.png"),
            const Text("Empresa de auditoria")
          ],
        ),
      ),
    );
  }
}
