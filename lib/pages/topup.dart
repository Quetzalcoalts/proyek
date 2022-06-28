// import 'package:flutter/material.dart';
// import 'package:proyekambw/class/Profile.dart';
// import 'package:proyekambw/main.dart';
// import 'package:proyekambw/navbar.dart';
// import 'package:proyekambw/pages/history.dart';
// import 'package:proyekambw/pages/shopping_Payment.dart';
// import 'package:proyekambw/services/dbservices.dart';

// import '../navbar.dart';
// import 'detMakanan.dart';

// class PaymentTopUp extends StatefulWidget {
//   final Profile_User? user_topup;
//   const PaymentTopUp({Key? key, this.user_topup}) : super(key: key);

//   @override
//   State<PaymentTopUp> createState() => _PaymentTopUpState();
// }

// class _PaymentTopUpState extends State<PaymentTopUp> {
//   int now_hour = DateTime.now().hour;
//   Future<void> _refresh() async {
//     setState(() {
//       Database.getData();
//     });
//     return Future.delayed(Duration(seconds: 3));
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: RefreshIndicator(
//         onRefresh: _refresh,
//         child: SingleChildScrollView(
//             child: Column(children: <Widget>[
//           Stack(
//             children: <Widget>[
//               Column(
//                 children: <Widget>[
//                   Container(
//                     width: double.infinity,
//                     height: 130 + MediaQuery.of(context).viewPadding.top,
//                     decoration: BoxDecoration(
//                       gradient: LinearGradient(
//                         colors: <Color>[
//                           Color(0xFF138880),
//                           Color(0xFF1C9E82),
//                         ],
//                       ),
//                     ),
//                   ),
//                   Container(
//                     width: double.infinity,
//                     height: 100,
//                     color: Colors.white,
//                   ),
//                 ],
//               ),
//               Padding(
//                 padding: const EdgeInsets.all(10.0),
//                 child: Column(
//                   children: [
//                     Padding(
//                       padding: EdgeInsets.all(
//                           MediaQuery.of(context).viewPadding.top),
//                       child: Center(
//                         child: Text(
//                           now_hour > 5 && now_hour < 10
//                               ? "Good Morning, ${widget.user_topup!.item_Email.toString()}"
//                               : now_hour > 10 && now_hour < 18
//                                   ? "Good Evening, ${widget.user_topup!.item_Email.toString()}"
//                                   : now_hour > 18 || now_hour < 5
//                                       ? "Good Night, ${widget.user_topup!.item_Email.toString()}"
//                                       : "",
//                           style: TextStyle(fontSize: 20),
//                         ),
//                       ),
//                     ),
//                     Card(
//                       elevation: 10,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(10.0),
//                       ),
//                       child: Padding(
//                         padding: const EdgeInsets.all(20.0),
//                         child: Column(
//                           children: <Widget>[
//                             Row(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Expanded(
//                                   flex: 5,
//                                   child: Text(
//                                     "MYFOOD Balance",
//                                     style: TextStyle(fontSize: 20),
//                                   ),
//                                 ),
//                                 Expanded(
//                                     flex: 2,
//                                     child: Row(
//                                       children: [
//                                         Text("RP",
//                                             style:
//                                                 TextStyle(color: Colors.grey)),
//                                         Text(
//                                           "${widget.user_topup!.item_Saldo} ",
//                                           style: TextStyle(
//                                               color: Colors.black,
//                                               fontSize: 20),
//                                         ),
//                                         ClipRRect(
//                                           borderRadius:
//                                               BorderRadius.circular(15),
//                                           child: Container(
//                                             padding: EdgeInsets.symmetric(
//                                                 horizontal: 5, vertical: 5),
//                                             color: Colors.grey[300],
//                                             child: Icon(
//                                               Icons.arrow_forward_ios,
//                                               size: 15,
//                                             ),
//                                           ),
//                                         )
//                                       ],
//                                     )),
//                               ],
//                             ),
//                             Divider(
//                               thickness: 1,
//                             ),
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceAround,
//                               children: <Widget>[
//                                 ElevatedButton(
//                                     onPressed: () {
//                                       final ctr_DaftarSaldo =
//                                           TextEditingController();
//                                       showDialog(
//                                           context: context,
//                                           builder: (context) => AlertDialog(
//                                                 title: Text("Top Up"),
//                                                 content: Container(
//                                                   child: TextFormField(
//                                                     controller: ctr_DaftarSaldo,
//                                                     textInputAction:
//                                                         TextInputAction.next,
//                                                     decoration: InputDecoration(
//                                                       labelText:
//                                                           "input saldo awal",
//                                                       hintText: "here",
//                                                       fillColor: Colors.white,
//                                                       filled: true,
//                                                       contentPadding:
//                                                           EdgeInsets.fromLTRB(
//                                                               20, 10, 20, 10),
//                                                       focusedBorder:
//                                                           OutlineInputBorder(
//                                                               borderRadius:
//                                                                   BorderRadius
//                                                                       .circular(
//                                                                           100.0),
//                                                               borderSide: BorderSide(
//                                                                   color: Colors
//                                                                       .grey)),
//                                                       enabledBorder:
//                                                           OutlineInputBorder(
//                                                               borderRadius:
//                                                                   BorderRadius
//                                                                       .circular(
//                                                                           100.0),
//                                                               borderSide: BorderSide(
//                                                                   color: Colors
//                                                                       .grey
//                                                                       .shade400)),
//                                                       errorBorder:
//                                                           OutlineInputBorder(
//                                                               borderRadius:
//                                                                   BorderRadius
//                                                                       .circular(
//                                                                           100.0),
//                                                               borderSide:
//                                                                   BorderSide(
//                                                                       color: Colors
//                                                                           .red,
//                                                                       width:
//                                                                           2.0)),
//                                                       focusedErrorBorder:
//                                                           OutlineInputBorder(
//                                                               borderRadius:
//                                                                   BorderRadius
//                                                                       .circular(
//                                                                           100.0),
//                                                               borderSide:
//                                                                   BorderSide(
//                                                                       color: Colors
//                                                                           .red,
//                                                                       width:
//                                                                           2.0)),
//                                                     ),
//                                                     keyboardType: TextInputType
//                                                         .emailAddress,
//                                                     validator: (val) {
//                                                       if (!(val!.isEmpty) &&
//                                                           !RegExp(r'^[Z0-9]+$')
//                                                               .hasMatch(val)) {
//                                                         return "Enter a valid Saldo";
//                                                       }
//                                                       return null;
//                                                     },
//                                                   ),
//                                                 ),
//                                                 actions: [
//                                                   TextButton(
//                                                       onPressed: () {
//                                                         print((int.parse(
//                                                             ctr_DaftarSaldo
//                                                                 .text) as int));
//                                                         Navigator.push(
//                                                           context,
//                                                           MaterialPageRoute(
//                                                             builder:
//                                                                 (context) =>
//                                                                     Pembayaran(
//                                                               topup: (int.parse(
//                                                                       ctr_DaftarSaldo
//                                                                           .text)
//                                                                   as int),
//                                                               user02: widget
//                                                                   .user_topup,
//                                                             ),
//                                                           ),
//                                                         );
//                                                       },
//                                                       child: Text("Ok"))
//                                                 ],
//                                               ));
//                                     },
//                                     child: Icon(Icons.balance)),
//                                 Icon(Icons.pending),
//                                 Icon(Icons.timer)
//                               ],
//                             )
//                           ],
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//           Container(
//             width: double.infinity,
//             height: 8,
//             color: Colors.grey[300],
//           ),
//           Container(
//             padding: EdgeInsets.all(20),
//             child: Center(
//               child: Text(
//                 "History List",
//                 style: TextStyle(fontSize: 20),
//               ),
//             ),
//           ),
//           GridView.count(
//             padding: EdgeInsets.all(5),
//             childAspectRatio: .75,
//             physics: NeverScrollableScrollPhysics(),
//             shrinkWrap: true,
//             crossAxisCount: 2,
//             children: List.generate(cart_nama_historyfirebase.length, (index) {
//               return GestureDetector(
//                   onTap: () {
//                     Navigator.push(context,
//                         MaterialPageRoute(builder: (context) {
//                       return detMakanan(id: nama, item_id: index);
//                     }));
//                   },
//                   child: Padding(
//                     padding: const EdgeInsets.all(10.0),
//                     child: Material(
//                       borderRadius: BorderRadiusDirectional.circular(15),
//                       elevation: 5,
//                       child: Container(
//                         width: MediaQuery.of(context).size.width * 0.4,
//                         decoration: BoxDecoration(
//                             borderRadius: BorderRadiusDirectional.circular(15)),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.stretch,
//                           children: <Widget>[
//                             Expanded(
//                               flex: 5,
//                               child: ClipRRect(
//                                 borderRadius: BorderRadius.only(
//                                   topLeft: Radius.circular(10),
//                                   topRight: Radius.circular(10),
//                                 ),
//                                 child: Image.network(
//                                   cart_gambar_historyfirebase[index],
//                                   //"https://image.freepik.com/free-vector/square-food-banner-with-photo_23-2148118766.jpg",
//                                   height: 100,
//                                   width: 100,
//                                 ),
//                               ),
//                             ),
//                             Expanded(
//                               flex: 1,
//                               child: Padding(
//                                 padding: const EdgeInsets.all(10.0),
//                                 child: Container(
//                                   child: Text(cart_nama[index],
//                                       style: TextStyle(fontSize: 15)),
//                                 ),
//                               ),
//                             ),
//                             Expanded(
//                               flex: 1,
//                               child: Padding(
//                                 padding:
//                                     const EdgeInsets.symmetric(horizontal: 6.0),
//                                 child: Row(
//                                   children: <Widget>[
//                                     Icon(
//                                       Icons.calendar_today,
//                                       size: 15,
//                                     ),
//                                     SizedBox(width: 5),
//                                     Text("1 min read",
//                                         style: TextStyle(fontSize: 15)),
//                                   ],
//                                 ),
//                               ),
//                             )
//                           ],
//                         ),
//                       ),
//                     ),
//                   ));
//             }),
//           )
//         ])),
//       ),
//     );
//   }
// }
