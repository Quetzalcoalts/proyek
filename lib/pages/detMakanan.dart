// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:proyekambw/pages/cart.dart';
import 'package:proyekambw/pages/history.dart';
import 'package:proyekambw/class/testing_pembayaran.dart';
import 'package:proyekambw/pages/like.dart';
import 'package:proyekambw/services/dbservices.dart';
import '../main.dart';
import 'cart.dart';
import 'like.dart';

int jumlah = 1;
int harga = 50;
List like = [];

class detMakanan extends StatefulWidget {
  final List? id;
  final int? item_id;
  const detMakanan({Key? key, this.id, this.item_id}) : super(key: key);
  @override
  State<detMakanan> createState() => _detMakananState();
}

class _detMakananState extends State<detMakanan> {
  final user = FirebaseAuth.instance.currentUser!;
  bool x = false;
  @override
  void initState() {
    super.initState();
    refresh();
  }

  void removed(int index1) {
    for (int i = 0; i < namal.length; i++) {
      if (index1 == i) {
        print("Hellosssss ${namal[i]}");
        namal.removeAt(index1);
        gambarl.removeAt(index1);
      }
    }
  }

  void refresh() {
    listindex.add(widget.item_id);
    cart_namah.add(widget.id![widget.item_id!]['display']['displayName']);
    cart_gambarh.add(widget.id![widget.item_id!]['display']['images'][0]);
    listasli.add(widget.id);
  }

