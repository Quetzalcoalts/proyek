import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'main.dart';

class Cart_Add {
  List cart_nama = List.empty(growable: true);
  List cart_gambar = List.empty(growable: true);

  Cart_Add({required this.cart_nama, required this.cart_gambar});
}

class Cart extends StatefulWidget {
  final Cart_Add cart_troli;
  final int item_id;
  const Cart({Key? key, required this.cart_troli, required this.item_id})
      : super(key: key);

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  void tambahdata(String a, String b) {
    setState(() {
      widget.cart_troli?.cart_gambar.add(a);
      widget.cart_troli?.cart_nama.add(b);
      widget.cart_troli?.cart_gambar.sort();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.8,
        backgroundColor: Color.fromARGB(255, 4, 162, 241),
      ),
      body: Container(
        child: Column(
          children: [
            //Text("${widget.cart_troli?.cart_gambar[0]}"),
            ElevatedButton(
              onPressed: () {
                tambahdata("a", "b");
              },
              child: const Text("--- Tambah Data ---"),
            ),
            Expanded(
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: widget.cart_troli?.cart_gambar.length,
                  itemBuilder: (context, index) {
                    return Dismissible(
                      key: Key(widget.cart_troli?.cart_gambar[index]),
                      background: Container(
                        padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                        alignment: Alignment.centerLeft,
                        color: Colors.green,
                        child: Icon(Icons.check),
                      ),
                      secondaryBackground: Container(
                        padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
                        alignment: Alignment.centerRight,
                        color: Colors.red,
                        child: Icon(Icons.cancel),
                      ),
                      child: ListTile(
                          title: Text(
                              "${widget.cart_troli?.cart_gambar[index]} + ${widget.cart_troli?.cart_nama[index]}"),
                          onTap: () {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              duration: Duration(milliseconds: 750),
                              content: Text(
                                  "${widget.cart_troli?.cart_gambar[index]} + ${widget.cart_troli?.cart_nama[index]}"),
                            ));
                          }),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
