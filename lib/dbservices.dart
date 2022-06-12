import 'package:cloud_firestore/cloud_firestore.dart';
import 'Profile.dart';

CollectionReference tbl_user =
    FirebaseFirestore.instance.collection("Profile_Nama");

class Database {
  static Stream<QuerySnapshot> getData() {
    return tbl_user.snapshots();
  }

  static Future<void> tambahData({required Profile_User user01}) async {
    DocumentReference docref = tbl_user.doc(user01.item_Email);
    await docref
        .set(user01.toJson())
        .whenComplete(() => print(
            "Berhasil Membuat Akun dengan : Nama ${user01.item_Nama}, Alamat : ${user01.item_alamat}, Nomor HP : ${user01.item_noHP}, Saldo : ${user01.item_Saldo}, Email : ${user01.item_Email}, Password : ${user01.item_Password} "))
        .catchError((e) => print("e"));
  }

  static Future<void> ubahData({required Profile_User user01}) async {
    DocumentReference docref = tbl_user.doc(user01.item_Email.toString());
    await docref
        .update(user01.toJson())
        .whenComplete(() => print("Data Berhasil Di rubah"))
        .catchError((e) => print("e"));
  }

  static Future<void> DeleteData({required String Nama_user01}) async {
    DocumentReference docref = tbl_user.doc(Nama_user01.toString());
    await docref
        .delete()
        .whenComplete(() => print("Data Berhasil diapus"))
        .catchError((e) => print("e"));
  }
}
