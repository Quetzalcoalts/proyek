import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:proyekambw/class/Profile.dart';
import 'package:proyekambw/main.dart';
import 'package:proyekambw/navbar.dart';
import 'package:proyekambw/class/testing_pembayaran.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:intl/intl.dart';

import '../services/dbservices.dart';

class Pembayaran extends StatefulWidget {
  final Profile_User? user02;
  final keperluan_cart? cart;
  final List<keperluan_cart>? cart_list;
  final int? totaluang;
  //top up
  final int? topup;
  const Pembayaran(
      {Key? key,
      this.cart,
      this.cart_list,
      this.totaluang,
      this.user02,
      this.topup})
      : super(key: key);
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
    a = widget.cart?.cuang ?? widget.totaluang ?? widget.topup ?? 0 * 100;
    //print("HOUR : $now_hour");
    textEditingController.text = widget.cart?.cuang.toString() ??
        widget.totaluang?.toString() ??
        widget.topup.toString();
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
    var options = {
      "key": "rzp_test_5YplbLeCMxKCEl",
      "amount":
          widget.cart?.cuang ?? widget.totaluang ?? widget.topup ?? 0 * 100,
      "name": widget.cart?.cname ?? "",
      "description": widget.cart?.cdesciption ?? "",
      "prefill": {
        "contact": "${widget.cart?.ccontact ?? "081111111111"}",
        "email":
            "${widget.cart?.cemail ?? widget.user02?.item_Email.toString()}"
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
    if (widget.user02 != null && a != null) {
      int b = int.parse(widget.user02!.item_Saldo);
      widget.user02!.item_Saldo = (a + b).toString();
      Database.ubahData(user01: widget.user02!);
    } else {
      print("b");
      Database_user.DeleteData(
          name_user01: widget.cart!.cname.toString(),
          email_user01: widget.cart!.cemail.toString());
    }

    Kembalikerumah(true);
    /*Fluttertoast.showToast(
        msg: "SUCCESS: " + response.paymentId!,
        toastLength: Toast.LENGTH_SHORT); */
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    print('Error Response: $response');
    Kembalikerumah(false);
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
