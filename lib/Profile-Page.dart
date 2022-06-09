import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:proyekambw/dbservices.dart';
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
      body: StreamBuilder<QuerySnapshot>(
        stream: Database.getData(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text("Error");
          } else if (snapshot.hasData || snapshot.data != null) {
            return ListView.separated(
              itemBuilder: (BuildContext context, int index) {
                DocumentSnapshot datas = snapshot.data!.docs[index];
                String no = datas["Id"].toString();
                String Nama = datas["Nama"];
                // _jumlah = snapshot.data!.docs.length;
                return ListTile(
                  onTap: () {},
                  onLongPress: () {
                    //Database.DeleteData(Nama_KTM: no.toString());
                  },
                  title: Text(no.toString()),
                  subtitle: Text(Nama),
                );
              },
              itemCount: snapshot.data!.docs.length,
              separatorBuilder: (BuildContext context, int index) => SizedBox(
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
    );
  }
}
