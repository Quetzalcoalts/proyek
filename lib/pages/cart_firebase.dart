import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:proyekambw/pages/cart.dart';
import 'package:proyekambw/services/dbservices.dart';
import 'package:proyekambw/pages/shopping_Payment.dart';
import 'package:proyekambw/class/testing_pembayaran.dart';

class Cart_Firebase extends StatefulWidget {
  const Cart_Firebase({Key? key}) : super(key: key);

  @override
  State<Cart_Firebase> createState() => _Cart_FirebaseState();
}

class _Cart_FirebaseState extends State<Cart_Firebase> {
  List<keperluan_cart> cart_trial = List.empty(growable: true);
  int s = 0;
  final user = FirebaseAuth.instance.currentUser!;
  void cektotal(List<keperluan_cart> a, int b) {
    for (int i = 0; i < a.length; i++) {
      b += a[i].cuang;
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Future<void> _refresh() async {
    setState(() {
      Database_user.getData(user.email.toString());
      print(' 111111 $s');
      s = counter;
      print('11111$s');
    });
    return Future.delayed(Duration(seconds: 3));
  }

  int counter = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: _refresh,
        child: Container(
          child: StreamBuilder<QuerySnapshot>(
            stream: Database_user.getData(user.email.toString()),
            builder: (context, snapshot) {
              print(user.email.toString());
              if (snapshot.hasError) {
                return Text("Error");
              } else if (snapshot.hasData || snapshot.data != null) {
                s = 0;
                counter = 0;
                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 4,
                      child: ListView.separated(
                        itemBuilder: (BuildContext context, int index) {
                          print("Cek : " + user.email.toString());
                          DocumentSnapshot datas = snapshot.data!.docs[index];
                          String Nama = datas["nama"].toString();
                          String cdesciption = datas["description"].toString();
                          String ccontact = datas["contact"].toString();
                          String cemail = datas["email"].toString();
                          int cuang = datas["uang"];
                          cart_trial.add(keperluan_cart(
                              cuang: cuang,
                              cname: Nama,
                              cdesciption: cdesciption,
                              cemail: cemail,
                              ccontact: ccontact));
                          // for (int i = 0; i < cart_trial.length; i++) {
                          //   counter += cart_trial[i].cuang;
                          // }
                          counter += cart_trial[index].cuang;
                          s = counter;
                          print('s2 : $s, c2: $counter');
                          return Container(
                            child: ListTile(
                              title: Text(Nama.toString()),
                              subtitle: Text(cdesciption),
                              onTap: () {
                                print(datas["email"]);
                              },
                              onLongPress: () {
                                //sfinal deleteDB = keperluan_cart(cuang: cuang, cname: Nama, cdesciption: cdesciption, cemail: cemail, ccontact: ccontact)
                                Database_user.DeleteData(
                                    name_user01: Nama, email_user01: cemail);
                              },
                            ),
                          );
                        },
                        itemCount: snapshot.data!.docs.length,
                        separatorBuilder: (BuildContext context, int index) =>
                            SizedBox(
                          height: 8.0,
                        ),
                      ),
                    ),
                    Expanded(
                        flex: 1,
                        child: Container(
                          child: Row(
                            children: [
                              Expanded(
                                flex: 3,
                                child: Container(
                                  padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      Expanded(
                                        flex: 4,
                                        child: Align(
                                          alignment: Alignment.bottomLeft,
                                          child: Container(
                                            padding: EdgeInsets.fromLTRB(
                                                20, 0, 0, 0),
                                            child: Text(
                                              "Total Harga,",
                                              textAlign: TextAlign.start,
                                              style: TextStyle(fontSize: 20),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                          flex: 1,
                                          child: Container(
                                            padding: EdgeInsets.fromLTRB(
                                                20, 0, 0, 0),
                                            child: Text("Rp. $s",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 20)),
                                          ))
                                    ],
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 3,
                                child: SizedBox(
                                  height: double.infinity,
                                ),
                              ),
                              Expanded(
                                flex: 3,
                                child: Align(
                                  alignment: Alignment.bottomCenter,
                                  child: Container(
                                    padding: EdgeInsets.fromLTRB(0, 0, 0, 20),
                                    child: ElevatedButton(
                                      onPressed: () {
                                        setState(() {
                                          counter = 0;
                                          print('s : $s, c: $counter');
                                          for (int i = 0;
                                              i < cart_trial.length;
                                              i++) {
                                            Database_user.DeleteData(
                                                email_user01:
                                                    user.email.toString(),
                                                name_user01:
                                                    cart_trial[i].cname);
                                            cart_gambar.clear();
                                            cart_nama.clear();
                                          }
                                        });
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => Pembayaran(
                                              totaluang: s,
                                              cart_list: cart_trial,
                                            ),
                                          ),
                                        );
                                      },
                                      child: Text("Bayar Semua"),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ))
                  ],
                );
              }
              return Center(
                child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.pink)),
              );
            },
          ),
        ),
      ),
    );
  }
}
