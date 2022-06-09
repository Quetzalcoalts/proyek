import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'Profile.dart';

CollectionReference tbl_user =
    FirebaseFirestore.instance.collection("Profile_Nama");

class Database {
  static Stream<QuerySnapshot> getData() {
    return tbl_user.snapshots();
  }

  // static Future<void> tambahData({required item_DaftarKTM KTM}) async {
  //   DocumentReference docref = tblKTM.doc(KTM.itemNomor.toString());
  //   await docref
  //       .set(KTM.toJson())
  //       .whenComplete(() => print(
  //           "Data Berhasil di Input NRP : ${KTM.itemNRP}, Nama : ${KTM.itemNama}"))
  //       .catchError((e) => print("e"));
  // }

  // static Future<void> ubahData({required item_DaftarKTM KTM}) async {
  //   DocumentReference docref = tblKTM.doc(KTM.itemNomor.toString());
  //   await docref
  //       .update(KTM.toJson())
  //       .whenComplete(() => print("Data Berhasil Di rubah"))
  //       .catchError((e) => print("e"));
  // }

  // static Future<void> DeleteData({required String Nama_KTM}) async {
  //   DocumentReference docref = tblKTM.doc(Nama_KTM);
  //   await docref
  //       .delete()
  //       .whenComplete(() => print("Data Berhasil diapus"))
  //       .catchError((e) => print("e"));
  // }
}
