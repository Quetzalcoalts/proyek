import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:proyekambw/detMakanan.dart';
import 'main.dart';

List cart_nama = [];
List cart_gambar = [];
List tumbal = [];

class Cart extends StatefulWidget {
  final List ?id;
  final int ?item_id;
  const Cart({ Key? key, this.id, this.item_id}) : super(key: key);

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  @override
  void initState() {
    super.initState();
    initial();
  }

  void initial(){
    int c = 0;
    setState(() {
      if(widget.id == null && widget.item_id == null){
        cart_nama.add("halo ges");
        cart_gambar.add("https://media.wired.com/photos/598e35fb99d76447c4eb1f28/16:9/w_2123,h_1194,c_limit/phonepicutres-TA.jpg");
        c = 1;
      }
      else{
        if(cart_nama.length == 0){
          cart_nama.add(widget.id![widget.item_id!]['display']['displayName']);
          cart_gambar.add(widget.id![widget.item_id!]['display']['images'][0]);
        }
        else if(cart_nama.length == 1){
          tumbal.add(widget.id![widget.item_id!]['display']['displayName']);
          if(cart_nama[0] != tumbal[0]){
            cart_nama.add(widget.id![widget.item_id!]['display']['displayName']);
            cart_gambar.add(widget.id![widget.item_id!]['display']['images'][0]);
          }
          tumbal.clear();
        }
        else{
          int counter = 0;
          tumbal.add(widget.id![widget.item_id!]['display']['displayName']);
          for(int i = 0; i < cart_nama.length; i++){
            if(cart_nama[i] != tumbal[0]){
              counter ++;
            }
            if(counter == cart_nama.length){
              cart_nama.add(widget.id![widget.item_id!]['display']['displayName']);
              cart_gambar.add(widget.id![widget.item_id!]['display']['images'][0]);
            }
          }
        }
      }
      if(c == 1){
        cart_gambar.clear();
        cart_nama.clear();
        c = 0;
      }
      tumbal.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.8,
        backgroundColor: Color.fromARGB(255, 4, 162, 241),
      ),
      body:
      ListView.builder(
        itemCount: cart_nama.length,
        itemBuilder: (context, index){
          return GestureDetector(
            onTap: (){
              Navigator.push(
                context, MaterialPageRoute(builder: (context){
                  return detMakanan(id: widget.id!, item_id: widget.item_id!);
                })
              );
            },
            child: Container(
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(8),
                        color: Colors.white,
                        height: 200,
                        width: 410,
                        child: Image.network(cart_gambar[index],
                        fit: BoxFit.fill,
                        )
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            margin: EdgeInsets.fromLTRB(10, 8, 0, 10),
                            child: Text(cart_nama[index])
                          ),
                          Container(
                            height: 30,
                            width: 100,
                            color: Colors.blue,
                            margin: EdgeInsets.fromLTRB(10, 8, 8, 10),
                            child: FlatButton(
                              onPressed: (){}, 
                              child: Text("Buy Now")
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        }
      )
    );
  }
}