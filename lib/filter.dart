import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:proyekambw/main.dart';

import 'detMakanan.dart';

int check = 3;
List rat3 = [];
List rat4 = [];
List rat5 = [];

class Filter extends StatefulWidget {
  final List isi;
  const Filter({ Key? key, required this.isi}) : super(key: key);

  @override
  State<Filter> createState() => _FilterState();
}

class _FilterState extends State<Filter> {
  void checking3(){
    setState(() {
      check = 3;
    });
  }

  void checking4(){
    setState(() {
      check = 4;
    });
  }

  void checking5(){
    setState(() {
      check = 5;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.fromLTRB(8, 30, 20, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                FlatButton(onPressed: (){
                  checking3();
                }, child: Text("Rating 3")),
                FlatButton(onPressed: (){
                  checking4();
                }, child: Text("Rating 4")),
                FlatButton(onPressed: (){
                  checking5();
                }, child: Text("Rating 5")),
              ],
            ),
          ),
          Container(
            child: check == 3
            ? Expanded(
              child: ListView.builder(
                itemCount: widget.isi.length,
                itemBuilder: (BuildContext context, index){
                  return Text("${widget.isi[index]['content']['reviews'] != null ? widget.isi[index]['content']['reviews']['averageRating'] : "2"}");
                },
              ),
            )
            : check == 4 
              ? Text("4")
              : Text("5")
          )
        ],
      ),
    );
  }
}