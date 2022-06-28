import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:proyekambw/navbar.dart';
import 'package:proyekambw/pages/shopping_Payment.dart';
import 'detMakanan.dart';
import 'package:proyekambw/main.dart';

List cart_namah = [];
List cart_gambarh = [];
List listindex = [];
List listasli = [];
int count = 0;

class History extends StatefulWidget {
  const History({Key? key}) : super(key: key);

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  final user = FirebaseAuth.instance.currentUser!;
  final int uang_harga = harga;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0.8,
          backgroundColor: Color.fromARGB(255, 4, 162, 241),
          title: Container(
              padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
              child: Text("History Page")),
        ),
        body: ListView.builder(
          itemCount: cart_namah.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return detMakanan(id: nama, item_id: index);
                }));
              },
              child: Container(
                padding: EdgeInsets.all(10),
                child: Column(
                  children: [
                    Card(
                      child: ListTile(
                        leading: ConstrainedBox(
                          constraints: BoxConstraints(
                            minWidth: 44,
                            minHeight: 44,
                            maxWidth: 64,
                            maxHeight: 64,
                          ),
                          child: Image.network(cart_gambarh[index], fit: BoxFit.cover),
                        ),
                        title: Text(cart_namah[index]),
                      ),
                    ),
                  ]
                ),
              ),
            );
          }
        )
    ); 
  }
}
