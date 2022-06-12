import 'Profile.dart';
import 'dbservices.dart';
import 'package:flutter/material.dart';

class detData extends StatefulWidget {
  final Profile_User? dataDet;
  detData({Key? key, this.dataDet}) : super(key: key);

  @override
  State<detData> createState() => _detDataState();
}

class _detDataState extends State<detData> {
  //controller
  final ctrID = TextEditingController();
  final ctrNama = TextEditingController();
  final ctrAlamat = TextEditingController();
  final ctrNoHP = TextEditingController();
  final ctrSaldo = TextEditingController();
  final ctrEmail = TextEditingController();
  final ctrPassword = TextEditingController();
  bool _isDisabled = false;
  @override
  void dispose() {
    // TODO: implement dispose
    ctrID.dispose();
    ctrNama.dispose();
    ctrAlamat.dispose();
    ctrNoHP.dispose();
    ctrSaldo.dispose();
    ctrEmail.dispose();
    ctrPassword.dispose();
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    ctrID.text = widget.dataDet?.item_ID ?? "";
    ctrNama.text = widget.dataDet?.item_Nama ?? "";
    ctrAlamat.text = widget.dataDet?.item_alamat ?? "";
    ctrNoHP.text = widget.dataDet?.item_noHP ?? "";
    ctrSaldo.text = widget.dataDet?.item_Saldo ?? "";
    ctrEmail.text = widget.dataDet?.item_Email ?? "";
    ctrPassword.text = widget.dataDet?.item_Password ?? "";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.dataDet == null) _isDisabled = true;
    return Scaffold(
      appBar: AppBar(
        title: Text("Detail Data Notes"),
      ),
      body: Container(
        margin: EdgeInsets.all(8),
        child: Column(
          children: [
            TextField(
              controller: ctrID,
              enabled: _isDisabled,
              decoration:
                  InputDecoration(border: OutlineInputBorder(), labelText: ''),
            ),
            SizedBox(
              width: 10,
              height: 10,
            ),
            TextField(
              controller: ctrNama,
              //enabled: _isDisabled,
              decoration: InputDecoration(
                  border: OutlineInputBorder(), labelText: 'Masukkan Isi Nama'),
            ),
            SizedBox(
              width: 10,
              height: 10,
            ),
            TextField(
              controller: ctrAlamat,
              //enabled: _isDisabled,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Masukkan Isi Alamat'),
            ),
            SizedBox(
              width: 10,
              height: 10,
            ),
            TextField(
              controller: ctrNoHP,
              //enabled: _isDisabled,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Masukkan Isi No HP'),
            ),
            SizedBox(
              width: 10,
              height: 10,
            ),
            TextField(
              controller: ctrSaldo,
              //enabled: _isDisabled,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Masukkan Isi Saldo'),
            ),
            SizedBox(
              width: 10,
              height: 10,
            ),
            TextField(
              controller: ctrEmail,
              enabled: _isDisabled,
              decoration:
                  InputDecoration(border: OutlineInputBorder(), labelText: ''),
            ),
            SizedBox(
              width: 10,
              height: 10,
            ),
            TextField(
              controller: ctrPassword,
              enabled: _isDisabled,
              decoration:
                  InputDecoration(border: OutlineInputBorder(), labelText: ''),
            ),
            SizedBox(
              width: 10,
              height: 10,
            ),
            ElevatedButton(
                onPressed: () {
                  setState(() {
                    final dt = Profile_User(
                      item_ID: ctrID.text.toString(),
                      item_Nama: ctrNama.text.toString(),
                      item_alamat: ctrAlamat.text.toString(),
                      item_noHP: ctrNoHP.text.toString(),
                      item_Saldo: ctrSaldo.text.toString(),
                      item_Email: ctrEmail.text.toString(),
                      item_Password: ctrPassword.text.toString(),
                    );
                    Database.ubahData(user01: dt);
                  });

                  Navigator.pop(context);
                },
                child: Text("Simpan Data"))
          ],
        ),
      ),
    );
  }
}
