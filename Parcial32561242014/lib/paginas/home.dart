import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:cached_network_image/cached_network_image.dart';

import 'detalle.dart';

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List usuarios = [];
  @override
  Widget build(BuildContext context) {
    var ancho = MediaQuery.of(context).size.width;
    var alto = MediaQuery.of(context).size.height;
    return Scaffold(
        backgroundColor: Colors.blueGrey,
        body: Stack(
          children: [
             SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Padding(
                  padding: const EdgeInsets.only(left: 30, top: 30),
                  child: Row(
                    children: [
                      Padding(
                            padding: const EdgeInsets.only(right: 30),
                            child: GestureDetector(
                              onTap: () {
                              },
                              child: Column(
                                children: [
                                  Container(
                                    width: 120,
                                    height: 120,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: NetworkImage('https://www.utec.edu.sv/images/brand.png'),
                                            fit: BoxFit.cover),
                                        //color: primario,
                                        borderRadius: BorderRadius.circular(20)),
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  const Text(
                                    'Edna Liliana Cerritos Pleitez 25-6124-2014',
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 30),
                            child: GestureDetector(
                              onTap: () {
                              },
                              child: Column(
                                children: [
                                  Container(
                                    width: 120,
                                    height: 120,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: AssetImage("assets/img/avatar.jpg"),
                                            fit: BoxFit.cover)),
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  const Text(
                                    'Parcial 3, API reqres.in',
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                          )
                    ],
                  )
                )
             ),
            Positioned(
              top: 190,
              bottom: 0,
              width: ancho,
              child: Column(children: [
                usuarios.length != null
                    ? Expanded(
                        child: GridView.builder(
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2, childAspectRatio: 1.4),
                        itemCount: usuarios.length,
                        itemBuilder: (context, index) {

                          return InkWell(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 4.0, horizontal: 8),
                              child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.blueAccent,
                                      borderRadius: BorderRadius.all(Radius.circular(20))),
                                  child: Stack(children: [
                                    Positioned(
                                        top: 5,
                                        left: 20,
                                        child: Text(
                                          usuarios[index]['first_name'],
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18,
                                              color: Colors.white),
                                        )),
                                    Positioned(
                                      top:30,
                                      bottom: 5,
                                      right: 25,
                                      child: CachedNetworkImage(
                                        imageUrl: usuarios[index]['avatar'],
                                        height: 80,
                                        fit: BoxFit.fitHeight,
                                      ),
                                    ),
                                  ])),
                            ),
                            onTap: () {
                              //TODO: llamar pantalla
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => Detalle(
                                          detalle: usuarios[index],
                                          color: Colors.blueGrey,
                                          idpokemon: index)));
                            },
                          );
                        },
                      ))
                    : Center(
                        child: CircularProgressIndicator(),
                      )
              ]),
            ),
          ],
        ));
  }

  @override
  void initState() {
    super.initState();
    if (mounted) {
      datosApi();
    }
  }

  void datosApi() {
    var url = Uri.https('reqres.in', '/api/users');
    http.get(url).then((value) {
      if (value.statusCode == 200) {
        var decodejsonData = jsonDecode(value.body);
        usuarios= decodejsonData['data'];
        //print(decodejsonData);
        //print(usuarios[1]['first_name']);
        setState(() {});
      } else {
        print("ERROR");
      }

      //print(decodejsonData);
    });
    //200 correcto
    //404 incorrecto
    //500
    //505,504,505
  }
}
