import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

List burger = [];

class Menu3 extends StatefulWidget {
  const Menu3({ Key? key }) : super(key: key);

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
    var url = Uri.https(
        "burgers1.p.rapidapi.com", "/burgers");
    var response = await http.get(url, headers: {
      'X-RapidAPI-Host': 'burgers1.p.rapidapi.com',
      'X-RapidAPI-Key': '15944e2e9amshcd61c9da0ef21d9p1dfa39jsn528344bcd853'
    });
    var items = json.decode(response.body);
    setState(() {
      burger = items;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.8,
        backgroundColor: Colors.amber[200],
      ),
      body: 
      Column(
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
                        Text("Burger", 
                        style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                        )
                      ],
                    )
                  ],
                )
              ),
              Container(
                width: 141,
                height: 150,
                child: Image.asset("asset/burger.png")
              ),
            ],
          ),
          Row(
            children: [
              Container(
                color: Colors.yellow,
                width: 411,
                height: 50,
                child: Text("Price List",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          ListView.builder(
            itemCount: burger.length,
            itemBuilder: (context, index){
              return ListTile(
                title: Text("${burger[index]['name']}"),
                subtitle: Text("${burger[index]['description']}"),
              );
            }
          )
        ],
      ),
    );
  }
}