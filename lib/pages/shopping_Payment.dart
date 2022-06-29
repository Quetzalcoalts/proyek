import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:proyekambw/class/Profile.dart';
import 'package:proyekambw/main.dart';
import 'package:proyekambw/navbar.dart';
import 'package:proyekambw/class/testing_pembayaran.dart';
import 'package:proyekambw/pages/Profile-Page.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:intl/intl.dart';

import '../services/dbservices.dart';
import 'cart.dart';

class Pembayaran extends StatefulWidget {
  final Profile_User? user02;
  final keperluan_cart? cart;
  final List<keperluan_cart>? cart_list;
  final int? totaluang;
  //top up
  final int? topup;
  const Pembayaran({
    Key? key,
    this.cart,
    this.cart_list,
    this.totaluang,
    this.user02,
    this.topup,
  }) : super(key: key);
  @override
  _PembayaranState createState() => _PembayaranState();
}

class _PembayaranState extends State<Pembayaran> {
  final user = FirebaseAuth.instance.currentUser!;
  TextEditingController textEditingController = new TextEditingController();
  late Razorpay razorpay;
  bool isdisbled = false;
  int a = 0;
  @override
  void initState() {
    super.initState();
    a = widget.cart?.cuang ?? widget.totaluang ?? widget.topup ?? 0;
    print('di shopping payment');
    print(a);
    //print("HOUR : $now_hour");
    textEditingController.text = a.toString();
    razorpay = new Razorpay();
    razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    razorpay.clear();
  }

  void openCheckout() {
    // var options = {
    //   "key": "rzp_test_5YplbLeCMxKCEl",
    //   "amount": a * 100,
    //   "name": widget.cart?.cname ?? "",
    //   "description": widget.cart?.cdesciption ?? "",
    //   "prefill": {
    //     "contact": "${widget.cart?.ccontact ?? "081111111111"}",
    //     "email":
    //         "${widget.cart?.cemail ?? widget.user02?.item_Email.toString()}"
    //   },
    //   "external": {
    //     "wallets": ["paytm"]
    //   }
    // };
    print("Hello : ${user_global.item_Email}");
    var options = {
      "key": "rzp_test_5YplbLeCMxKCEl",
      "amount": a * 100,
      "name": widget.cart?.cname ?? user_global.item_Nama,
      "description": widget.cart?.cdesciption ?? user_global.item_alamat,
      "prefill": {
        "contact": "${user_global.item_noHP}",
        "email": "${user_global.item_Email}"
      },
      "external": {
        "wallets": ["paytm"]
      }
    };

    try {
      razorpay.open(options);
    } catch (e) {
      print(e.toString());
    }
  }

  void notif(String a) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('$a '),
      duration: const Duration(seconds: 1),
      action: SnackBarAction(
        label: 'Ke Halaman Home?',
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => NavBar(),
            ),
          );
        },
      ),
    ));
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    print('Success Response: $response');
    int saldoawal = 0;
    if (widget.user02 != null && a != null) {
      saldoawal = int.parse(widget.user02!.item_Saldo);
      int b = int.parse(widget.user02!.item_Saldo);
      widget.user02!.item_Saldo = (a + b).toString();
      Database.ubahData(user01: widget.user02!);
    } else if (widget.cart != null) {
      saldoawal = int.parse(user_global.item_Saldo);
      Database_user.DeleteData(
          name_user01: widget.cart!.cname.toString(),
          email_user01: widget.cart!.cemail.toString());
      int b = int.parse(user_global.item_Saldo);
      b = b - widget.cart!.cuang;

      user_global.item_Saldo = b.toString();
      Database.ubahData(user01: user_global);

      print("Global Saldo ${user_global.item_Saldo}");

      //detele saldo
    } else {
      saldoawal = int.parse(user_global.item_Saldo);
      for (int i = 0; i < widget.cart_list!.length; i++) {
        Database_user.DeleteData(
            email_user01: user.email.toString(),
            name_user01: widget.cart_list![i].cname);
        int b = int.parse(user_global.item_Saldo);
        b = b - widget.cart_list![i].cuang;

        user_global.item_Saldo = b.toString();
        //delete saldo
      }
      cart_gambar.clear();
      Database.ubahData(user01: user_global);
      cart_nama.clear();
    }
    final snackBar = SnackBar(
      content: Text(
          'Pembayaran Berhasil!, Sisa Saldo Anda ${user_global.item_Saldo}'),
      action: SnackBarAction(
        label: 'Undo',
        onPressed: () {
          user_global.item_Saldo = saldoawal.toString();

          Database.ubahData(user01: user_global);
          final snakbar2 = SnackBar(content: Text("Oke, berhasil di Undo"));

          ScaffoldMessenger.of(context).showSnackBar(snakbar2);
          // Some code to undo the change.
        },
      ),
    );

    // Find the ScaffoldMessenger in the widget tree
    // and use it to show a SnackBar.
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
    //Kembalikerumah(true);
    /*Fluttertoast.showToast(
        msg: "SUCCESS: " + response.paymentId!,
        toastLength: Toast.LENGTH_SHORT); */
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    print('Error Response: $response');
    //Kembalikerumah(false);
    /* Fluttertoast.showToast(
        msg: "ERROR: " + response.code.toString() + " - " + response.message!,
        toastLength: Toast.LENGTH_SHORT); */
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    print('External SDK Response: $response');
    /* Fluttertoast.showToast(
        msg: "EXTERNAL_WALLET: " + response.walletName!,
        toastLength: Toast.LENGTH_SHORT); */
  }

  void Kembalikerumah(bool x) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return NavBar(
        x1: x,
      );
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Razor Pay Pembayaran"),
        ),
        body: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              children: [
                TextField(
                  controller: textEditingController,
                  enabled: isdisbled,
                  decoration: InputDecoration(hintText: "Jumlah"),
                ),
                SizedBox(
                  height: 12,
                ),
                ElevatedButton(
                  child: Text(
                    "Bayar",
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    openCheckout();
                    // notif("Payment success");
                    // if (widget.cart == null && widget.cart_list != null) {
                    //   print("A0");
                    //   for (int i = 0; i < widget.cart_list!.length; i++)
                    //     Database.DeleteData(
                    //         Nama_user01: widget.cart_list![i].cname);
                    // } else {
                    //   Database_user.DeleteData(
                    //       name_user01: widget.cart!.cname,
                    //       email_user01: widget.cart!.cname);
                    // }
                    // Kembalikerumah();
                  },
                )
              ],
            )));
  }
}

class SnackBarPage extends StatefulWidget {
  const SnackBarPage({Key? key}) : super(key: key);

  @override
  State<SnackBarPage> createState() => _SnackBarPageState();
}

class _SnackBarPageState extends State<SnackBarPage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          final snackBar = SnackBar(
            content: const Text('Yay! A SnackBar!'),
            action: SnackBarAction(
              label: 'Undo',
              onPressed: () {
                // Some code to undo the change.
              },
            ),
          );

          // Find the ScaffoldMessenger in the widget tree
          // and use it to show a SnackBar.
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        },
        child: const Text('Show SnackBar'),
      ),
    );
  }
}
