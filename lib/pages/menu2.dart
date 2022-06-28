import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;

List dessert = [];

class Menu2 extends StatefulWidget {
  const Menu2({ Key? key }) : super(key: key);

  @override
  State<Menu2> createState() => _Menu2State();
}

class _Menu2State extends State<Menu2> {
  @override
    void initState() {
    super.initState();
    getName();
  }

  getName() async {
    var url = Uri.https(
        "pizza-and-desserts.p.rapidapi.com", "/desserts");
    var response = await http.get(url, headers: {
      'X-RapidAPI-Host': 'pizza-and-desserts.p.rapidapi.com',
      'X-RapidAPI-Key': '15944e2e9amshcd61c9da0ef21d9p1dfa39jsn528344bcd853'
    });
    var items = json.decode(response.body);
    setState(() {
      dessert = items;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.8,
        backgroundColor: Colors.amber[200],
      ),
      body: Container(
        child: Column(
          children: [
            Stack(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 100),
                      child: Container(
                        width: 180,
                        height: 160,
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("${dessert[0]['name']}",
                                style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  width: 170,
                                  child: Text("${dessert[0]['description']}",
                                  style: TextStyle(fontSize: 12),
                                  textAlign: TextAlign.center,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Image.asset('asset/chocosundae.png', width: 180, height: 100),
                              ],
                            ),
                          ],
                        )
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(20, 255, 0, 0),
                      child: Container(
                        width: 180,
                        height: 160,
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Image.asset('asset/cornetto.png', width: 180, height: 100),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 10),
                                  child: Text("${dessert[1]['name']}",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  width: 170,
                                  child: Text("${dessert[1]['description']}",
                                  style: TextStyle(fontSize: 12),
                                  textAlign: TextAlign.center,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        )
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 255, 20, 0),
                      child: Container(
                        width: 180,
                        height: 160,
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Image.asset('asset/lava.png', width: 180, height: 100),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 10),
                                  child: Text("${dessert[4]['name']}",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  width: 170,
                                  child: Text("${dessert[4]['description']}",
                                  style: TextStyle(fontSize: 12),
                                  textAlign: TextAlign.center,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        )
                      ),
                    ),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}