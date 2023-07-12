// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'campeonato.dart';
import 'campeonato_m.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String api = "https://api.api-futebol.com.br/v1";
  String apikey = "test_04601cb9d9a690a4b4b179eab92752";
  //String apikey = "live_2dfbd46a925089a47c3df56af54f1d  ";

  Future<String> getLista() async {
    String url = "$api/campeonatos";

    print("Get: $url");
    http.Response response;
    response = await http.get(Uri.parse(url), headers: {
      "content-type": "application/json",
      "Authorization": "Bearer $apikey",
      //HttpHeaders.authorizationHeader: "Bearer $apikey",
    });
    return response.body;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 246),
      appBar: AppBar(title: const Text("Futebol")),
      body: SingleChildScrollView(
          child: Column(
        children: [
          const Text(
            "Lista de Campeonatos Disponíveis",
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const Padding(padding: EdgeInsets.all(25)),
          FutureBuilder(
              future: getLista(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  print("Erro ao carregar a lista");
                } else if (snapshot.connectionState ==
                    ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasData) {
                  final data = json.decode(snapshot.data!);
                  print(data);

                  return ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                            onTap: () {
                              if (data[index]["tipo"] == "Pontos Corridos" ||
                                  data[index]["tipo"] == "Grupo") {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Campeonato(api,
                                          apikey, data[index]["campeonato_id"]),
                                    ));
                              } else if (data[index]["tipo"] == "Mata-Mata") {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => CampeonatoM(api,
                                          apikey, data[index]["campeonato_id"]),
                                    ));
                              } else {
                                print("Campeonato não suportado");
                              }
                            },
                            child: Container(
                                margin: const EdgeInsets.all(5),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Image.network(
                                      data[index]["logo"],
                                      height: 125,
                                      width: 125,
                                    ),
                                    const Padding(padding: EdgeInsets.all(10)),
                                    SizedBox(
                                        width: 250,
                                        child: Text(
                                          data[index]["nome"],
                                          style: const TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ))
                                  ],
                                )));
                      });
                }
                return const Center(child: Text("Nenhum item encontrado"));
              }),
        ],
      )),
    );
  }
}
