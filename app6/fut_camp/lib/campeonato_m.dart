// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CampeonatoM extends StatefulWidget {
  final String api;
  final String apikey;
  final int id;
  const CampeonatoM(this.api, this.apikey, this.id, {super.key});

  @override
  State<CampeonatoM> createState() => _CampeonatoMState();
}

class _CampeonatoMState extends State<CampeonatoM> {
  int primeiraFase = 0;
  dynamic fase;
  Future<String> getComp() async {
    String url = "${widget.api}/campeonatos/${widget.id}";

    http.Response response;
    response = await http.get(Uri.parse(url), headers: {
      "content-type": "application/json",
      "Authorization": "Bearer ${widget.apikey}",
      //HttpHeaders.authorizationHeader: "Bearer $apikey",
    });
    int fases = json.decode(response.body)["fases"][0]["fase_id"];
    String url2 = "${widget.api}/campeonatos/${widget.id}/fases/$fases";
    http.Response response2;
    response2 = await http.get(Uri.parse(url2), headers: {
      "content-type": "application/json",
      "Authorization": "Bearer ${widget.apikey}",
      //HttpHeaders.authorizationHeader: "Bearer $apikey",
    });
    fase = json.decode(response2.body);
    print("----=-=-=-=-=------");
    print(response.body);
    print("----=-=-=-=-=------");
    print(fase);
    return response.body;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Info Campeonato"),
        ),
        body: FutureBuilder(
            future: getComp(),
            builder: ((context, snapshot) {
              if (snapshot.hasError) {
              } else if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasData) {
                final data = json.decode(snapshot.data!);
                return SingleChildScrollView(
                  child: Container(
                    margin: const EdgeInsets.all(2),
                    child: Column(
                      children: [
                        Container(
                          width: 400,
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 59, 255, 173),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            children: [
                              Image.network(
                                data["logo"],
                                height: 150,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: 250,
                                    child: Text(
                                      "${data["nome"]}",
                                      style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  Text(
                                      "Edição: ${data["edicao_atual"]["temporada"]}"),
                                  Text(data["rodada_atual"] == null
                                      ? "rodada: Sem rodada atual"
                                      : "rodada: ${data["rodada_atual"]["nome"]}"),
                                ],
                              ),
                            ],
                          ),
                        ),
                        ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: fase["chaves"].length,
                            itemBuilder: ((context, index) {
                              return Container(
                                  margin: const EdgeInsets.all(2),
                                  child: Row(children: [
                                    Text(
                                      fase["chaves"][index]["partida_ida"]
                                          ["time_mandante"]["nome_popular"],
                                    ),
                                    Text(
                                      fase["chaves"][index]["partida_ida"]
                                          ["time_visitante"]["nome_popular"],
                                    ),
                                  ]));
                            }))
                      ],
                    ),
                  ),
                );
              }
              return const Text("erro");
            })));
  }
}
