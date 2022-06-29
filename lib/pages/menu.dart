import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:http/http.dart' as http;
import 'package:proyekambw/main.dart';
import 'package:proyekambw/pages/menu2.dart';

//List pizza = List.empty(growable: true);
List pizza = [];
int limit = 4;

class Menu extends StatefulWidget {
  const Menu({Key? key}) : super(key: key);

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  @override
  void initState() {
    super.initState();
    getName();
  }

  getName() async {
    var url = Uri.https("pizza-and-desserts.p.rapidapi.com", "/pizzas");

    // try {
    var response = await http.get(url, headers: {
      'X-RapidAPI-Host': 'pizza-and-desserts.p.rapidapi.com',
      'X-RapidAPI-Key': '53f044d9cdmshf265e6686f46e6fp1e9053jsn271b48445962'
    });
    var items = json.decode(response.body);
    setState(() {
      pizza = items;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.8,
        backgroundColor: HexColor('#2596be'),
      ),
      body: Container(
        color: Color.fromARGB(255, 223, 236, 255),
        child: Column(
          children: [
            Stack(
              children: [
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      "Pizza",
                      style: TextStyle(
                          fontSize: 50,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Glinny'),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 70),
                      child: Container(
                        color: Color.fromARGB(255, 117, 154, 212),
                        width: 180,
                        height: 160,
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                    height: 160,
                                    width: 180,
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 20, left: 5),
                                              child: Image.asset(
                                                  "asset/paneer.png",
                                                  width: 175,
                                                  height: 120),
                                            )
                                          ],
                                        ),
                                      ],
                                    )),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 70, left: 180),
                      child: Container(
                        color: Color.fromARGB(255, 173, 192, 223),
                        width: 180,
                        height: 160,
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                    padding: EdgeInsets.only(top: 50),
                                    height: 160,
                                    width: 180,
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              "${pizza[3]['name']}",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Container(
                                              width: 170,
                                              child: Text(
                                                "${pizza[3]['description']}",
                                                style: TextStyle(fontSize: 12),
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    )),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 240),
                      child: Container(
                        color: Color.fromARGB(255, 117, 154, 212),
                        width: 180,
                        height: 160,
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                    height: 160,
                                    width: 180,
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 20),
                                              child: Image.asset(
                                                  "asset/tandori.png",
                                                  width: 180,
                                                  height: 100),
                                            )
                                          ],
                                        ),
                                      ],
                                    )),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 240, right: 180),
                      child: Container(
                        color: Color.fromARGB(255, 173, 192, 223),
                        width: 180,
                        height: 160,
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                    padding: EdgeInsets.only(top: 50),
                                    height: 160,
                                    width: 180,
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              "${pizza[1]['name']}",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Container(
                                              width: 170,
                                              child: Text(
                                                "${pizza[1]['description']}",
                                                style: TextStyle(fontSize: 12),
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    )),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 410),
                      child: Container(
                        color: Color.fromARGB(255, 117, 154, 212),
                        width: 180,
                        height: 160,
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                    height: 160,
                                    width: 180,
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      0, 30, 0, 0),
                                              child: Image.asset(
                                                "asset/veggie.png",
                                                width: 180,
                                                height: 110,
                                              ),
                                            )
                                          ],
                                        ),
                                      ],
                                    )),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 410, left: 180),
                      child: Container(
                        color: Color.fromARGB(255, 173, 192, 223),
                        width: 180,
                        height: 160,
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                    padding: EdgeInsets.only(top: 50),
                                    height: 160,
                                    width: 180,
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              "${pizza[4]['name']}",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Container(
                                              width: 170,
                                              child: Text(
                                                "${pizza[4]['description']}",
                                                style: TextStyle(fontSize: 12),
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    )),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(top: 20),
              child: Container(
                child: Column(
                  children: [
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                              style: ButtonStyle(
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                ),
                                minimumSize:
                                    MaterialStateProperty.all(Size(50, 50)),
                                backgroundColor: MaterialStateProperty.all(
                                    Color.fromARGB(255, 173, 192, 223)),
                                shadowColor: MaterialStateProperty.all(
                                    Colors.transparent),
                              ),
                              onPressed: () {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return MyApp();
                                }));
                              },
                              child: Container(
                                  child: Row(
                                children: [
                                  Icon(
                                    Icons.arrow_back_ios,
                                    size: 15,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text("Back"),
                                ],
                              )),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            ElevatedButton(
                              style: ButtonStyle(
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                ),
                                minimumSize:
                                    MaterialStateProperty.all(Size(50, 50)),
                                backgroundColor: MaterialStateProperty.all(
                                    Color.fromARGB(255, 117, 154, 212)),
                                shadowColor: MaterialStateProperty.all(
                                    Colors.transparent),
                              ),
                              onPressed: () {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return Menu2();
                                }));
                              },
                              child: Container(
                                  child: Row(
                                children: [
                                  Text("Next"),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Icon(
                                    Icons.arrow_forward_ios,
                                    size: 15,
                                  ),
                                ],
                              )),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
