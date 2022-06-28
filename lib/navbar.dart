import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:proyekambw/class/Profile.dart';

import 'package:proyekambw/pages/Profile-Page.dart';
import 'package:proyekambw/services/dbservices.dart';
import 'main.dart';

// Profile_User user_global = Profile_User(
//     item_Nama: "item_Nama",
//     item_alamat: "item_alamat",
//     item_noHP: "item_noHP",
//     item_Saldo: "0",
//     item_ID: "item_ID",
//     item_Email: "item_Email",
//     item_Password: "item_Password");

class NavBar extends StatefulWidget {
  final bool? x1;
  const NavBar({Key? key, this.x1}) : super(key: key);

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  late final screen_navbar;
  @override
  void initState() {
    super.initState();
    if (widget.x1 != null) {
      screen_navbar = [
        MyApp(
          status: widget.x1,
        ),
        // const ProfilePage(),
      ];
    } else {
      screen_navbar = [
        const MyApp(),
        //LoginPage(),
        // const ProfilePage(),
      ];
    }
  }

  int current_index_navbar = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: AppBar(
        //   title: Container(
        //     child: StreamBuilder<QuerySnapshot>(
        //       stream: Database.getData(),
        //       builder: (context, snapshot) {
        //         if (snapshot.hasError) {
        //           return const Text("Error");
        //         } else if (snapshot.hasData || snapshot.data != null) {
        //           return ListView.separated(
        //               itemBuilder: (BuildContext context, int index) {
        //                 DocumentSnapshot user_fromfirebase =
        //                     snapshot.data!.docs[index];
        //                 String item_ID = user_fromfirebase["Id"];
        //                 String item_Nama = user_fromfirebase["Nama"];
        //                 String item_alamat = user_fromfirebase["Alamat"];
        //                 String item_noHP = user_fromfirebase["Alamat"];
        //                 String item_Saldo = user_fromfirebase["Saldo"];
        //                 String item_Email = user_fromfirebase["Email"];
        //                 String item_Password = user_fromfirebase["Password"];
        //                 print("User Email AUTH = ${user2.email.toString()}");
        //                 print("User Email Global = ${item_Email.toString()}");
        //                 if (item_Email == user2.email) {
        //                   final a = Profile_User(
        //                       item_Nama: item_Nama,
        //                       item_alamat: item_alamat,
        //                       item_noHP: item_noHP,
        //                       item_Saldo: item_Saldo,
        //                       item_ID: item_ID,
        //                       item_Email: item_Email,
        //                       item_Password: item_Password);
        //                   user_global = a;
        //                   print("CEK : $user_global");
        //                   return Text("Kosong");
        //                 } else {
        //                   return Text("Kosong");
        //                 }
        //               },
        //               itemCount: snapshot.data!.docs.length,
        //               separatorBuilder: (BuildContext context, int index) =>
        //                   SizedBox(
        //                     height: 8.0,
        //                   ));
        //         }
        //         return Text("Kosong");
        //       },
        //     ),
        //   ),
        // ),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.shifting,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white24,
          iconSize: 28,
          showSelectedLabels: true,
          showUnselectedLabels: false,
          selectedFontSize: 12,
          currentIndex: current_index_navbar,
          onTap: (index) => setState(() {
            current_index_navbar = index;
          }),
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
              backgroundColor: Colors.blue,
            ),
            // BottomNavigationBarItem(
            //   icon: Icon(Icons.no_drinks),
            //   label: 'Nothing',
            //   backgroundColor: Colors.blue,
            // ),
            BottomNavigationBarItem(
              icon: Icon(Icons.people),
              label: 'Profile',
              backgroundColor: Colors.blue,
            ),
          ],
        ),
        body: IndexedStack(
          index: current_index_navbar,
          children: screen_navbar,
        ));
  }
}
