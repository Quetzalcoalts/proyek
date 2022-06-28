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
      'X-RapidAPI-Key': 'dea7a17be3msh66d0e56d23911edp19ed0cjsn41709130defd'
    });
    var items = json.decode(response.body);
    setState(() {
      dessert = items;
    });
    print(dessert);
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
                Container(
                  child: Image.asset('asset/lava.png', width: 10, height: 10,)
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}