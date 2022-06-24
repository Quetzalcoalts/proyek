import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:proyekambw/testing_pembayaran.dart';
import 'Profile.dart';

final String Profile = "Nama_User";

CollectionReference tbl_user =
    FirebaseFirestore.instance.collection("$Profile");
//FirebaseFirestore.instance.collection("Profile_Nama");

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

class Database_user {
  static Stream<QuerySnapshot> getData(String user01) {
    CollectionReference tbl_user_shoppingcart = FirebaseFirestore.instance
        .collection("$Profile")
        .doc('${user01}')
        .collection("ShoppingCart");
    return tbl_user_shoppingcart.snapshots();
  }

  static Future<void> tambahData({required keperluan_cart user01}) async {
    CollectionReference tbl_user_shoppingcart = FirebaseFirestore.instance
        .collection("$Profile")
        .doc('${user01.cemail}')
        .collection("ShoppingCart");
    DocumentReference docref =
        tbl_user_shoppingcart.doc(user01.cname.toString());
    await docref
        .set(user01.toJson())
        .whenComplete(() => print(
            "Berhasil Membuat Cart dengan : Nama ${user01.cname}, email : ${user01.cemail}, description : ${user01.cdesciption}, uang : ${user01.cuang}, contact : ${user01.ccontact}  "))
        .catchError((e) => print("e"));
  }

  // static Future<void> ubahData({required Profile_User user01}) async {
  //   DocumentReference docref = tbl_user.doc(user01.item_Email.toString());
  //   await docref
  //       .update(user01.toJson())
  //       .whenComplete(() => print("Data Berhasil Di rubah"))
  //       .catchError((e) => print("e"));
  // }

  static Future<void> DeleteData(
      {required String name_user01, required String email_user01}) async {
    CollectionReference tbl_user_shoppingcart = FirebaseFirestore.instance
        .collection("$Profile")
        .doc('${email_user01}')
        .collection("ShoppingCart");
    DocumentReference docref =
        tbl_user_shoppingcart.doc(name_user01.toString());
    await docref
        .delete()
        .whenComplete(
            () => print("Data Berhasil dihapus dengan : Nama $name_user01"))
        .catchError((e) => print("e"));
  }

  static Future<void> DeleteAllData({required String email_user01}) async {
    CollectionReference tbl_user_shoppingcart = FirebaseFirestore.instance
        .collection("$Profile")
        .doc('${email_user01}')
        .collection('ShoppingCart');
    DocumentReference docref = tbl_user_shoppingcart.doc();
    await docref
        .delete()
        .whenComplete(() => print("Data Berhasil dihapus"))
        .catchError((e) => print("e"));
  }
}
