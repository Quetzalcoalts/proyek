import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:proyekambw/Profile-Page.dart';
import 'package:proyekambw/dbservices.dart';
import 'package:proyekambw/main.dart';
import 'package:proyekambw/navbar.dart';

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
  final _formKey = GlobalKey<FormState>();
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

  InputDecoration InputBox(String name, String hint) {
    return InputDecoration(
      labelText: name,
      hintText: hint,
      fillColor: Colors.white,
      filled: true,
      contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 10),
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(100.0),
          borderSide: BorderSide(color: Colors.grey)),
      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(100.0),
          borderSide: BorderSide(color: Colors.grey.shade400)),
      errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(100.0),
          borderSide: BorderSide(color: Colors.red, width: 2.0)),
      focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(100.0),
          borderSide: BorderSide(color: Colors.red, width: 2.0)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Detail Data Notes"),
        // ),
        // body: Container(
        //   margin: EdgeInsets.all(8),
        //   child: Column(
        //     children: [
        //       TextField(
        //         controller: ctr_DaftarId,
        //         enabled: _isDisabled,
        //         decoration: InputDecoration(
        //             border: OutlineInputBorder(), labelText: 'Masukkan No ID'),
        //       ),
        //       SizedBox(
        //         width: 10,
        //         height: 10,
        //       ),
        //       TextField(
        //         controller: ctr_DaftarNama,
        //         decoration: InputDecoration(
        //             border: OutlineInputBorder(), labelText: 'Masukkan Nama'),
        //       ),
        //       SizedBox(
        //         width: 10,
        //         height: 10,
        //       ),
        //       TextField(
        //         controller: ctr_DaftarAlamat,
        //         decoration: InputDecoration(
        //             border: OutlineInputBorder(), labelText: 'Masukkan Alamat'),
        //       ),
        //       SizedBox(
        //         width: 10,
        //         height: 10,
        //       ),
        //       TextField(
        //         controller: ctr_DaftarNoHp,
        //         decoration: InputDecoration(
        //             border: OutlineInputBorder(), labelText: 'Masukkan No Hp'),
        //       ),
        //       SizedBox(
        //         width: 10,
        //         height: 10,
        //       ),
        //       TextField(
        //         controller: ctr_DaftarSaldo,
        //         decoration: InputDecoration(
        //             border: OutlineInputBorder(), labelText: 'Masukkan Saldo'),
        //       ),
        //       SizedBox(
        //         width: 10,
        //         height: 10,
        //       ),
        //       TextField(
        //         controller: ctr_DaftarEmail,
        //         decoration: InputDecoration(
        //             border: OutlineInputBorder(), labelText: 'Masukkan Email'),
        //       ),
        //       SizedBox(
        //         width: 10,
        //         height: 10,
        //       ),
        //       TextField(
        //         controller: ctr_DaftarPassword,
        //         decoration: InputDecoration(
        //             border: OutlineInputBorder(),
        //             labelText: 'Masukkan Password Email'),
        //       ),
        //       SizedBox(
        //         width: 10,
        //         height: 10,
        //       ),
        //       ElevatedButton(
        //         onPressed: () {
        //           final user02 = Profile_User(
        //               item_ID: ctr_DaftarId.text.toString(),
        //               item_Nama: ctr_DaftarNama.text.toString(),
        //               item_alamat: ctr_DaftarAlamat.text.toString(),
        //               item_noHP: ctr_DaftarNoHp.text.toString(),
        //               item_Saldo: ctr_DaftarSaldo.text.toString(),
        //               item_Email: ctr_DaftarEmail.text.toString(),
        //               item_Password: ctr_DaftarPassword.text.toString());
        //           Database.tambahData(user01: user02);
        //           FirebaseAuth.instance
        //               .createUserWithEmailAndPassword(
        //                 email: ctr_DaftarEmail.text.toString(),
        //                 password: ctr_DaftarPassword.text.toString(),
        //               )
        //               .then(
        //                 (value) => {
        //                   print("Created New Account"),
        //                   Navigator.push(
        //                     context,
        //                     MaterialPageRoute(
        //                       builder: (context) => MainPage(),
        //                     ),
        //                   ),
        //                 },
        //               );
        //         },
        //         child: Text("Sign Up"),
        //       )
        //     ],
        //   ),
        // ));
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.fromLTRB(25, 50, 25, 10),
          padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
          alignment: Alignment.center,
          child: Column(
            children: [
              Form(
                  key: _formKey,
                  child: Column(children: [
                    Container(
                      child: TextField(
                          controller: ctr_DaftarNama,
                          textInputAction: TextInputAction.next,
                          decoration:
                              InputBox("Input Nama", "Enter Name Here")),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Container(
                      child: TextField(
                          controller: ctr_DaftarAlamat,
                          textInputAction: TextInputAction.next,
                          decoration:
                              InputBox("Input Alamat", "Enter Alamat Here")),
                    ),
                    SizedBox(height: 20.0),
                    Container(
                      child: TextFormField(
                        controller: ctr_DaftarEmail,
                        textInputAction: TextInputAction.next,
                        decoration: InputBox("Input Email", "Enter Email Here"),
                        keyboardType: TextInputType.emailAddress,
                        validator: (val) {
                          if (!(val!.isEmpty) &&
                              !RegExp(r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$")
                                  .hasMatch(val)) {
                            return "Enter a valid email address";
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(height: 20.0),
                    Container(
                      child: TextFormField(
                        obscureText: true,
                        controller: ctr_DaftarPassword,
                        textInputAction: TextInputAction.next,
                        decoration:
                            InputBox("Password*", "Enter your password"),
                        validator: (val) {
                          if (val!.isEmpty) {
                            return "Please enter your password";
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(height: 20.0),
                    Container(
                      child: TextFormField(
                        controller: ctr_DaftarSaldo,
                        textInputAction: TextInputAction.next,
                        decoration: InputBox(
                            "Input Saldo Awal", "Enter Saldo Awal Here"),
                        keyboardType: TextInputType.emailAddress,
                        validator: (val) {
                          if (!(val!.isEmpty) &&
                              !RegExp(r'^[Z0-9]+$').hasMatch(val)) {
                            return "Enter a valid Saldo";
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(height: 20.0),
                    Container(
                      child: TextFormField(
                        controller: ctr_DaftarNoHp,
                        textInputAction: TextInputAction.next,
                        decoration:
                            InputBox("No Number", "Enter your mobile number"),
                        keyboardType: TextInputType.phone,
                        validator: (val) {
                          if (!(val!.isEmpty) &&
                              !RegExp(r"^(\d+)*$").hasMatch(val)) {
                            return "Enter a valid phone number";
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(height: 15.0),
                    Container(
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black26,
                              offset: Offset(0, 4),
                              blurRadius: 5.0)
                        ],
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          stops: [0.0, 1.0],
                          colors: [
                            Theme.of(context).primaryColor,
                            Theme.of(context).colorScheme.secondary,
                          ],
                        ),
                        color: Colors.deepPurple.shade300,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: ElevatedButton(
                        style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                          ),
                          minimumSize: MaterialStateProperty.all(Size(50, 50)),
                          backgroundColor:
                              MaterialStateProperty.all(Colors.transparent),
                          shadowColor:
                              MaterialStateProperty.all(Colors.transparent),
                        ),
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(40, 10, 40, 10),
                          child: Text(
                            'Sign Up'.toUpperCase(),
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            final user02 = Profile_User(
                                item_ID: ctr_DaftarId.text.toString(),
                                item_Nama: ctr_DaftarNama.text.toString(),
                                item_alamat: ctr_DaftarAlamat.text.toString(),
                                item_noHP: ctr_DaftarNoHp.text.toString(),
                                item_Saldo: ctr_DaftarSaldo.text.toString(),
                                item_Email: ctr_DaftarEmail.text.toString(),
                                item_Password:
                                    ctr_DaftarPassword.text.toString());
                            print("aman");
                            FirebaseAuth.instance
                                .createUserWithEmailAndPassword(
                                  email: ctr_DaftarEmail.text.toString(),
                                  password: ctr_DaftarPassword.text.toString(),
                                )
                                .then(
                                  (value) => {
                                    Database.tambahData(user01: user02),
                                    print("Created New Account"),
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => NavBar(),
                                      ),
                                    ),
                                  },
                                );
                          }
                        },
                      ),
                    ),
                  ]))
            ],
          ),
        ),
      ),
    );
  }
}
