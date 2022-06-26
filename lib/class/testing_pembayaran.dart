import 'package:flutter/material.dart';

class keperluan_cart {
  final int cuang;
  final String cname;
  final String cdesciption;
  final String cemail;
  final String ccontact;
  keperluan_cart({
    required this.cuang,
    required this.cname,
    required this.cdesciption,
    required this.cemail,
    required this.ccontact,
  });
  Map<String, dynamic> toJson() {
    return {
      "contact": ccontact,
      "description": cdesciption,
      "email": cemail,
      "nama": cname,
      "uang": cuang,
    };
  }

  factory keperluan_cart.fromJson(Map<String, dynamic> json) {
    return keperluan_cart(
      cuang: json['uang'],
      cname: json['nama'],
      cdesciption: json['description'],
      cemail: json['email'],
      ccontact: json['contact'],
    );
  }
}
