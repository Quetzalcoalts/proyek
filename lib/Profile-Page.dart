import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:proyekambw/main.dart';

import 'Profile.dart';

class ProfilePage extends StatefulWidget {
  final Profile_User? dataUser;
  const ProfilePage({Key? key, this.dataUser}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final user = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            alignment: Alignment.topLeft,
            child: Column(
              children: [
                Text("Nama : ${widget.dataUser?.item_Nama ?? ""}"),
                SizedBox(
                  height: 10,
                ),
                Text("Alamat : ${widget.dataUser?.item_alamat ?? ""}"),
                SizedBox(
                  height: 10,
                ),
                Text("Nomor HP :${widget.dataUser?.item_noHP ?? ""}"),
                SizedBox(
                  height: 10,
                ),
                Text("Saldo : ${widget.dataUser?.item_Saldo ?? ""}"),
                SizedBox(
                  height: 10,
                ),
                Text("Nama : ${user.displayName}"),
                SizedBox(
                  height: 10,
                ),
                Text("Email : ${user.email ?? ""}"),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
          Column(
            children: [
              Text(
                "Signed In as",
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(
                height: 8,
              ),
              Text(
                user.email!,
                style: TextStyle(fontSize: 20),
              )
            ],
          ),
          SizedBox(height: 15),
          Container(
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                minimumSize: Size.fromHeight(50),
              ),
              icon: Icon(
                Icons.arrow_back,
                size: 32,
              ),
              label: Text(
                "Sign Out",
                style: TextStyle(fontSize: 24, color: Colors.black),
              ),
              onPressed: () => FirebaseAuth.instance.signOut(),
            ),
          ),
          Container(
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                minimumSize: Size.fromHeight(50),
              ),
              icon: Icon(
                Icons.arrow_back,
                size: 32,
              ),
              label: Text(
                "Home Page",
                style: TextStyle(fontSize: 24, color: Colors.black),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return MyApp();
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
