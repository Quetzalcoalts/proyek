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

enum chara { button1, button2, button3 }

class Filter extends StatefulWidget {
  final List isi;
  const Filter({Key? key, required this.isi}) : super(key: key);

  @override
  State<Filter> createState() => _FilterState();
}

class _FilterState extends State<Filter> {
  chara? _selected = chara.button1;
  int selectedButton = 1;

  void checking3() {
    if (rat3.length >= 1) {
      rat3.clear();
      rat3_nama.clear();
      rat3_gam.clear();
    }
    for (int i = 0; i < widget.isi.length; i++) {
      if (widget.isi[i]['content']['reviews'] == null ||
          widget.isi[i]['content']['reviews']['averageRating'] == null) {
        rat3.add(widget.isi[i]);
        rat3_gam.add(widget.isi[i]['display']['images'][0]);
        rat3_nama.add(widget.isi[i]['display']['displayName']);
      }
    }
    for (int i = 0; i < widget.isi.length; i++) {
      if (widget.isi[i]['content']['reviews'] != null &&
          widget.isi[i]['content']['reviews']['averageRating'] != null) {
        if (widget.isi[i]['content']['reviews']['averageRating'] >= 3 &&
            widget.isi[i]['content']['reviews']['averageRating'] <= 3.99) {
          rat3.add(widget.isi[i]);
          rat3_gam.add(widget.isi[i]['display']['images'][0]);
          rat3_nama.add(widget.isi[i]['display']['displayName']);
        }
      }
    }
    print(rat3);
    setState(() {
      check = 3;
    });
  }

  void checking4() {
    if (rat4.length >= 1) {
      rat4.clear();
      rat4_gam.clear();
      rat4_nama.clear();
    }
    for (int i = 0; i < widget.isi.length; i++) {
      if (widget.isi[i]['content']['reviews'] != null &&
          widget.isi[i]['content']['reviews']['averageRating'] != null) {
        if (widget.isi[i]['content']['reviews']['averageRating'] >= 4 &&
            widget.isi[i]['content']['reviews']['averageRating'] <= 4.99) {
          rat4.add(widget.isi[i]);
          rat4_gam.add(widget.isi[i]['display']['images'][0]);
          rat4_nama.add(widget.isi[i]['display']['displayName']);
        }
      }
    }
    print(rat4);
    setState(() {
      check = 4;
    });
  }

  void checking5() {
    if (rat5.length >= 1) {
      rat5.clear();
      rat5_nama.clear();
      rat5_gam.clear();
    }
    for (int i = 0; i < widget.isi.length; i++) {
      if (widget.isi[i]['content']['reviews'] != null &&
          widget.isi[i]['content']['reviews']['averageRating'] != null) {
        if (widget.isi[i]['content']['reviews']['averageRating'] >= 5 &&
            widget.isi[i]['content']['reviews']['averageRating'] <= 5.99) {
          rat5.add(widget.isi[i]);
          rat5_gam.add(widget.isi[i]['display']['images'][0]);
          rat5_nama.add(widget.isi[i]['display']['displayName']);
        }
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
            padding: EdgeInsets.fromLTRB(0, 30, 10, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: 30,
                  height: 30,
                  padding: EdgeInsets.fromLTRB(8, 3, 0, 0),
                  child: IconButton(onPressed: (){
                    Navigator.of(context).pop();
                  }, icon: Icon(Icons.arrow_back_ios, size: 13,))
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(15, 5, 0, 0),
                  child: Row(
                    children: [
                      Radio(
                        value: chara.button1,
                        groupValue: _selected,
                        onChanged: (chara? value) {
                          setState(() {
                            _selected = value;
                            checking3();
                          });
                        },
                      ),
                      Text("Rating 3"),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(15, 5, 0, 0),
                  child: Row(
                    children: [
                      Radio(
                        value: chara.button2,
                        groupValue: _selected,
                        onChanged: (chara? value) {
                          setState(() {
                            _selected = value;
                            checking4();
                          });
                        },
                      ),
                      Text("Rating 4"),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(15, 5, 0, 0),
                  child: Row(
                    children: [
                      Radio(
                        value: chara.button3,
                        groupValue: _selected,
                        onChanged: (chara? value) {
                          setState(() {
                            _selected = value;
                            checking5();
                          });
                        },
                      ),
                      Text("Rating 4"),
                    ],
                  ),
                ),
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
                          children: List.generate(rat3.length, (index) {
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return detMakanan(id: rat3, item_id: index);
                                }));
                              },
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Image.network(
                                        "${rat3_gam[index]}",
                                        width: 170,
                                        height: 110,
                                        fit: BoxFit.cover,
                                      ),
                                    ],
                                  ),
                                  Center(
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          0, 10, 0, 0),
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
                            children: List.generate(rat4.length, (index) {
                              return GestureDetector(
                                  onTap: () {
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (context) {
                                      return detMakanan(
                                          id: rat4, item_id: index);
                                    }));
                                  },
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Image.network(
                                            "${rat4_gam[index]}",
                                            width: 170,
                                            height: 110,
                                            fit: BoxFit.cover,
                                          ),
                                        ],
                                      ),
                                      Center(
                                        child: Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              0, 10, 0, 0),
                                          child: Text(
                                            "${rat4_nama[index]}",
                                            style: TextStyle(fontSize: 15),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ));
                            }),
                          ),
                        ))
                      : Expanded(
                          child: Padding(
                          padding: const EdgeInsets.all(15),
                          child: GridView.count(
                            crossAxisCount: 2,
                            mainAxisSpacing: 20,
                            crossAxisSpacing: 20,
                            children: List.generate(rat5.length, (index) {
                              return GestureDetector(
                                  onTap: () {
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (context) {
                                      return detMakanan(
                                          id: rat5, item_id: index);
                                    }));
                                  },
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Image.network(
                                            "${rat5_gam[index]}",
                                            width: 170,
                                            height: 110,
                                            fit: BoxFit.cover,
                                          ),
                                        ],
                                      ),
                                      Center(
                                        child: Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              0, 10, 0, 0),
                                          child: Text(
                                            "${rat5_nama[index]}",
                                            style: TextStyle(fontSize: 15),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ));
                            }),
                          ),
                        )))
        ],
      ),
    );
  }
}
