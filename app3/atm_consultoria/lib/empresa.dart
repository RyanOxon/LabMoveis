import 'package:flutter/material.dart';

class Empresa extends StatefulWidget {
  const Empresa({super.key});

  @override
  State<Empresa> createState() => _EmpresaState();
}

class _EmpresaState extends State<Empresa> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Empresa"),
          backgroundColor: Colors.redAccent,
        ),
        body: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.all(10),
            child: Column(children: [
              Row(children: [
                Image.asset(
                  "images/detalhe_empresa.png",
                  scale: 0.7,
                ),
                const Padding(padding: EdgeInsets.only(left: 15)),
                const Text(
                  "Sobre a Empresa",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.redAccent,
                  ),
                )
              ]),
              const Padding(padding: EdgeInsets.only(bottom: 10)),
              const Text(
                  "O teorema do macaco infinito afirma que um macaco digitando aleatoriamente em um teclado por um intervalo de tempo infinito irá quase certamente criar um texto qualquer escolhido, como por exemplo a obra completa de William Shakespeare. \n Pode-se também pensar que, com infinitos macacos infinitos, algum deles irá quase certamente criar um texto qualquer escolhido como primeiro texto a ser digitado. \n Neste contexto, \"quase certamente\" é um termo matemático com um significado preciso, enquanto que o \"macaco\" é apenas uma imagem, não um símio verdadeiro; trata-se de uma metáfora para um dispositivo abstracto que produza uma sequência aleatória de letras ad infinitum. O teorema ilustra os perigos do raciocínio sobre o infinito ao imaginar um número muito grande mas finito, e vice versa. A idade do universo é diminuída relativamente pelo tempo que levaria a um macaco para obter um texto igual ao Hamlet, de modo que num sentido físico tal nunca aconteceria. \n Variantes do teorema incluem múltiplos dispositivos de escrita, e o texto pode variar entre uma biblioteca inteira e uma simples e pequena frase. O problema apareceu pela primeira vez no artigo chamado Mécanique Statistique et Irréversibilité do matemático Émile Borel no ano de 1913.")
            ]),
          ),
        ));
  }
}
