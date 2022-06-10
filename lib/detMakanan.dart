import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'main.dart';

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
        elevation: 0,
        backgroundColor: Color.fromARGB(255, 4, 162, 241),
      ),
      body: 
      Container(
        color: Color.fromARGB(255, 4, 162, 241),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(24),
                  topRight: Radius.circular(24),
                )
              ),
              margin: EdgeInsets.only(top: 203),
              height: 400,
            )
          ],
        )
      ),
    );
  }
}
