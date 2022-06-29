import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:http/http.dart' as http;
import 'package:proyekambw/main.dart';
import 'package:proyekambw/navbar.dart';
import 'dart:convert';

import 'package:proyekambw/pages/menu2.dart';

List burger = [];
int limit = 6;

class Menu3 extends StatefulWidget {
  const Menu3({Key? key}) : super(key: key);

  @override
  State<Menu3> createState() => _Menu3State();
}

class _Menu3State extends State<Menu3> {
  @override
  void initState() {
    super.initState();
    getName();
  }

  getName() async {
    var url = Uri.https("burgers1.p.rapidapi.com", "/burgers");
    var response = await http.get(url, headers: {
      'X-RapidAPI-Host': 'burgers1.p.rapidapi.com',
      'X-RapidAPI-Key': '53f044d9cdmshf265e6686f46e6fp1e9053jsn271b48445962'
    });
    var items = json.decode(response.body);
    setState(() {
      burger = items;
    });
    print(burger);
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
            Row(
              children: [
                Container(
                    width: 270,
                    height: 150,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 35, left: 18),
                              child: Text(
                                "Burger",
                                style: TextStyle(
                                    fontSize: 75,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Glinny'),
                              ),
                            )
                          ],
                        )
                      ],
                    )),
                Container(
                    width: 141,
                    height: 150,
                    child: Image.asset("asset/burger.png")),
              ],
            ),
            Row(
              children: [
                Container(
                  padding: EdgeInsets.only(left: 16),
                  width: 411,
                  height: 30,
                  child: Text(
                    "Price List",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            Container(
              width: 411,
              height: 375,
              child: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                        itemCount: limit,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text(
                              "${burger[index]['name']}",
                              style: TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 16),
                            ),
                            subtitle: Container(
                              width: 350,
                              child: Text(
                                "${burger[index]['description']}",
                                style: TextStyle(color: Colors.grey[500]),
                              ),
                            ),
                            trailing: Container(
                                decoration: BoxDecoration(
                                    color: Colors.blue,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(40))),
                                width: 40,
                                height: 40,
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          0, 10, 0, 0),
                                      child: Text(
                                        "35K",
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white),
                                      ),
                                    )
                                  ],
                                )),
                          );
                        }),
                  ),
                ],
              ),
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
                                  return Menu2();
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
                                  return NavBar();
                                }));
                              },
                              child: Container(child: Text("Back to Home")),
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
