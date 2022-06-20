import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:proyekambw/main.dart';

import 'detMakanan.dart';

int check = 3;
int counter = 0;
List rat3 = [];
List rat3_nama = [];
List rat3_gam = [];
List rat4 = [];
List rat4_nama = [];
List rat4_gam = [];
List rat5 = [];
List rat5_nama = [];
List rat5_gam = [];

class Filter extends StatefulWidget {
  final List isi;
  const Filter({ Key? key, required this.isi}) : super(key: key);

  @override
  State<Filter> createState() => _FilterState();
}

class _FilterState extends State<Filter> {
  void checking3(){
    if(rat3.length >= 1){
      rat3.clear();
      rat3_nama.clear();
      rat3_gam.clear();
    }
    for(int i = 0; i < widget.isi.length; i++){
      if(widget.isi[i]['content']['reviews'] != null && widget.isi[i]['content']['reviews']['averageRating'] == 3){
        rat3.add(widget.isi[i]);
        rat3_gam.add(widget.isi[i]['display']['images'][0]);
        rat3_nama.add(widget.isi[i]['display']['displayName']);
      }
    }
    print(rat3);
    setState(() {
      check = 3;
    });
  }

  void checking4(){
    if(rat4.length >= 1){
      rat4.clear();
      rat4_gam.clear();
      rat4_nama.clear();
    }
    for(int i = 0; i < widget.isi.length; i++){
      if(widget.isi[i]['content']['reviews'] != null && widget.isi[i]['content']['reviews']['averageRating'] == 4 ){
        rat4.add(widget.isi[i]);
        rat4_gam.add(widget.isi[i]['display']['images'][0]);
        rat4_nama.add(widget.isi[i]['display']['displayName']);
      }
    }
    print(rat4);
    setState(() {
      check = 4;
    });
  }

  void checking5(){
    if(rat5.length >= 1){
      rat5.clear();
      rat5_nama.clear();
      rat5_gam.clear();
    }
    for(int i = 0; i < widget.isi.length; i++){
      if(widget.isi[i]['content']['reviews'] != null && widget.isi[i]['content']['reviews']['averageRating'] == 5 ){
        rat5.add(widget.isi[i]);
        rat5_gam.add(widget.isi[i]['display']['images'][0]);
        rat5_nama.add(widget.isi[i]['display']['displayName']);
      }
    }
    print(rat5);
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
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: GridView.count(
                    crossAxisCount: 2,
                    mainAxisSpacing: 20,
                    crossAxisSpacing: 20,
                    children: List.generate(rat3.length, (index){
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(context, 
                          MaterialPageRoute(builder: (context){
                            return detMakanan(id: rat3, item_id: index);
                          }));
                        },
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Image.network("${rat3_gam[index]}",
                                  width: 170,
                                height: 110,
                                  fit: BoxFit.cover,
                                ),
                              ],
                            ),
                            Center(
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                                child: Text(
                                  "${rat3_nama[index]}",
                                  style: TextStyle(fontSize: 15),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
                    ),
                ),
              )
            : check == 4 
              ? Expanded(
                child: Padding(
                padding: const EdgeInsets.all(15),
                child: GridView.count(
                  crossAxisCount: 2,
                  mainAxisSpacing: 20,
                  crossAxisSpacing: 20,
                  children: List.generate(rat4.length, (index){
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(context, 
                        MaterialPageRoute(builder: (context){
                          return detMakanan(id: rat4, item_id: index);
                        }));
                      },
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Image.network("${rat4_gam[index]}",
                                width: 170,
                                height: 110,
                                fit: BoxFit.cover,
                              ),
                            ],
                          ),
                          Center(
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                              child: Text(
                                "${rat4_nama[index]}",
                                style: TextStyle(fontSize: 15),
                              ),
                            ),
                          ),
                        ],
                      )
                    );
                  }),
                  ),
              )
              )
              : Expanded(
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: GridView.count(
                  crossAxisCount: 2,
                  mainAxisSpacing: 20,
                  crossAxisSpacing: 20,
                  children: List.generate(rat5.length, (index){
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(context, 
                        MaterialPageRoute(builder: (context){
                          return detMakanan(id: rat5, item_id: index);
                        }));
                      },
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Image.network("${rat5_gam[index]}",
                                width: 170,
                                height: 110,
                                fit: BoxFit.cover,
                              ),
                            ],
                          ),
                          Center(
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                              child: Text(
                                "${rat5_nama[index]}",
                                style: TextStyle(fontSize: 15),
                              ),
                            ),
                          ),
                        ],
                      )
                    );
                  }),
                  ),
              )
              )
          )
        ],
      ),
    );
  }
}