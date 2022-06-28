import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;
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
      'X-RapidAPI-Key': 'dea7a17be3msh66d0e56d23911edp19ed0cjsn41709130defd'
    });
    var items = json.decode(response.body);
    setState(() {
      pizza = items;
    });
    // } catch (e) {
    //   print('e');
    // }

    print(pizza);
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
                Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(100, 10, 0, 0),
                      child: Container(
                        // ignore: prefer_const_constructors
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: Colors.orangeAccent, width: 10),
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(pizza[0]['img']))),
                        width: 200,
                        height: 200,
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(30, 200, 0, 0),
                  child: Container(
                      decoration: BoxDecoration(
                          color: Colors.orangeAccent,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(100),
                              topRight: Radius.circular(100))),
                      width: 350,
                      height: 50,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Special Pizza",
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      )),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(30, 250, 0, 0),
                  child: Container(
                      decoration: BoxDecoration(
                          color: Colors.orangeAccent,
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(30),
                              bottomRight: Radius.circular(30))),
                      width: 350,
                      height: 300,
                      child: ListView.builder(
                        itemCount: limit,
                        itemBuilder: (context, limit) {
                          return ListTile(
                            title: Text(
                              "${pizza[limit]['name']}",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18),
                            ),
                            subtitle: Container(
                              child: Text(
                                "${pizza[limit]['description']}",
                                style: TextStyle(
                                    fontSize: 14, color: Colors.black45),
                              ),
                            ),
                            trailing: Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(50))),
                              width: 30,
                              height: 30,
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(3, 7, 0, 0),
                                child: Text(
                                  "50K",
                                  style: TextStyle(
                                      fontSize: 13,
                                      color: Colors.black87,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          );
                        },
                      )),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      padding: EdgeInsets.only(top: 310),
                      child: Center(
                          child: IconButton(
                              onPressed: () {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return Menu2();
                                }));
                              },
                              icon: Icon(
                                Icons.arrow_forward_ios_outlined,
                                color: Colors.black,
                                size: 15,
                              ))),
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
