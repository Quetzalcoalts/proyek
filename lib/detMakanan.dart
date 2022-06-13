// ignore_for_file: prefer_const_constructors

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'main.dart';

int jumlah = 1;

class detMakanan extends StatefulWidget {
  final List id;
  final int item_id;
  const detMakanan({Key? key, required this.id, required this.item_id})
      : super(key: key);
  @override
  State<detMakanan> createState() => _detMakananState();
}

class _detMakananState extends State<detMakanan> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.8,
        backgroundColor: Color.fromARGB(255, 4, 162, 241),
      ),
      body: 
      Container(
        color: Color.fromARGB(255, 4, 162, 241),
        child: Column(
          children: [
            Container(
              child: Stack(
                children: [
                  Container(
                  // ignore: prefer_const_constructors
                    decoration: BoxDecoration(
                      color: Colors.white,
                      // ignore: prefer_const_constructors
                      borderRadius: BorderRadius.only(
                        // ignore: prefer_const_constructors
                        topLeft: Radius.circular(30),
                        // ignore: prefer_const_constructors
                        topRight: Radius.circular(30),
                      )
                    ),
                    margin: EdgeInsets.only(top: 203),
                    height: 400,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.fromLTRB(8,10,8,0),
                          width: 410,
                          height: 60,
                          child: Card(
                            color: Color.fromARGB(255, 4, 162, 241),
                            elevation: 0,
                            child: Text("${widget.id[widget.item_id]['display']['displayName']}",
                            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18, color: Colors.white),
                            overflow: TextOverflow.visible,
                            maxLines: 5,
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(10,5,8,0),
                          child: Row(
                            children: [
                              Text("${widget.id[widget.item_id]['display']['flag']}",
                              style: TextStyle(fontWeight: FontWeight.w400, fontSize: 15, color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              padding: EdgeInsets.fromLTRB(0, 30, 20, 0),
                              child: Image.network(
                                "${widget.id[widget.item_id]['display']['images'][0]}",
                                height: 140,
                                width: 168,
                                fit: BoxFit.cover,
                              )
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Container(
                              margin: EdgeInsets.only(top: 10),
                              width: 380,
                              height: 200,
                              child: Card(
                                elevation: 0,
                                child: Text("${widget.id[widget.item_id]['content']['description'] != null ? 
                                widget.id[widget.item_id]['content']['description']['text'] : 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.'},",
                                style: TextStyle(fontSize: 15),
                                overflow: TextOverflow.visible,
                                maxLines: 10,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Row(
                              children: [
                                Container(
                                  margin: EdgeInsets.fromLTRB(5, 8, 0, 0),
                                  width: 40,
                                  height: 25,
                                  child: OutlineButton(
                                    // ignore: prefer_const_constructors
                                    borderSide: BorderSide(
                                      width: 0.5,
                                      color: Colors.grey
                                    ),
                                    onPressed: (){
                                      setState(() {
                                        if(jumlah > 0){
                                          jumlah --;
                                        }
                                      });
                                    },
                                    child: Icon(Icons.remove),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.fromLTRB(10, 8, 0, 0),
                                  child: Text(jumlah.toString())
                                ),
                                Container(
                                  margin: EdgeInsets.fromLTRB(10, 8, 0, 0),
                                  width: 40,
                                  height: 25,
                                  child: OutlineButton(
                                    // ignore: prefer_const_constructors
                                    borderSide: BorderSide(
                                      width: 0.5,
                                      color: Colors.grey
                                    ),
                                    onPressed: (){
                                      setState(() {
                                        jumlah ++;
                                      });
                                    },
                                    child: Icon(Icons.add),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Container(
                              padding: EdgeInsets.fromLTRB(5, 35, 0, 0),
                              child: Row(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Colors.grey[300],
                                      borderRadius: BorderRadius.circular(8)
                                    ),
                                    width: 110,
                                    height: 50,
                                    child: FlatButton(
                                      onPressed: (){}, 
                                      child: Icon(Icons.shopping_cart)
                                    ),
                                  ),
                                  Container(
                                    width: 20,
                                    height: 50,
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Colors.greenAccent,
                                      borderRadius: BorderRadius.circular(8)
                                    ),
                                    width: 237,
                                    height: 50,
                                    child: FlatButton(
                                      onPressed: (){}, 
                                      child: Text("BUY NOW",
                                      style: TextStyle(fontSize: 17),
                                      )
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        )
      ),
    );
  }
}