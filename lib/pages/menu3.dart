import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:proyekambw/pages/menu2.dart';

List burger = [];
int limit = 5;

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
      'X-RapidAPI-Key': '09ec052f70msh5ffdd85416e6d80p1133e9jsne8e33e519ec5'
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
                width: 411,
                height: 40,
                child: Text("Price List",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          Container(
            width: 411,
            height: 360,
            child: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: limit,
                    itemBuilder: (context, index){
                      return ListTile(
                        title: Text("${burger[index]['name']}",
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        subtitle: Container(
                          width: 350,
                          child: Text("${burger[index]['description']}",
                          style: TextStyle(color: Colors.grey[500]),
                          ),
                        ),
                        trailing: Container(
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.all(Radius.circular(40))
                          ),
                          width: 40,
                          height: 40,
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                                child: Text("35K", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.white),),
                              )
                            ],
                          )
                        ),
                      );
                    }
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: 411,
            height: 53,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context){
                        return Menu2();
                      }));
                    }, icon: Icon(Icons.arrow_back_ios,size: 15,)),
                  ],
                ),
              ],
            )
          )
        ],
      ),
    );
  }
}