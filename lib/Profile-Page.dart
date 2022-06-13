import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:proyekambw/dbservices.dart';
import 'package:proyekambw/detdata.dart';
import 'package:proyekambw/main.dart';
import 'package:file_picker/file_picker.dart';
import 'package:proyekambw/widget/profile_widget.dart';
import 'Profile.dart';
import 'storage_files.dart';
import 'package:firebase_storage/firebase_storage.dart'
    as Firebase_storage_import;

class ProfilePage extends StatefulWidget {
  final Profile_User? dataUser;
  const ProfilePage({Key? key, this.dataUser}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final user = FirebaseAuth.instance.currentUser!;
  final Storage storage = Storage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Profile"),
          ],
        ),
        backgroundColor: Colors.blueGrey,
      ),
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
                        const SizedBox(height: 30),
                        FutureBuilder(
                          future: storage.downloadURL(user.email.toString()),
                          builder: (BuildContext context,
                              AsyncSnapshot<String> snapshot) {
                            if (snapshot.connectionState ==
                                    ConnectionState.done &&
                                snapshot.hasData) {
                              // return Container(
                              //   width: 300,
                              //   height: 250,
                              //   child: Image.network(
                              //     snapshot.data!,
                              //     fit: BoxFit.cover,
                              //   ),
                              // );
                              return ProfileWidget(
                                snapshot: snapshot,
                                onClicked: () async {
                                  setState(
                                    () async {
                                      storage.listFiles();
                                    },
                                  );
                                  final result = await FilePicker.platform
                                      .pickFiles(
                                          allowMultiple: false,
                                          type: FileType.custom,
                                          allowedExtensions: ['png']);
                                  if (result == null) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                            content: Text("No File Selected")));
                                    return null;
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                            content: Text("File Selected")));
                                  }
                                  final path = result.files.single.path!;
                                  final filename = user.email!;
                                  //final fileName = result.files.single.name;
                                  print(path);
                                  // print(fileName);
                                  storage.UploadFile(filename, path)
                                      .then((value) => print('Done'));
                                },
                              );
                            }
                            return Container();
                          },
                        ),
                        Container(
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 20,
                              ),
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
                            ],
                          ),
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
                        ElevatedButton(
                            onPressed: () {
                              setState(() {
                                final dtbaru = Profile_User(
                                  item_ID: item_ID,
                                  item_Email: item_Email,
                                  item_Nama: item_Nama,
                                  item_Password: item_Password,
                                  item_Saldo: item_Saldo,
                                  item_alamat: item_alamat,
                                  item_noHP: item_noHP,
                                );
                                // Database.ubahData(KTM: dtbaru);
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => detData(
                                      dataDet: dtbaru,
                                    ),
                                  ),
                                );
                              });
                            },
                            child: Text("Rubah Data Profile")),
                        ElevatedButton(
                            onPressed: () {
                              setState(() async {
                                final result = await FilePicker.platform
                                    .pickFiles(
                                        allowMultiple: false,
                                        type: FileType.custom,
                                        allowedExtensions: ['png']);
                                if (result == null) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content: Text("No File Selected")));
                                  return null;
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content: Text("File Selected")));
                                }
                                final path = result.files.single.path!;
                                final filename = user.email!;
                                //final fileName = result.files.single.name;
                                print(path);
                                // print(fileName);
                                storage.UploadFile(filename, path)
                                    .then((value) => print('Done'));
                              });
                            },
                            child: Text("Upload File")),
                        ElevatedButton(
                            onPressed: () {
                              setState(() {
                                storage.listFiles();
                              });
                            },
                            child: Icon(Icons.refresh)),
                        FutureBuilder(
                          future: storage.listFiles(),
                          builder: (BuildContext context,
                              AsyncSnapshot<Firebase_storage_import.ListResult>
                                  snapshot) {
                            if (snapshot.connectionState ==
                                    ConnectionState.done &&
                                snapshot.hasData) {
                              return Container(
                                padding: const EdgeInsets.all(20),
                                height: 100,
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  shrinkWrap: true,
                                  itemCount: snapshot.data!.items.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: ElevatedButton(
                                        onPressed: () {
                                          snapshot.data!.items[index].delete();
                                        },
                                        child: Text(
                                            snapshot.data!.items[index].name),
                                      ),
                                    );
                                  },
                                ),
                              );
                            }
                            if (snapshot.connectionState ==
                                    ConnectionState.waiting ||
                                !snapshot.hasData) {
                              return CircularProgressIndicator();
                            }

                            return Container();
                          },
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
