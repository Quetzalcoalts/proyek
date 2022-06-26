import 'package:proyekambw/class/Profile.dart';
import 'package:proyekambw/services/dbservices.dart';
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
  bool _isObscure = true;
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
        title: const Text("Detail Data Notes"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          margin: const EdgeInsets.all(20),
          child: Column(
            children: [
              // TextField(
              //   controller: ctrID,
              //   enabled: _isDisabled,
              //   decoration:
              //       InputDecoration(border: OutlineInputBorder(), labelText: ''),
              // ),
              // SizedBox(
              //   width: 10,
              //   height: 10,
              // ),
              TextField(
                controller: ctrNama,
                autofocus: true,
                textCapitalization: TextCapitalization.sentences,
                decoration: const InputDecoration(
                    prefixIcon: const Icon(Icons.person),
                    border: const OutlineInputBorder(),
                    labelText: 'Masukkan Isi Nama'),
              ),
              const SizedBox(
                width: 10,
                height: 10,
              ),
              TextField(
                controller: ctrAlamat,
                autofocus: false,
                textCapitalization: TextCapitalization.sentences,
                decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.home),
                    border: const OutlineInputBorder(),
                    labelText: 'Masukkan Isi Alamat'),
              ),
              const SizedBox(
                width: 10,
                height: 10,
              ),
              TextField(
                controller: ctrNoHP,
                autofocus: false,
                textCapitalization: TextCapitalization.sentences,
                decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.mobile_friendly),
                    border: OutlineInputBorder(),
                    labelText: 'Masukkan Isi No HP'),
              ),
              const SizedBox(
                width: 10,
                height: 10,
              ),
              TextField(
                controller: ctrSaldo,
                autofocus: false,
                textCapitalization: TextCapitalization.sentences,
                decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.money),
                    border: OutlineInputBorder(),
                    labelText: 'Masukkan Isi Saldo'),
              ),
              const SizedBox(
                width: 10,
                height: 10,
              ),
              TextField(
                controller: ctrEmail,
                autofocus: false,
                enabled: _isDisabled,
                textCapitalization: TextCapitalization.sentences,
                decoration: const InputDecoration(
                    prefixIcon: const Icon(Icons.email),
                    border: const OutlineInputBorder(),
                    labelText: 'Your Email Registered'),
              ),
              const SizedBox(
                width: 10,
                height: 10,
              ),
              TextField(
                controller: ctrEmail,
                autofocus: false,
                textCapitalization: TextCapitalization.sentences,
                obscureText: _isObscure,
                enabled: _isDisabled,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.password),
                  labelText: 'Password',
                  border: const OutlineInputBorder(),
                  suffixIcon: IconButton(
                    icon: Icon(
                        _isObscure ? Icons.visibility : Icons.visibility_off),
                    onPressed: () {
                      setState(() {
                        _isObscure = !_isObscure;
                      });
                    },
                  ),
                ),
              ),
              const SizedBox(
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
                  child: const Text("Simpan Data"))
            ],
          ),
        ),
      ),
    );
  }
}
