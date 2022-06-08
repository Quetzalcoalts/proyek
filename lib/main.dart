import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

List nama = [];

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({ Key? key }) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState(){
    super.initState();
    getName();
  }

  getName() async{
    var url = Uri.https("yummly2.p.rapidapi.com", "/feeds/list", {"limit":"15", "start":"3"});
    var response = await http.get(url, headers: {
      'X-RapidAPI-Host': 'yummly2.p.rapidapi.com',
      'X-RapidAPI-Key': 'e62549d6b6mshb04641adf26a586p1f4c67jsnead451b22fa7'
    });
    var items = json.decode(response.body)['feed'];
    setState(() {
      nama = items;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Halo",
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.restaurant_menu),
              Text("Food Recipe"),
            ],
          ),
          backgroundColor: Colors.blueGrey,
        ),
        body: 
        Container(
          padding: EdgeInsets.all(10),
          child: GridView.count(
            crossAxisCount: 2,
            mainAxisSpacing: 5.0,
            crossAxisSpacing: 11.0,
            childAspectRatio: 0.85,
            children: List.generate(nama.length, (index){
              return Container(
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(10),
                      // ignore: unnecessary_new
                      decoration: new BoxDecoration(
                        color: Theme.of(context).primaryColorLight,
                        // ignore: prefer_const_literals_to_create_immutables
                        boxShadow: [
                          // ignore: prefer_const_constructors
                          BoxShadow(
                            color: Colors.grey,
                            spreadRadius: 3,
                            blurRadius: 10,
                            offset: Offset(0,3),
                          )
                        ]
                      ),
                      child: Container(
                        child: Row(
                          children: [
                            Image.network("${nama[index]['display']['images'][0]}",
                            height: 140,
                            width: 170,
                            fit: BoxFit.cover,
                            )
                          ],
                        ),
                      ),
                    ),
                    Center(
                      child: Text("${nama[index]['display']['displayName']}",
                      style: TextStyle(fontSize: 15),
                      )
                    )
                  ],
                ) 
              );
            }
          )
        )
      ),
    )
    );
  }
}
