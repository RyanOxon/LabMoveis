import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
//import 'package:flutter_svg/flutter_svg.dart';

class Campeonato extends StatefulWidget {
  final int id;
  final String api;
  final String apikey;
  const Campeonato(this.api, this.apikey, this.id, {super.key});

  @override
  State<Campeonato> createState() => _CampeonatoState();
}

class _CampeonatoState extends State<Campeonato> {
  Future<String> getComp() async {
    String url = "${widget.api}/campeonatos/${widget.id}";

    http.Response response;
    response = await http.get(Uri.parse(url), headers: {
      "content-type": "application/json",
      "Authorization": "Bearer ${widget.apikey}",
      //HttpHeaders.authorizationHeader: "Bearer $apikey",
    });

    return response.body;
  }

  Future<String> getTabela() async {
    String url = "${widget.api}/campeonatos/${widget.id}/tabela";

    http.Response response;
    response = await http.get(Uri.parse(url), headers: {
      "content-type": "application/json",
      "Authorization": "Bearer ${widget.apikey}",
      //HttpHeaders.authorizationHeader: "Bearer $apikey",
    });
    //print(response.body);
    return response.body;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Info Campeonato")),
        body: SingleChildScrollView(
          child: Container(
              margin: const EdgeInsets.all(2),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      width: 400,
                      decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 59, 255, 173),
                          borderRadius: BorderRadius.circular(10)),
                      child: FutureBuilder(
                          future: getComp(),
                          builder: ((context, snapshot) {
                            if (snapshot.hasError) {
                            } else if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Center(
                                  child: CircularProgressIndicator());
                            } else if (snapshot.hasData) {
                              final data = json.decode(snapshot.data!);
                              return Row(
                                children: [
                                  Image.network(
                                    data["logo"],
                                    height: 150,
                                  ),
                                  Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                            width: 250,
                                            child: Text("${data["nome"]}",
                                                style: const TextStyle(
                                                    fontSize: 20,
                                                    fontWeight:
                                                        FontWeight.bold))),
                                        Text(
                                            "Edição: ${data["edicao_atual"]["temporada"]}"),
                                        Text(data["rodada_atual"] == null
                                            ? "rodada: Sem rodada atual"
                                            : "rodada: ${data["rodada_atual"]["nome"]}"),
                                      ])
                                ],
                              );
                            }
                            return const Text("Erro ao carregar a lista");
                          }))),
                  const Padding(padding: EdgeInsets.all(3)),
                  const Text("Tabela de classificação",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  Container(
                      alignment: Alignment.topLeft,
                      child: FutureBuilder(
                          future: getTabela(),
                          builder: ((context, snapshot) {
                            if (snapshot.hasError) {
                            } else if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Center(
                                  child: CircularProgressIndicator());
                            } else if (snapshot.hasData) {
                              final data = json.decode(snapshot.data!);

                              return ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: data.length,
                                itemBuilder: (context, index) {
                                  return Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Padding(
                                            padding: EdgeInsets.all(5)),
                                        Container(
                                          height: 50,
                                          width: 163,
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                              color: const Color.fromARGB(
                                                  255, 255, 255, 186),
                                              borderRadius:
                                                  BorderRadius.circular(50)),
                                          child: Row(
                                            children: [
                                              const Padding(
                                                  padding: EdgeInsets.all(5)),
                                              Text("${data[index]["posicao"]}:",
                                                  style: const TextStyle(
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.bold)),
                                              const Padding(
                                                  padding: EdgeInsets.all(5)),
                                              SizedBox(
                                                width: 115,
                                                child: Text(
                                                    data[index]["time"]
                                                        ["nome_popular"],
                                                    style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold)),
                                              )
                                            ],
                                          ),
                                        )
                                      ]);
                                },
                                shrinkWrap: true,
                              );
                            }
                            return const Text("Erro ao carregar a lista");
                          }))),
                ],
              )),
        ));
  }
}
