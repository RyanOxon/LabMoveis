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
  int proximaFase = 0;
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
    proximaFase = fase["proxima_fase"]["fase_id"];
    print("----=-=-=-=-=------");
    print(response.body);
    print("----=-=-=-=-=------");
    print(fase);
    return response.body;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 246),
      appBar: AppBar(
        title: const Text("Info Campeonato"),
      ),
      body: SingleChildScrollView(
        child: FutureBuilder(
          future: getComp(),
          builder: ((context, snapshot) {
            if (snapshot.hasError) {
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasData) {
              final data = json.decode(snapshot.data!);
              return Container(
                margin: const EdgeInsets.all(2),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.all(2),
                      width: 400,
                      height: 160,
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
                                "Edição: ${data["edicao_atual"]["temporada"]}",
                                style: const TextStyle(fontSize: 15),
                              ),
                              Text(
                                data["fase_atual"]["nome"],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const Padding(padding: EdgeInsets.all(2)),
                    Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(fase["nome"],
                              style: const TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold)),
                          const Padding(padding: EdgeInsets.only(right: 40)),
                          GestureDetector(
                              onTap: () {},
                              child: const Text("Proxima Fase >>",
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold))),
                        ]),
                    ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: fase["chaves"].length,
                        itemBuilder: ((context, index) {
                          return Container(
                              margin: const EdgeInsets.all(2),
                              child: Row(children: [
                                Container(
                                  height: 50,
                                  width: 163,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      color: const Color.fromARGB(
                                          255, 123, 214, 100),
                                      borderRadius: BorderRadius.circular(50)),
                                  child: Text(
                                    fase["chaves"][index]["partida_ida"]
                                        ["time_mandante"]["nome_popular"],
                                    style: const TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                const Padding(padding: EdgeInsets.all(2)),
                                const Text("X"),
                                const Padding(padding: EdgeInsets.all(2)),
                                Container(
                                  height: 50,
                                  width: 163,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: const Color.fromARGB(
                                        255, 230, 141, 106),
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  child: Text(
                                    fase["chaves"][index]["partida_ida"]
                                        ["time_visitante"]["nome_popular"],
                                    style: const TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ]));
                        }))
                  ],
                ),
              );
            }
            return const Text("erro");
          }),
        ),
      ),
    );
  }
}