  Convert(var a) {
    var b = double.parse(a).toStringAsFixed(1);
    return b.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.8,
        backgroundColor: Color.fromARGB(255, 4, 162, 241),
      ),
      body: Container(
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
                          )),
                      margin: EdgeInsets.only(top: 203),
                      height: 485,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Column(
                        children: [
                          Container(
                            padding: EdgeInsets.fromLTRB(8, 5, 8, 0),
                            width: 410,
                            height: 50,
                            child: Card(
                              color: Color.fromARGB(255, 4, 162, 241),
                              elevation: 0,
                              child: Text(
                                "${widget.id![widget.item_id!]['display']['displayName']}",
                                style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 18,
                                    color: Colors.white),
                                overflow: TextOverflow.visible,
                                maxLines: 5,
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.fromLTRB(10, 8, 8, 0),
                            child: Row(
                              children: [
                                Container(
                                  height: 15,
                                  width: 150,
                                  child: Text(
                                    "${widget.id![widget.item_id!]['display']['flag']}",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 14,
                                        color: Colors.white),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Container(
                                  padding: EdgeInsets.fromLTRB(10, 5, 0, 0),
                                  height: 25,
                                  width: 100,
                                  child: Text(
                                    "Rating",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 14,
                                        color: Colors.white),
                                  )),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      Icons.star,
                                      color: Colors.yellow,
                                    ),
                                    Text(
                                      "${widget.id![widget.item_id!]['content']['reviews'] != null ? widget.id![widget.item_id!]['content']['reviews']['averageRating'] == null ? "3" : Convert(widget.id![widget.item_id!]['content']['reviews']['averageRating'].toString()) : "3"}",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 16,
                                          color: Colors.white),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Container(
                                  padding: EdgeInsets.fromLTRB(0, 0, 20, 0),
                                  child: Image.network(
                                    "${widget.id![widget.item_id!]['display']['images'][0]}",
                                    height: 140,
                                    width: 168,
                                    fit: BoxFit.cover,
                                  ))
                            ],
                          ),
                          Row(
                            children: [
                              Container(
                                margin: EdgeInsets.only(top: 15),
                                width: 380,
                                height: 200,
                                child: Card(
                                  elevation: 0,
                                  child: Text(
                                    "${widget.id![widget.item_id!]['content']['description'] != null ? widget.id![widget.item_id!]['content']['description']['text'] : 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.'},",
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
                                mainAxisAlignment: MainAxisAlignment.center,
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
                                              width: 0.5, color: Colors.grey),
                                          onPressed: () {
                                            setState(() {
                                              if (jumlah > 0) {
                                                jumlah--;
                                              }
                                              harga = 50 * jumlah;
                                            });
                                          },
                                          child: Icon(Icons.remove),
                                        ),
                                      ),
                                      Container(
                                          margin:
                                              EdgeInsets.fromLTRB(10, 8, 0, 0),
                                          child: Text(jumlah.toString())),
                                      Container(
                                        margin:
                                            EdgeInsets.fromLTRB(10, 8, 0, 0),
                                        width: 40,
                                        height: 25,
                                        child: OutlineButton(
                                          // ignore: prefer_const_constructors
                                          borderSide: BorderSide(
                                              width: 0.5, color: Colors.grey),
                                          onPressed: () {
                                            setState(() {
                                              jumlah++;
                                            });
                                            harga = 50 * jumlah;
                                          },
                                          child: Icon(Icons.add),
                                        ),
                                      ),
                                      Container(
                                          margin:
                                              EdgeInsets.fromLTRB(10, 8, 0, 0),
                                          child: Text(
                                            "${harga.toString()}\$",
                                            style: TextStyle(fontSize: 17),
                                          )),
                                    ],
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(left: 40),
                                    child: ElevatedButton.icon(
                                        onPressed: () {
                                          setState(() {
                                            if (x == false) {
                                              x = true;
                                              namal.add(widget
                                                      .id![widget.item_id!]
                                                  ['display']['displayName']);
                                              gambarl.add(
                                                  widget.id![widget.item_id!]
                                                      ['display']['images'][0]);
                                            } else if (x == true) {
                                              x = false;
                                              removed(widget.item_id!);
                                            }
                                          });
                                        },
                                        icon: Icon(
                                          Icons.thumb_up,
                                          color: x == false
                                              ? Colors.black
                                              : Colors.blue,
                                        ),
                                        label: Text("")),
                                  )
                                ],
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Container(
                                padding: EdgeInsets.fromLTRB(5, 25, 0, 0),
                                child: Row(
                                  children: [
                                    Expanded(
                                      flex: 5,
                                      child: SizedBox(
                                        width: 10,
                                      ),
                                    ),
                                    Expanded(
                                      flex: 4,
                                      child: Container(
                                          decoration: BoxDecoration(
                                              color: Colors.grey[300],
                                              borderRadius:
                                                  BorderRadius.circular(8)),
                                          width: 110,
                                          height: 50,
                                          child: ElevatedButton(
                                            onPressed: () {
                                              final a = keperluan_cart(
                                                cuang: harga,
                                                cname: widget
                                                        .id![widget.item_id!]
                                                    ['display']['displayName'],
                                                cdesciption: widget.id![widget
                                                                    .item_id!]
                                                                ['content']
                                                            ['description'] !=
                                                        null
                                                    ? widget.id![
                                                                widget.item_id!]
                                                            ['content']
                                                        ['description']['text']
                                                    : 'Testing',
                                                cemail: user.email.toString(),
                                                ccontact: jumlah.toString(),
                                              );
                                              print("add to cart firebase");
                                              Database_user.tambahData(
                                                  user01: a);
                                              Navigator.push(context,
                                                  MaterialPageRoute(
                                                      builder: (context) {
                                                return Cart(
                                                    id: widget.id,
                                                    item_id: widget.item_id);
                                              }));
                                            },
                                            child: Container(
                                              alignment: Alignment.center,
                                              child: Align(
                                                alignment: Alignment.center,
                                                child: Text(
                                                  "BUY NOW",
                                                  style:
                                                      TextStyle(fontSize: 17),
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                            ),
                                            style: ElevatedButton.styleFrom(
                                              primary: Colors.blueAccent,
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 30,
                                                      vertical: 15),
                                              textStyle:
                                                  const TextStyle(fontSize: 20),
                                            ),
                                          )),
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
          )),
    );
  }
}
