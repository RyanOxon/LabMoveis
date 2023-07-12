import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class Infotime extends StatefulWidget {
  final dynamic data;
  const Infotime(this.data, {super.key});

  @override
  State<Infotime> createState() => _InfotimeState();
}

class _InfotimeState extends State<Infotime> {
  Widget geraImagem(String url) {
    if (url.contains(".png") || url.contains(".jpg")) {
      return SizedBox(
        height: 125,
        width: 125,
        child: Image.network(url),
      );
    } else if (url.contains(".svg")) {
      return SizedBox(
        height: 125,
        width: 125,
        child: SvgPicture.network(url),
      );
    } else {
      return const Text("Sem imagem",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20,
            color: Colors.red,
            fontStyle: FontStyle.italic,
          ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 246),
      appBar: AppBar(
        title: Text("Infos do ${widget.data["time"]["nome_popular"]}"),
      ),
      body: Container(
        margin: const EdgeInsets.all(2),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                geraImagem(widget.data["time"]["escudo"]),
                Column(
                  children: [
                    Text(widget.data["time"]["nome_popular"],
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),
                    Text(widget.data["time"]["sigla"],
                        style: const TextStyle(
                            fontSize: 15, fontStyle: FontStyle.italic)),
                    Text("Posiçao: ${widget.data["posicao"]}"),
                    Text("Pontos: ${widget.data["pontos"]}"),
                  ],
                )
              ],
            ),
            const Padding(padding: EdgeInsets.all(5)),
            const Text("Informacoes do time", style: TextStyle(fontSize: 20)),
            Text("Jogos: ${widget.data["jogos"]}",
                style: const TextStyle(fontWeight: FontWeight.bold)),
            const Padding(padding: EdgeInsets.all(2)),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Vitorias: ${widget.data["vitorias"]}"),
                const Padding(padding: EdgeInsets.all(3)),
                Text("Empates: ${widget.data["empates"]}"),
                const Padding(padding: EdgeInsets.all(3)),
                Text("Derrotas: ${widget.data["derrotas"]}"),
              ],
            ),
            const Padding(padding: EdgeInsets.all(5)),
            const Text("Status do Campeonato", style: TextStyle(fontSize: 20)),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Gols Pro: ${widget.data["gols_pro"]}"),
                const Padding(padding: EdgeInsets.all(3)),
                Text("Gols Contra: ${widget.data["gols_contra"]}"),
              ],
            ),
            Text("Saldo de Gols: ${widget.data["saldo_gols"]}"),
            const Padding(padding: EdgeInsets.all(5)),
            Text("Aproveitamento: ${widget.data["aproveitamento"]}",
                style: const TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}
