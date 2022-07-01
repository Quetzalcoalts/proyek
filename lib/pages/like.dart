import 'package:flutter/material.dart';
import 'package:proyekambw/pages/detMakanan.dart';

import '../main.dart';

List gambarl = [];
List namal = [];

class Like extends StatefulWidget {
  final int? index;
  const Like({Key? key, this.index}) : super(key: key);

  @override
  State<Like> createState() => _LikeState();
}

class _LikeState extends State<Like> {
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
          title: Container(
              padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
              child: Text("History Page")),
        ),
        body: ListView.builder(
            itemCount: namal.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return detMakanan(id: nama, item_id: index);
                  }));
                },
                child: Container(
                  padding: EdgeInsets.all(8),
                  child: Column(children: [
                    Container(
                      child: Card(
                        child: ListTile(
                          leading: Image.network(
                            gambarl[index],
                            width: 70,
                            height: 70,
                          ),
                          title: Container(child: Text(namal[index])),
                          subtitle: Column(
                            children: [
                              Column(
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.star,
                                        size: 18,
                                        color: Colors.yellow,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 5),
                                        child: Text(nama[index]['content']
                                                    ['reviews'] !=
                                                null
                                            ? nama[index]['content']['reviews']
                                                        ['averageRating'] ==
                                                    null
                                                ? "3"
                                                : Convert(nama[index]['content']
                                                            ['reviews']
                                                        ['averageRating']
                                                    .toString())
                                            : "3"),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                          trailing: Container(
                              decoration: BoxDecoration(
                                  color: Colors.blue,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(40))),
                              width: 38,
                              height: 38,
                              child: Column(
                                children: [
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(0, 10, 0, 0),
                                    child: Text(
                                      "50K",
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    ),
                                  )
                                ],
                              )),
                        ),
                      ),
                    ),
                  ]),
                ),
              );
            }));
  }
}
