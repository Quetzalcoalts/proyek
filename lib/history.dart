import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'detMakanan.dart';
import 'main.dart';

List cart_nama = [];
List cart_gambar = [];

class History extends StatefulWidget {
  final List? id;
  final int? item_id;
  const History({Key? key, this.id, this.item_id}) : super(key: key);

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  @override
  void initState() {
    super.initState();
    initial();
  }

  void initial() {
    setState(() {
      if (widget.item_id != null) {
        cart_nama.add(widget.id?[widget.item_id!]['display']['displayName']);
        cart_gambar.add(widget.id?[widget.item_id!]['display']['images'][0]);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0.8,
          backgroundColor: Color.fromARGB(255, 4, 162, 241),
        ),
        body: ListView.builder(
            itemCount: cart_nama.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return detMakanan(id: widget.id!, item_id: widget.item_id!);
                  }));
                },
                child: Container(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Container(
                              padding: EdgeInsets.all(8),
                              color: Colors.white,
                              height: 200,
                              width: 410,
                              child: Image.network(
                                cart_gambar[index],
                                fit: BoxFit.fill,
                              )),
                        ],
                      ),
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                  margin: EdgeInsets.fromLTRB(10, 8, 0, 10),
                                  child: Text(cart_nama[index])),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            }));
  }
}
