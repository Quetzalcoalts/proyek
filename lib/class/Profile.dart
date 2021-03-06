import 'package:flutter/material.dart';

class Profile_User {
  String item_ID;
  String item_Nama;
  String item_alamat;
  String item_noHP;
  String item_Saldo;
  String item_Email;
  String item_Password;

  Profile_User({
    required this.item_Nama,
    required this.item_alamat,
    required this.item_noHP,
    required this.item_Saldo,
    required this.item_ID,
    required this.item_Email,
    required this.item_Password,
  });
  Map<String, dynamic> toJson() {
    return {
      "Id": item_ID,
      "Nama": item_Nama,
      "Alamat": item_alamat,
      "NoHP": item_noHP,
      "Saldo": item_Saldo,
      "Email": item_Email,
      "Password": item_Password,
    };
  }

  factory Profile_User.fromJson(Map<String, dynamic> json) {
    return Profile_User(
      item_ID: json['Id'],
      item_Nama: json['Nama'],
      item_alamat: json['Alamat'],
      item_noHP: json['NoHP'],
      item_Saldo: json['Saldo'],
      item_Email: json['Email'],
      item_Password: json['Password'],
    );
  }
}
