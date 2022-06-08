import 'package:flutter/material.dart';

import 'Profile.dart';

class ProfilePage extends StatefulWidget {
  final Profile_User? dataUser;
  const ProfilePage({Key? key, this.dataUser}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(children: [
        Text("Nama + ${widget.dataUser?.item_Nama ?? ""}"),
        Text("Alamat + ${widget.dataUser?.item_alamat ?? ""}"),
        Text("Nomor HP + ${widget.dataUser?.item_noHP ?? ""}"),
        Text("Saldo + ${widget.dataUser?.item_Saldo ?? ""}"),
      ]),
    );
  }
}
