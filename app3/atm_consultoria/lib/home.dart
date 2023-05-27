import 'package:flutter/material.dart';

import 'empresa.dart';
import 'clientes.dart';
import 'contato.dart';
import 'servico.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
        backgroundColor: Colors.green,
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Padding(padding: EdgeInsets.only(bottom: 30)),
            Image.asset(
              "images/logo.png",
            ),
            const Padding(padding: EdgeInsets.all(50)),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Empresa()));
                  },
                  child: Image.asset("images/menu_empresa.png"),
                ),
                const Padding(padding: EdgeInsets.only(left: 20)),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Servico()));
                  },
                  child: Image.asset("images/menu_servico.png"),
                ),
              ],
            ),
            const Padding(padding: EdgeInsets.all(10)),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Clientes()));
                  },
                  child: Image.asset("images/menu_cliente.png"),
                ),
                const Padding(padding: EdgeInsets.only(left: 20)),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Contato()));
                  },
                  child: Image.asset("images/menu_contato.png"),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
