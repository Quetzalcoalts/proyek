import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:proyekambw/Profile-Page.dart';
import 'package:proyekambw/dbservices.dart';
import 'package:proyekambw/main.dart';

import 'Profile.dart';

class SignUp_Page extends StatefulWidget {
  const SignUp_Page({Key? key}) : super(key: key);

  @override
  State<SignUp_Page> createState() => _SignUp_PageState();
}

class _SignUp_PageState extends State<SignUp_Page> {
  final ctr_DaftarId = TextEditingController();
  final ctr_DaftarNama = TextEditingController();
  final ctr_DaftarAlamat = TextEditingController();
  final ctr_DaftarNoHp = TextEditingController();
  final ctr_DaftarSaldo = TextEditingController();
  final ctr_DaftarEmail = TextEditingController();
  final ctr_DaftarPassword = TextEditingController();
  bool _isDisabled = false;
  @override
  void dispose() {
    ctr_DaftarId.dispose();
    ctr_DaftarNama.dispose();
    ctr_DaftarAlamat.dispose();
    ctr_DaftarNoHp.dispose();
    ctr_DaftarSaldo.dispose();
    ctr_DaftarEmail.dispose();
    ctr_DaftarPassword.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  void initState() {
    ctr_DaftarId.text = "";
    ctr_DaftarNama.text = "";
    ctr_DaftarAlamat.text = "";
    ctr_DaftarNoHp.text = "";
    ctr_DaftarSaldo.text = "";
    ctr_DaftarEmail.text = "";
    ctr_DaftarPassword.text = "";
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Detail Data Notes"),
        ),
        body: Container(
          margin: EdgeInsets.all(8),
          child: Column(
            children: [
              TextField(
                controller: ctr_DaftarId,
                enabled: _isDisabled,
                decoration: InputDecoration(
                    border: OutlineInputBorder(), labelText: 'Masukkan No ID'),
              ),
              SizedBox(
                width: 10,
                height: 10,
              ),
              TextField(
                controller: ctr_DaftarNama,
                decoration: InputDecoration(
                    border: OutlineInputBorder(), labelText: 'Masukkan Nama'),
              ),
              SizedBox(
                width: 10,
                height: 10,
              ),
              TextField(
                controller: ctr_DaftarAlamat,
                decoration: InputDecoration(
                    border: OutlineInputBorder(), labelText: 'Masukkan Alamat'),
              ),
              SizedBox(
                width: 10,
                height: 10,
              ),
              TextField(
                controller: ctr_DaftarNoHp,
                decoration: InputDecoration(
                    border: OutlineInputBorder(), labelText: 'Masukkan No Hp'),
              ),
              SizedBox(
                width: 10,
                height: 10,
              ),
              TextField(
                controller: ctr_DaftarSaldo,
                decoration: InputDecoration(
                    border: OutlineInputBorder(), labelText: 'Masukkan Saldo'),
              ),
              SizedBox(
                width: 10,
                height: 10,
              ),
              TextField(
                controller: ctr_DaftarEmail,
                decoration: InputDecoration(
                    border: OutlineInputBorder(), labelText: 'Masukkan Email'),
              ),
              SizedBox(
                width: 10,
                height: 10,
              ),
              TextField(
                controller: ctr_DaftarPassword,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Masukkan Password Email'),
              ),
              SizedBox(
                width: 10,
                height: 10,
              ),
              ElevatedButton(
                onPressed: () {
                  final user02 = Profile_User(
                      item_ID: ctr_DaftarId.text.toString(),
                      item_Nama: ctr_DaftarNama.text.toString(),
                      item_alamat: ctr_DaftarAlamat.text.toString(),
                      item_noHP: ctr_DaftarNoHp.text.toString(),
                      item_Saldo: ctr_DaftarSaldo.text.toString(),
                      item_Email: ctr_DaftarEmail.text.toString(),
                      item_Password: ctr_DaftarPassword.text.toString());
                  Database.tambahData(user01: user02);
                  FirebaseAuth.instance
                      .createUserWithEmailAndPassword(
                        email: ctr_DaftarEmail.text.toString(),
                        password: ctr_DaftarPassword.text.toString(),
                      )
                      .then(
                        (value) => {
                          print("Created New Account"),
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MainPage(),
                            ),
                          ),
                        },
                      );
                },
                child: Text("Sign Up"),
              )
            ],
          ),
        ));
  }
}
