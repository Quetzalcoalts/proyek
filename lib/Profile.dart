import 'package:flutter/material.dart';

class Profile_User {
  final String item_ID;
  final String item_Nama;
  final String item_alamat;
  final String item_noHP;
  final String item_Saldo;
  final String item_Email;
  final String item_Password;

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
      "Nama": item_Nama,
      "Alamat": item_alamat,
      "NoHP": item_noHP,
      "Saldo": item_Saldo,
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
