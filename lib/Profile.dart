import 'package:flutter/material.dart';

class Profile_User {
  final String item_Nama;
  final String item_alamat;
  final String item_noHP;
  final String item_Saldo;

  Profile_User({
    required this.item_Nama,
    required this.item_alamat,
    required this.item_noHP,
    required this.item_Saldo,
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
        item_Nama: json['Nama'],
        item_alamat: json['Alamat'],
        item_noHP: json['NoHP'],
        item_Saldo: json['Saldo']);
  }
}
