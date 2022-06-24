import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:proyekambw/dbservices.dart';
import 'package:proyekambw/shopping_Payment.dart';
import 'package:proyekambw/testing_pembayaran.dart';

class Cart_Firebase extends StatefulWidget {
  const Cart_Firebase({Key? key}) : super(key: key);

  @override
  State<Cart_Firebase> createState() => _Cart_FirebaseState();
}

class _Cart_FirebaseState extends State<Cart_Firebase> {
  List<keperluan_cart> cart_trial = List.empty(growable: true);

  final user = FirebaseAuth.instance.currentUser!;
  @override
  Future<void> _refresh() async {
    setState(() {
      Database_user.getData(user.email.toString());
    });
    return Future.delayed(Duration(seconds: 3));
  }

  int counter = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: ElevatedButton(
        onPressed: () {
          int counter2 = counter;
          setState(() {
            counter2 = counter;
            counter = 0;
          });
          print('Counter : $counter');
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Pembayaran(
                totaluang: counter2,
              ),
            ),
          );
        },
        child: Text("Bayar Semua"),
      ),
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
                return ListView.separated(
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
                    counter += cart_trial[index].cuang;
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
