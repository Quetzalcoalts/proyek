import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:proyekambw/navbar.dart';
import 'package:proyekambw/services/dbservices.dart';
import 'package:proyekambw/pages/detMakanan.dart';
import 'package:proyekambw/pages/shopping_Payment.dart';
import 'package:proyekambw/class/testing_pembayaran.dart';
import '../class/Profile.dart';
import '../main.dart';

List cart_nama = [];
List cart_gambar = [];
List tumbal = [];

class Cart extends StatefulWidget {
  final List? id;
  final int? item_id;
  const Cart({Key? key, this.id, this.item_id}) : super(key: key);

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  final user = FirebaseAuth.instance.currentUser!;
  final int uang_harga = harga;
  @override
  void initState() {
    super.initState();
    initial();
  }

  void initial() {
    int c = 0;
    setState(() {
      if (widget.id == null && widget.item_id == null) {
        cart_nama.add("halo ges");
        cart_gambar.add(
            "https://media.wired.com/photos/598e35fb99d76447c4eb1f28/16:9/w_2123,h_1194,c_limit/phonepicutres-TA.jpg");
        c = 1;
      } else {
        if (cart_nama.length == 0) {
          cart_nama.add(widget.id![widget.item_id!]['display']['displayName']);
          cart_gambar.add(widget.id![widget.item_id!]['display']['images'][0]);
        } else if (cart_nama.length == 1) {
          tumbal.add(widget.id![widget.item_id!]['display']['displayName']);
          if (cart_nama[0] != tumbal[0]) {
            cart_nama
                .add(widget.id![widget.item_id!]['display']['displayName']);
            cart_gambar
                .add(widget.id![widget.item_id!]['display']['images'][0]);
          }
          tumbal.clear();
        } else {
          int counter = 0;
          tumbal.add(widget.id![widget.item_id!]['display']['displayName']);
          for (int i = 0; i < cart_nama.length; i++) {
            if (cart_nama[i] != tumbal[0]) {
              counter++;
            }
            if (counter == cart_nama.length) {
              cart_nama
                  .add(widget.id![widget.item_id!]['display']['displayName']);
              cart_gambar
                  .add(widget.id![widget.item_id!]['display']['images'][0]);
            }
          }
        }
      }
      if (c == 1) {
        cart_gambar.clear();
        cart_nama.clear();
        c = 0;
      }
      tumbal.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0.8,
          backgroundColor: Color.fromARGB(255, 4, 162, 241),
        ),
        body: Column(
          children: [
            Expanded(
              flex: 0,
              child: Container(
                padding: EdgeInsets.only(right: 25),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton.icon(
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return NavBar();
                        }));
                      },
                      icon: Icon(Icons.home),
                      label: Text("Home"),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 5,
              child: ListView.builder(
                  itemCount: cart_nama.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return detMakanan(
                              id: widget.id!, item_id: widget.item_id!);
                        }));
                      },
                      child: SingleChildScrollView(
                        child: Container(
                          padding: EdgeInsets.all(20),
                          color: Colors.white,
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    flex: 5,
                                    child: Container(
                                      padding: EdgeInsets.all(8),
                                      color: Colors.white,
                                      height: 200,
                                      constraints: BoxConstraints(
                                          maxWidth: double.infinity),
                                      child: Image.network(
                                        cart_gambar[index],
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        flex: 4,
                                        child: Container(
                                            color: Colors.white,
                                            width: 250,
                                            margin: EdgeInsets.fromLTRB(
                                                10, 8, 0, 10),
                                            child: Card(
                                              elevation: 0,
                                              child: Text(
                                                cart_nama[index],
                                                overflow: TextOverflow.visible,
                                                maxLines: 4,
                                              ),
                                            )),
                                      ),
                                      Expanded(
                                        flex: 3,
                                        child: Container(
                                          height: 30,
                                          width: 100,
                                          color: Colors.blue,
                                          margin:
                                              EdgeInsets.fromLTRB(10, 8, 8, 10),
                                          child: ElevatedButton(
                                              onPressed: () {
                                                final db = keperluan_cart(
                                                    cuang: uang_harga,
                                                    cname: cart_nama[index],
                                                    cdesciption:
                                                        user.email.toString(),
                                                    cemail:
                                                        user.email.toString(),
                                                    ccontact: user.toString());
                                                print("Ke Pembayaran");
                                                Navigator.push(context,
                                                    MaterialPageRoute(
                                                        builder: (context) {
                                                  return Pembayaran(
                                                    cart: db,
                                                  );
                                                }));
                                              },
                                              child: Text("Buy Now")),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 3,
                                        child: Container(
                                          height: 30,
                                          width: 100,
                                          color: Colors.blue,
                                          margin:
                                              EdgeInsets.fromLTRB(10, 8, 8, 10),
                                          child: ElevatedButton(
                                              onPressed: () {
                                                Database_user.DeleteData(
                                                    name_user01:
                                                        cart_nama[index]
                                                            .toString(),
                                                    email_user01:
                                                        user.email.toString());
                                                print(
                                                    "Remove Cart in firebase");
                                              },
                                              child: Text("Remove")),
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
            ),
          ],
        ));
  }
}
