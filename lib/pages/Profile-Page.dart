import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:proyekambw/widget/RefreshWidget.dart';
import 'package:proyekambw/navbar.dart';
import 'package:proyekambw/pages/cart_firebase.dart';
import 'package:proyekambw/pages/topup.dart';
import 'package:proyekambw/services/dbservices.dart';
import 'package:proyekambw/pages/detdata-changeprofile.dart';
import 'package:proyekambw/pages/history.dart';
import 'package:proyekambw/main.dart';
import 'package:file_picker/file_picker.dart';
import 'package:proyekambw/pages/shopping_Payment.dart';
import 'package:proyekambw/widget/profile_widget.dart';
import 'package:proyekambw/class/Profile.dart';
import 'package:proyekambw/services/storage_files.dart';
import 'package:firebase_storage/firebase_storage.dart'
    as Firebase_storage_import;

late Profile_User user_global;

class ProfilePage extends StatefulWidget {
  final Profile_User? dataUser;
  const ProfilePage({Key? key, this.dataUser}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final user = FirebaseAuth.instance.currentUser!;
  final Storage storage = Storage();

  Future<void> _refresh() async {
    setState(() {
      storage.listFiles();
    });
    return Future.delayed(Duration(seconds: 3));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Profile"),
          ],
        ),
        backgroundColor: HexColor('#2596be'),
      ),
      body: RefreshIndicator(
        onRefresh: _refresh,
        child: StreamBuilder<QuerySnapshot>(
          stream: Database.getData(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const Text("Error");
            } else if (snapshot.hasData || snapshot.data != null) {
              return ListView.separated(
                itemBuilder: (BuildContext context, int index) {
                  DocumentSnapshot user_fromfirebase =
                      snapshot.data!.docs[index];
                  String item_ID = user_fromfirebase["Id"];
                  String item_Nama = user_fromfirebase["Nama"];
                  String item_alamat = user_fromfirebase["Alamat"];
                  String item_noHP = user_fromfirebase["Alamat"];
                  String item_Saldo = user_fromfirebase["Saldo"];
                  String item_Email = user_fromfirebase["Email"];
                  String item_Password = user_fromfirebase["Password"];
                  // _jumlah = snapshot.data!.docs.length;

                  if (item_Email == user.email) {
                    Profile_User ax = Profile_User(
                        item_Nama: item_Nama,
                        item_alamat: item_alamat,
                        item_noHP: item_noHP,
                        item_Saldo: item_Saldo,
                        item_ID: item_ID,
                        item_Email: item_Email,
                        item_Password: item_Password);
                    user_global = ax;
                    return SingleChildScrollView(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        child: Column(
                          children: [
                            Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  const SizedBox(height: 15),
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        primary: Colors.white,
                                        onPrimary: Colors.blue,
                                        shadowColor: Colors.blueAccent,
                                        elevation: 5),
                                    onPressed: () {
                                      showDialog<String>(
                                        context: context,
                                        builder: (BuildContext context) =>
                                            AlertDialog(
                                          title: const Text('LogOut'),
                                          content: const Text('Yakin Log Out?'),
                                          actions: <Widget>[
                                            TextButton(
                                              onPressed: () => Navigator.pop(
                                                  context, 'Cancel'),
                                              child: const Text('Cancel'),
                                            ),
                                            TextButton(
                                              onPressed: () {
                                                FirebaseAuth.instance.signOut();
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        LoginPage(),
                                                  ),
                                                );
                                              },
                                              child: const Text('LogOut'),
                                            ),
                                          ],
                                        ),
                                      );
                                      // FirebaseAuth.instance.signOut();
                                    },
                                    child: Container(
                                      child: Row(
                                        children: const [
                                          Text('Log Out'), // <-- Text
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Icon(
                                            // <-- Icon
                                            Icons.exit_to_app,
                                            size: 24.0,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ]),
                            const SizedBox(height: 30),
                            FutureBuilder(
                              future:
                                  storage.downloadURL(user.email.toString()),
                              builder: (BuildContext context,
                                  AsyncSnapshot<String> snapshot) {
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
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                              content:
                                                  Text("No File Selected")));
                                      return null;
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
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
                                  user_email: user.email!.toString(),
                                );
                              },
                            ),
                            Container(
                              child: Column(
                                children: [
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Text(
                                    "${item_Nama}",
                                    style: const TextStyle(
                                      fontFamily: "Raleway",
                                      fontWeight: FontWeight.bold,
                                      fontSize: 30,
                                      fontStyle: FontStyle.normal,
                                      color: Colors.blue,
                                      decorationThickness: 0.0,
                                      decorationColor: Colors.red,
                                      decorationStyle:
                                          TextDecorationStyle.dotted,
                                      letterSpacing: 0.0,
                                      wordSpacing: 0,
                                      shadows: [
                                        Shadow(
                                          color: Colors.white,
                                          blurRadius: 2.0,
                                          offset: const Offset(1, 1),
                                        )
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text("Email : ${item_Email}"),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        primary: Colors.white,
                                        onPrimary: Colors.blue,
                                        shadowColor: Colors.blueAccent,
                                        elevation: 5),
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
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: const [
                                        Text('Edit Data'), // <-- Text
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Icon(
                                          // <-- Icon
                                          Icons.edit,
                                          size: 24.0,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 40,
                            ),
                            Container(
                              padding: EdgeInsets.fromLTRB(40, 0, 40, 0),
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    primary: Colors.white,
                                    onPrimary: Colors.blue,
                                    shadowColor: Colors.blueAccent,
                                    elevation: 5),
                                onPressed: () {
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                    return History();
                                  }));
                                },
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          flex: 5,
                                          child: Row(
                                            children: const [
                                              Expanded(
                                                flex: 1,
                                                child: Icon(
                                                  Icons.history,
                                                  size: 20.0,
                                                ),
                                              ),
                                              Expanded(
                                                flex: 5,
                                                child: Text(
                                                  'History Shop',
                                                  style:
                                                      TextStyle(fontSize: 16),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const Expanded(
                                          flex: 1,
                                          child: Icon(
                                            Icons.navigate_next,
                                            size: 20.0,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.fromLTRB(40, 0, 40, 0),
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    primary: Colors.white,
                                    onPrimary: Colors.blue,
                                    shadowColor: Colors.blueAccent,
                                    elevation: 5),
                                onPressed: () {
                                  final user03 = Profile_User(
                                      item_Nama: item_Nama,
                                      item_alamat: item_alamat,
                                      item_noHP: item_noHP,
                                      item_Saldo: item_Saldo,
                                      item_ID: item_ID,
                                      item_Email: item_Email,
                                      item_Password: item_Password);
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) {
                                        return PaymentTopUp(
                                          user_topup: user03,
                                        );
                                      },
                                    ),
                                  );
                                },
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          flex: 5,
                                          child: Row(
                                            children: const [
                                              Expanded(
                                                flex: 1,
                                                child: Icon(
                                                  Icons.money,
                                                  size: 20.0,
                                                ),
                                              ),
                                              Expanded(
                                                flex: 5,
                                                child: Text(
                                                  'Pembayaran',
                                                  style:
                                                      TextStyle(fontSize: 16),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const Expanded(
                                          flex: 1,
                                          child: Icon(
                                            Icons.navigate_next,
                                            size: 20.0,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.fromLTRB(40, 0, 40, 0),
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    primary: Colors.white,
                                    onPrimary: Colors.blue,
                                    shadowColor: Colors.blueAccent,
                                    elevation: 5),
                                onPressed: () {
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                    return Cart_Firebase();
                                  }));
                                },
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          flex: 5,
                                          child: Row(
                                            children: const [
                                              Expanded(
                                                flex: 1,
                                                child: Icon(
                                                  Icons.history,
                                                  size: 20.0,
                                                ),
                                              ),
                                              Expanded(
                                                flex: 5,
                                                child: Text(
                                                  'Cart',
                                                  style:
                                                      TextStyle(fontSize: 16),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const Expanded(
                                          flex: 1,
                                          child: Icon(
                                            Icons.navigate_next,
                                            size: 20.0,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
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
      ),
    );
  }
}
