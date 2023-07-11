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

  Future<String> getFase() async {
    String url = "${widget.api}/campeonatos/${widget.id}/fases";

    http.Response response;
    response = await http.get(Uri.parse(url), headers: {
      "content-type": "application/json",
      "Authorization": "Bearer ${widget.apikey}",
      //HttpHeaders.authorizationHeader: "Bearer $apikey",
    });

    print(response.body);
    return response.body;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Info Campeonato"),
      ),
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
                          return Column(
                            children: [
                              Row(
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
                                        Text(
                                            "fase: ${data["fase_atual"]["nome"]}")
                                      ])
                                ],
                              )
                            ],
                          );
                        }
                        return const Text("Erro ao carregar a lista");
                      }))),
              const Padding(padding: EdgeInsets.all(3)),
              const Text("Lista de Times"),
              FutureBuilder(
                future: getFase(),
                builder: ((context, snapshot) {
                  if (snapshot.hasError) {
                  } else if (snapshot.connectionState ==
                      ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasData) {
                    final data = json.decode(snapshot.data!);
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: data["fases"].length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text("${data["fases"][index]["nome"]}"),
                          subtitle: Text(
                              "Rodada Atual: ${data["fases"][index]["rodada_atual"]}"),
                        );
                      },
                    );
                  }
                  return const Text("Erro ao carregar a lista");
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
