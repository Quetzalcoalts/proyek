import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'main.dart';

List cart_nama = [];
List cart_gambar = [];

class Cart extends StatefulWidget {
  final String id;
  final String item_id;
  const Cart({ Key? key, required this.id, required this.item_id}) : super(key: key);

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  @override
  void initState() {
    super.initState();
    initial();
  }

  void initial(){
    setState(() {
      cart_nama.add(widget.id);
      cart_gambar.add(widget.item_id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.8,
        backgroundColor: Color.fromARGB(255, 4, 162, 241),
      ),
      body:
      ListView.builder(
        itemCount: cart_nama.length,
        itemBuilder: (context, index){
          return Text("${cart_nama[index]}");
        }
      )
    );
  }
}