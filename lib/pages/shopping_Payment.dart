import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:flutter/material.dart';
import 'package:proyekambw/services/dbservices.dart';
import 'package:proyekambw/navbar.dart';
import 'package:proyekambw/class/testing_pembayaran.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class Pembayaran extends StatefulWidget {
  final keperluan_cart? cart;
  final List<keperluan_cart>? cart_list;
  final int? totaluang;
  const Pembayaran({Key? key, this.cart, this.cart_list, this.totaluang})
      : super(key: key);
  @override
  _PembayaranState createState() => _PembayaranState();
}

class _PembayaranState extends State<Pembayaran> {
  final user = FirebaseAuth.instance.currentUser!;
  TextEditingController textEditingController = new TextEditingController();
  late Razorpay razorpay;
  bool isdisbled = false;

  @override
  void initState() {
    super.initState();
    textEditingController.text =
        widget.cart?.cuang.toString() ?? widget.totaluang.toString();
    razorpay = new Razorpay();
    razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlerPaymentSuccess);
    razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handlerErrorFailure);
    razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, handlerExternalWallet);
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
      "amount": widget.cart?.cuang ?? widget.totaluang! * 100,
      "name": widget.cart?.cname ?? "",
      "description": widget.cart?.cdesciption ?? "",
      "prefill": {
        "contact": "${widget.cart?.ccontact ?? ""}",
        "email": "${widget.cart?.cemail ?? ""}"
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

  void handlerPaymentSuccess() {
    print("Payment success");
  }

  void handlerErrorFailure() {
    print("Payment error");
    notif("Payment error");
  }

  void handlerExternalWallet() {
    print("External Wallet");
    notif("External Wallet");
  }

  void Kembalikerumah() {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return NavBar();
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Razor Pay"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            TextField(
              controller: textEditingController,
              enabled: isdisbled,
              decoration: InputDecoration(hintText: "Amount"),
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
                notif("Payment success");
                if (widget.cart == null && widget.cart_list != null) {
                  print("A0");
                  for (int i = 0; i < widget.cart_list!.length; i++)
                    Database.DeleteData(
                        Nama_user01: widget.cart_list![i].cname);
                } else {
                  Database_user.DeleteData(
                      name_user01: widget.cart!.cname,
                      email_user01: widget.cart!.cname);
                }
                Kembalikerumah();
              },
            )
          ],
        ),
      ),
    );
  }
}
