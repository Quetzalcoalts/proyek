import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'main.dart';

class detMakanan extends StatefulWidget {
  final List id;
  const detMakanan({ Key? key, required this.id}) : super(key: key);
  @override
  State<detMakanan> createState() => _detMakananState();
}

class _detMakananState extends State<detMakanan> {
  // int id2 = String.parse(id);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: Container(
        child: Column(
          children: [
            Row(
              children: [
                Text("${widget.id[0]['display']['displayName']}")
              ],
            )
          ],
        )
      ),
    );
  }
}