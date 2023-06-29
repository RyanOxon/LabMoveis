import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  void getApi() async {
    String url = "https://api.api-futebol.com.br/v1/campeonatos";
    //String apikey = "test_04601cb9d9a690a4b4b179eab92752";
    String apikey = "live_75bc6d91a7af63bc5304a5bd691fed";

    print("Get: $url");
    http.Response response;
    response = await http.get(Uri.parse(url), headers: {
      "content-type": "application/json",
      "Authorization": "Bearer $apikey",
      //HttpHeaders.authorizationHeader: "Bearer $apikey",
    });

    print(response.statusCode.toString());
    print(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Futebol")),
      body: Container(
          margin: const EdgeInsets.all(20),
          child: Column(
            children: [
              const Text(
                "Campeonatos Disponíveis",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const Padding(padding: EdgeInsets.all(25)),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      const Text(
                        "Brasileirão Série A",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          getApi();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                        ),
                        child: Image.asset(
                          "images/brasileiro-seriea.png",
                          width: 300,
                          height: 300,
                        ),
                      ),
                    ],
                  ),
                  const Padding(padding: EdgeInsets.all(20)),
                  Column(
                    children: [
                      const Text(
                        "Copa do Brasil",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                          ),
                          child: Image.asset(
                            "images/copa-do-brasil.png",
                            width: 300,
                            height: 300,
                          )),
                    ],
                  )
                ],
              ),
            ],
          )),
    );
  }
}
