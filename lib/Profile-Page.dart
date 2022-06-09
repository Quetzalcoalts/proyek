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
            return const Text("Error");
          } else if (snapshot.hasData || snapshot.data != null) {
            return ListView.separated(
              itemBuilder: (BuildContext context, int index) {
                DocumentSnapshot user_fromfirebase = snapshot.data!.docs[index];
                String item_ID = user_fromfirebase["Id"];
                String item_Nama = user_fromfirebase["Nama"];
                String item_alamat = user_fromfirebase["Alamat"];
                String item_noHP = user_fromfirebase["Alamat"];
                String item_Saldo = user_fromfirebase["Saldo"];
                String item_Email = user_fromfirebase["Email"];
                String item_Password = user_fromfirebase["Password"];
                // _jumlah = snapshot.data!.docs.length;
                // return ListTile(
                //   onTap: () {},
                //   onLongPress: () {
                //     //Database.DeleteData(Nama_KTM: no.toString());
                //   },
                //   title: Text(no.toString()),
                //   subtitle: Text(Nama),
                // );

                if (item_Email == user.email) {
                  return Container(
                    child: Column(
                      children: [
                        Text("Nama : ${item_Nama}"),
                        const SizedBox(
                          height: 10,
                        ),
                        Text("Alamat : ${item_alamat}"),
                        const SizedBox(
                          height: 10,
                        ),
                        Text("Nomor HP : ${item_noHP}"),
                        const SizedBox(
                          height: 10,
                        ),
                        Text("Saldo : ${item_Saldo}"),
                        const SizedBox(
                          height: 10,
                        ),
                        Text("Email : ${item_Email}"),
                        const SizedBox(
                          height: 10,
                        ),
                        Text("Password : ${item_Password}"),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          "Signed In as",
                          style: TextStyle(fontSize: 16),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Text(
                          user.email!,
                          style: const TextStyle(fontSize: 20),
                        ),
                        const SizedBox(height: 15),
                        Container(
                          child: ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              minimumSize: const Size.fromHeight(50),
                            ),
                            icon: const Icon(
                              Icons.arrow_back,
                              size: 32,
                            ),
                            label: const Text(
                              "Sign Out",
                              style:
                                  TextStyle(fontSize: 24, color: Colors.black),
                            ),
                            onPressed: () => FirebaseAuth.instance.signOut(),
                          ),
                        ),
                      ],
                    ),
                  );
                }
                return Container();
              },
              itemCount: snapshot.data!.docs.length,
              separatorBuilder: (BuildContext context, int index) =>
                  const SizedBox(
                height: 8.0,
              ),
            );
          }
          return const Center(
            child: const CircularProgressIndicator(
                valueColor: const AlwaysStoppedAnimation<Color>(Colors.pink)),
          );
        },
      ),
    );
  }
}
