import 'dart:async';
import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:proyekambw/pages/Profile-Page.dart';
import 'package:proyekambw/pages/SignUp-Page.dart';
import 'package:proyekambw/pages/cart.dart';
import 'package:proyekambw/pages/cart_firebase.dart';
import 'package:proyekambw/pages/detMakanan.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:proyekambw/pages/filter.dart';
import 'package:proyekambw/navbar.dart';
import 'package:proyekambw/pages/menu.dart';
import 'package:proyekambw/pages/shopping_Payment.dart';
import 'package:proyekambw/services/dbservices.dart';
import 'class/Profile.dart';
import 'firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hexcolor/hexcolor.dart';

final user2 = FirebaseAuth.instance.currentUser!;

List nama = [];

Color _primaryColor = HexColor('#2596be');
Color _accentColor = HexColor('#2596be');
final navigatorKey = GlobalKey<NavigatorState>();
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MaterialApp(
    navigatorKey: navigatorKey,
    title: "Firebase CRUD",
    debugShowCheckedModeBanner: true,
    theme: ThemeData(
      primaryColor: _primaryColor,
      scaffoldBackgroundColor: Colors.grey.shade100,
      colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.grey)
          .copyWith(secondary: _accentColor),
    ),
    home: MainPage(),
    //home: Home(),
  ));
}

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  bool _isVisible = false;
  @override
  _MainPageState() {
    // new Timer(const Duration(milliseconds: 2000), () {
    //   setState(() {
    //     Navigator.push(
    //       context,
    //       MaterialPageRoute(
    //         builder: (context) => MyApp(),
    //       ),
    //     );
    //   });
    // });

    // new Timer(Duration(milliseconds: 10), () {
    //   setState(() {
    //     _isVisible =
    //         true; // Now it is showing fade effect and navigating to Login page
    //   });
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // return Center(
            //   //child: CircularProgressIndicator(),

            // );
            print('Loading...');
            return Center();
          } else if (snapshot.hasError) {
            return Center(
              child: Text("Something was Wrong"),
            );
          } else if (snapshot.hasData) {
            return NavBar();
          } else {
            return LoginPage();
            //return Center(child: CircularProgressIndicator());
            //return MyApp();
            // return Container(
            //   decoration: new BoxDecoration(
            //     gradient: new LinearGradient(
            //       colors: [
            //         Theme.of(context).accentColor,
            //         Theme.of(context).primaryColor
            //       ],
            //       begin: const FractionalOffset(0, 0),
            //       end: const FractionalOffset(1.0, 0.0),
            //       stops: [0.0, 1.0],
            //       tileMode: TileMode.clamp,
            //     ),
            //   ),
            //   child: AnimatedOpacity(
            //     opacity: _isVisible ? 1.0 : 0,
            //     duration: Duration(milliseconds: 1200),
            //     child: Center(
            //       child: Container(
            //         height: 140.0,
            //         width: 140.0,
            //         child: Center(
            //           child: Column(
            //             children: const [
            //               ClipOval(
            //                 child: Icon(
            //                   Icons.shopping_bag,
            //                   size: 128,
            //                 ), //put your logo here
            //               ),
            //               // SizedBox(
            //               //   height: 50,
            //               // ),
            //               // Text(
            //               //   "MY FOOD",
            //               //   style: TextStyle(
            //               //       fontSize: 24,
            //               //       fontStyle: FontStyle.italic,
            //               //       fontWeight: FontWeight.bold),
            //               // )
            //             ],
            //           ),
            //         ),
            //         decoration: BoxDecoration(
            //             shape: BoxShape.circle,
            //             color: Colors.white,
            //             boxShadow: [
            //               BoxShadow(
            //                 color: Colors.black.withOpacity(0.3),
            //                 blurRadius: 2.0,
            //                 offset: Offset(5.0, 3.0),
            //                 spreadRadius: 2.0,
            //               )
            //             ]),
            //       ),
            //     ),
            //   ),
            // );

          }
        },
      ),
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final email_Controller = TextEditingController();
  final password_Controller = TextEditingController();
  void dispose() {
    email_Controller.dispose();
    password_Controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Container(
            padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
            margin: EdgeInsets.fromLTRB(
                20, 10, 20, 10), // This will be the login form
            child: Column(
              children: [
                Text(
                  'Hello',
                  style: TextStyle(fontSize: 60, fontWeight: FontWeight.bold),
                ),
                Text(
                  'Signin into your account',
                  style: TextStyle(color: Colors.grey),
                ),
                SizedBox(height: 30.0),
                Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Container(
                          child: TextFormField(
                            controller: email_Controller,
                            textInputAction: TextInputAction.next,
                            decoration: InputDecoration(
                              labelText: 'Email',
                              hintText: 'Enter your Email here',
                              fillColor: Colors.white,
                              filled: true,
                              contentPadding:
                                  EdgeInsets.fromLTRB(20, 10, 20, 10),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(100.0),
                                  borderSide: BorderSide(color: Colors.grey)),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(100.0),
                                  borderSide:
                                      BorderSide(color: Colors.grey.shade400)),
                              errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(100.0),
                                  borderSide: BorderSide(
                                      color: Colors.red, width: 2.0)),
                              focusedErrorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(100.0),
                                  borderSide: BorderSide(
                                      color: Colors.red, width: 2.0)),
                            ),
                            validator: (val) {
                              if (!(val!.isEmpty) &&
                                  !RegExp(r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$")
                                      .hasMatch(val)) {
                                return "Enter a valid email address";
                              }
                              return null;
                            },
                          ),
                        ),
                        SizedBox(height: 30.0),
                        Container(
                          child: TextFormField(
                            obscureText: true,
                            controller: password_Controller,
                            textInputAction: TextInputAction.next,
                            decoration: InputDecoration(
                              labelText: 'Password',
                              hintText: 'Enter your Email Password here',
                              fillColor: Colors.white,
                              filled: true,
                              contentPadding:
                                  EdgeInsets.fromLTRB(20, 10, 20, 10),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(100.0),
                                  borderSide: BorderSide(color: Colors.grey)),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(100.0),
                                  borderSide:
                                      BorderSide(color: Colors.grey.shade400)),
                              errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(100.0),
                                  borderSide: BorderSide(
                                      color: Colors.red, width: 2.0)),
                              focusedErrorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(100.0),
                                  borderSide: BorderSide(
                                      color: Colors.red, width: 2.0)),
                            ),
                            validator: (val) {
                              if (val!.isEmpty) {
                                return "Please enter your password";
                              }
                              return null;
                            },
                          ),
                        ),
                        SizedBox(height: 15.0),
                        Container(
                          margin: EdgeInsets.fromLTRB(10, 0, 10, 20),
                          alignment: Alignment.topRight,
                          child: GestureDetector(
                            onTap: () {
                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(
                              //       builder: (context) => ForgotPasswordPage()),
                              // );
                            },
                            child: Text(
                              "Forgot your password?",
                              style: TextStyle(
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black26,
                                  offset: Offset(0, 4),
                                  blurRadius: 5.0)
                            ],
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              stops: [0.0, 1.0],
                              colors: [
                                Theme.of(context).primaryColor,
                                Theme.of(context).colorScheme.secondary,
                              ],
                            ),
                            color: Colors.deepPurple.shade300,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: ElevatedButton(
                            child: Padding(
                              padding: EdgeInsets.fromLTRB(40, 10, 40, 10),
                              child: Text(
                                'Sign In'.toUpperCase(),
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ),
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                signIn();
                                print("aman2");
                              }
                            },
                            style: ButtonStyle(
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                ),
                              ),
                              minimumSize:
                                  MaterialStateProperty.all(Size(50, 50)),
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.transparent),
                              shadowColor:
                                  MaterialStateProperty.all(Colors.transparent),
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(10, 20, 10, 20),
                          //child: Text('Don\'t have an account? Create'),
                          child: Text.rich(TextSpan(children: [
                            TextSpan(text: "Don\'t have an account? "),
                            TextSpan(
                              text: 'Create',
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => SignUp_Page()));
                                },
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color:
                                      Theme.of(context).colorScheme.secondary),
                            ),
                          ])),
                        ),
                      ],
                    )),
              ],
            )),
      ),
    ));
  }

  Future signIn() async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Center(
        child: CircularProgressIndicator(),
      ),
    );
    print("aman");
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email_Controller.text, password: password_Controller.text);
    } on FirebaseAuthException catch (e) {
      print(e);
    }
    //navigatorKey.currentState!.popUntil((route) => route.isFirst);
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return NavBar();
    }));
  }
}

class MyApp extends StatefulWidget {
  final bool? status;
  const MyApp({Key? key, this.status}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int selected = 0;
  @override
  void initState() {
    super.initState();

    getName();
  }

  getName() async {
    var url = Uri.https(
        "yummly2.p.rapidapi.com", "/feeds/list", {"limit": "15", "start": "3"});
    var response = await http.get(url, headers: {
      'X-RapidAPI-Host': 'yummly2.p.rapidapi.com',
      'X-RapidAPI-Key': '15944e2e9amshcd61c9da0ef21d9p1dfa39jsn528344bcd853'
    });
    var items = json.decode(response.body)['feed'];
    setState(() {
      nama = items;
    });
  }

  Convert(var a){
    var b = double.parse(a).round();
    return b.toString();
  }

  @override
  Widget build(BuildContext context) {
    print(cart_nama);
    return Scaffold(
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.fromLTRB(10, 35, 0, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(Icons.restaurant_menu),
                    Container(
                      margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                      // ignore: prefer_const_constructors
                      child: GestureDetector(
                        child: Text(
                          "Food Recipe",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context){
                            return Menu();
                          }));
                        },
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                      child: IconButton(
                          onPressed: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return Filter(isi: nama);
                            }));
                          },
                          icon: Icon(Icons.filter_alt_outlined)),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                      child: Row(
                        children: [
                          IconButton(
                              onPressed: () {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return Cart_Firebase();
                                }));
                              },
                              icon: Icon(Icons.shopping_cart_outlined)),
                          Text("${cart_nama.length.toString()}")
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(5),
              child: GridView.count(
                crossAxisCount: 2,
                mainAxisSpacing: 4.0,
                crossAxisSpacing: 11.0,
                childAspectRatio: 0.85,
                children: List.generate(
                  nama.length,
                  (index) {
                    return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return detMakanan(
                                  id: nama,
                                  item_id: index,
                                );
                              },
                            ),
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10)
                          ),
                          child: Column(
                            children: [
                              Container(
                                padding: EdgeInsets.all(10),
                                child: Container(
                                  child: Row(
                                    children: [
                                      Image.network(
                                        "${nama[index]['display']['images'] != null ? nama[index]['display']['images'][0] : "data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAkGBwgHBgkIBwgKCgkLDRYPDQwMDRsUFRAWIB0iIiAdHx8kKDQsJCYxJx8fLT0tMTU3Ojo6Iys/RD84QzQ5OjcBCgoKDQwNGg8PGjclHyU3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3N//AABEIAH4AvgMBIgACEQEDEQH/xAAcAAABBQEBAQAAAAAAAAAAAAAFAgMEBgcBAAj/xAA8EAABAwMCBAMFBgUEAgMAAAABAgMEAAUREiEGEzFBIlFhFDJxgZEHFUKhscEjUmLR8CQzguEW8XKSov/EABoBAAMBAQEBAAAAAAAAAAAAAAIDBAEFAAb/xAApEQACAgEEAAYCAgMAAAAAAAABAgARAwQSITEFEyIyQVEUYUKBcZGh/9oADAMBAAIRAxEAPwCtIX2Ip0FJ6iozbg6Gn0KSa5jCd5WjpANc5QNe8PnXioCg5h8RKmQal2rh6Rdy7yMJCE5yoda5bWjJmtthORnJq6wl+zOK5eG0bJ2pGXUeWakep1Hl8DuZz7K4h0t6VFaSQU432rxSUnBBB9a05puFIdJS23zAcawBk1FvlrjSkKYU2htzGUuYxSxrgTVRa61SQCJnR1dhRzhuyLvK1BSuW2NgT3NTeGjboq3Gbi0OaolJKhtRxFudtwLlscQqMo5Iz0pzZOPTDy6j+K9/ErHEPD0ixrSXVBbSzsRQhCx51pK+TeIimJulxCfxeVVyZwW60pa47pUzjKfSiRwwuEmYp6cwoyvBe1LDp7VNtXD7851SC4EaTjHepj/CU1p1KWzrSTua8SI46jEDVwQHlClh7NHlcIKXpSzJwvuFUCuUJ62ySw8On4sbGhBU9TUzI5oGdDgPUV3CDvio6DnenRW1GVHQlHlXi2k01v2ruTWi5lCdLKTTamBS9dcK63cYPlgxlTIposA9KIwojs19LbSTgnClfy1bY3CMQMgvOZPxrG1AQcyfIUTuZ85AlM/7sR5P/A00QEnBBSfI1p/38hPhmwltHvsUfkr+9OJftEtO+kZ7LbH6imbyO5gyn6mWg43zXiT1IyK09djtL4zyIyh/SrGaQ3wHCm7stlAPfm1qktxN/IA7EA8OQguKmQlGAR86mykiMQlaTpWcglXerRC4JciMBhq4ctsdgjV+tOq4HYdWhcmfIc0dAAkCom0OoZjxxOXlO5iZn7Mwxp/cDNWV0PSm0aQkpPVxX4RS7rw/wrBcCpdxkrdKh/DZUFqHqQBsKL2G42Nby7Wzzx4BhySgJDnmB6j96LH4c3tYiD5b1dcSpXJFvWsx5bY8Iwl0DrTEGYYIVHLpdYXsk56VbuIOFbbIU0oyjF1KCUHIwsnsM96DSOCURvGq7JQnOBzk438utUnSZQOp63HUE+0vW9zQUpKFDrnYirRYLjFeg8vmJ5g95KjQGPY/vTnRYd1gzSwRrDLuSjPTNRZFgu8EAGKs4/G0MmleXlxmys+hxPp/EMWzMacfMurUSMX8spAURk4qN7UY8goWk6artvuz8FZ9oUpxSAMpxhSfiKNRrgzeAeiFJ31VoN8VU5ep8Py4bYepfsRTvLlSRyF8tXkaYuEm3RFli4YdcxnGK9MkkRkPQo+sgkFQoJOtsi72tyaGyZaDuPSl7KPHcjxgFqPEmyX7G5FVzIhRkeEgVTnSjWrl+7nbNMuTX1J5L5I0bEGm+YMdaNFYD1Tr6fGUHJuOlWD1rpcr0dhx55tKkqQhZxrIwKtZ4M1MZjyNaz61pYCMfNjQ0TKrvp1Y2rgCl7ISVH0q6J4RkOMtsuAIUO471GsNuet10eafbStI/EaW2WgTUV+UhBruQbD7XGK1crSlXdVWOPcmQCmUFHHTFdnOscwNnASfKg69BWrSNs1z8mVidyznZcm83LD94MrwWJgWDuEPDH517/SuKHtsRrSrqUgJ+iqHS4MdtaXYgywd1lG6k+uOhpTUNYAcYWh5HUFtRSfy/tXeCtGen5hCFDgx9bcqO+pgnU0+hX8RPocHcetKdgR1Eqt1zd1/hRIRg/8A2GDUZiUiMdLi3mCf5kgg/T9xTj7nPQpUcx5G2dtj8wP7URquRN5+DG3DxHESQ27II/mZdCwP+K6CXu/8SPwHLaqU0eanCi+yWVkeQPSpyrm5FVp0yY53wB4knHwxSHeInlJWUyIk5gAlDa205O3kcY79zQ7h8EiMAN8gSmt+1R0BLgWhSBnBcDmfQKH6UuTPkT2tXIShpvOvJBOw2z+1dut2iOzVvR2WI6XEAFhsEBtQx4/InqMb9KHsl1iagtx1LWpepKT0UQf/AFQhSOTKw27iOxeI3mG2nFLkSGmyeQhSyUx8fyZJ/Sil+vEu7WWIyqamW2FoeKEjD6RvucdRjI86MtKsVztyEXuGUrGUlO4K8jrqHT5VWV2+2Wy9EW2Q840kJWlzdSdWSdJxufw/Q+dErn4MxlVj7ZHsc9+x3QuRS8yHFABDQVk9djjPp1Hc0ftt5LNzU89MuCVuKV7Qp93PKOSCEY2wfht+dCGZCZIbQIDzExsKjrwlXjG+nOknBx36+dQrzfWlwkMqwpSP4LpdQdeQc7k/DqDTmyN7R/uTrhT3E/1LQ9aLg/P9r/1DrLYEhMtKtaXUgbJcSDnPTfpuaKWq7Wt5fJu0Q2qaUhSw2cJVnOMD1GPrVD4Z4hkRgpmQ665CxywUgBwIwMoGMDoAfrjvUy/cRF+4xFy9ClM6myAPFyyBuVHfrn6GhO26IuNHmVwamjWUxHwt2xT2pEdKiFsuAgg9+tTUX+BFkOxwhtLoOl1IIIzWcxZT8ZD8mI+hbKgVpw3kjwjbbbfzo5bUNTWUtJdCnnDutadknGc7dd6E41Y+niSNp6BYyTf7Fb7rITIjullw++MUPZ4QYRJCnJhUyCDsN6P8NvtuMmDdgyqa2NQ0KyFNn3d+5Heja7ZCdQeWChQ7Z60LabIOosZ2AoSIxEs5j+xuglCk4C9OKRDYQyrlxnCEI21E7mpBsSVDLTyh5+lNGzTGiSy+FY7EdanbA/1E2PuTFGYkai5rQe/cUNuyUNtZZBLihuafAu8U6eUHB5VGdlu5PtUVY9ewoTi4oiZUEx47klR5ickVJEFpGwxnvRm3zbcWVJdUG3T5ipbEG2JHMU+l0q/qxikrgAHE9UFvNR2nlofjuxlnfmNe4r9vlSG2ycuRHmHxnqk4V+Vdst1cutoE22K1LYUUPxVnPwIJ8x+9Icft7que7FWyc+J+PkYP9Se30rp7COpUHBE6qahBKZKNI76xj86rXFj0ttkqs9tLxOcuNEHR/wAQcn6VYpltfmR0uW6aJYG/JUQnmemr/PlVBl2Sfa3tcCdLtzxUR7PN91R8gv3T8s/GhZmPBjEVbuAvv6axN50gONSCNKkFSkgj1SoGiLc2HNCfvOEkF04S9EITtjqobYGTTEviKa0h2PfrZHlBAxzF4Iz2zjPX0qfHvEO7MhiM0I7q06dKB4UgDHX5UBFDkR6Ux7i4FojPnmRXFvRlK8KuVsCOoJ+VGUKMVltLkdqQoeJKQnTpAHUH6VWmVuWbENLwSlwLwFnAcB+HQ5z1pUXjBiHbRBlJdecaIQVOIyVgnt57eZ8qSy5H5U/1KQ2NRRkCRcJbToQkanCsFLbZ8RyFA7b7Dr6fCvRbpKiXINPJcacGNROxwegOfX50GcuJk3dU9KdCdWzau46b7eW5o1a7it+XLgKQ07GdOtUheVFCQQQBnp0G2N/pVZxCrPxJvNIal+TDsGeIoW1HlstSHFAOPBJUceY397BI7fpQx24MuuRbXAQwwWt1LQk6niCd1nO4wemOox0AyMkyWbc/zIKWsyDjdP8AtDOMj169/KuxZa3ZinYcKOl+MhSVLSpX8QBJIUpJA36D/vetCELdwTlDNW2FEw247rzLTaitaPFlXxx55x3+dQbpYZHs7Ty3ErUk5QMnKgT3HTIG23b1pxUwNulwutokqGohLhISM9Bnr/0aOX25MiI0uOrIa6nGD5ZzSG8xepQoxtwRxK1EblQ3f4kaSuKpOlWEE5IO4SrGBS0XpUhssFROjwhw4GSPMefzq3QeJrazbxAklDkhxRQt1aUhoJUnck56Z238s0FnWCyzlSVWxXsrgTqb5JKkau40evbG2/1ftWv3Eb3s/UjcPyoR4piPSbjIjrLyVBSjqbdJBzqP4f0rZEE5yD9K+eXrV/ERDjySubzdIjLb3USRoAUNirB6f9VtfBSLhDsTES9OKkS2/DkdUDsknvjpmq065kDrbGhUsrTykpIKjikOc5Kg6w6SU/hPl5U6hlZWG9PiIyKU6wpkZXgelaVBitvxOybmGI7S3hhat8Dt8alMvx5jWvSNC9jt0NDXW2paMObkbZ8qiw0yIcxLJ/2V9D2pbLUCiDDDlshyAQtpOpBwRiobvDsILyhS0pPQA0DmcVON3JxuOUqSgaD5001xIklQkLUlXrUzNjPxPb6mc8K32RYL0mWwouMrHLeZPRxH9+4rVy1Eu8Nu7WZ4KadHvp33/lUPMVizYDbS16ATjSDjzopwrxHN4ck64gCmHVAPMLJ0LHn6H1okeu4QaaAuPpWRvDe807oWarF24i4k4clKYkhqfb3RsmQnUCP5dXX65q/W6dbuI4ftFsIUQP4sVzAW2fh5flQm9WdMuG7GIy0oEFtY90+YPY0x03CxKMThTz1M2ud64cuLyXPu560vKJ5i2MKbV8sft2rrcOLHZ50RCUrycPJJAVnGlWnt/m1Cb/YZtokK5ja3Y4913GRj1x0NFbY+05b2w6FIQAG3FBOyceR8ztUz2ol+EKxki1x7tMdKmFKbjrUoOL6lbZIBBz54FTrnYIElv2gJ/it5JdCRkEDAz5742/wT27vFAbgw0EgrALp/PIrnEZZgfwmCpxYUFFLagnIJwOvUk/pUvmZXcASnbjReZSJtoVJfcWw42ywlxISHEKUErUchsHHn0z1AqOhyYw68UTG3XnADlrfsM7Y+A6dhROS+u6SE+xMhwKUoqbOT1wBkHYEUt6ylCFEvHQlsKUE9EEDfIOBqHpVwyD2yRsRBJEiqXDThDocXLUErUoo3SAAcDsnG/l9a5wup1CZ1xYRrKUK6nVrJOcnz7V1HDt1u7Glh1gyQcKXkjUg9iQPMD86nOcOLsNmfRdpul9WhTaI6vXpk9e3yrXyJW24CI5yXUhQXWYDTsx5pDz8nKEISvXpz1GR+Lsc4NPi1v3yOpcVxqOsjYKOkEjfxYG/ffGRigbaRH5jpbSqK4dRBOoj4Z2ziidn4iaadAWAw2hGhAHfPUk/51oWB7SNBFbXkGdZ5VmaQ5OSFBZyFoyUrT/MleMEdc96gLfLuynCGwcg77HNXGDxNIWwqAxLLjKQG2A91bznCRkHbA+FCJL8KS8590xfuyWQQ4qO4S0T0OE4wNtXTGNj1FNUA8mIe1oLzA4lexrYkMukvjxBwHdKux+Vb/wAC8U2+78PsTpaGGpuVJdGr3lA41AdgetfPzjCHEJW6n/UJOFgJwlRyTv5mrXw9cBGioRyihvTjSDgCj3BBFld7WZqz11LlzW6mSlRA8AR0HqaIT7vcBbuYiMV9i6hOoJ9cVm0W6MOE8hKkOg4VlRIPl1o3bOI3m3FtIc3AGtOe3wpgZTzDKgS2xHktQWy6sBSj3PU/4aktP7+IfDIqocZzjdbUU2+LIdnRG0Ka5G4AURnI65x5Uj7P7rdJzLke5RHxyOj7qCknfoc96wEngxL4yQWg3i6DLt9xU5qHJfOptwDY+h9a9CkCXHQX4K3NIxrHer7ebSze7U9BkbahltwdUK7EVj33o5aZ0mGpwlTKtBOT1Fc/Lh8o2g4MPRaXHnch2qIcs80s5ZbDyUklWhzJHyqA4ClYQ4kpIHQjFTnru4yR7Q0pvX0VjAFWJDdumQWQl9mW6U4Wlfffok9QR8aAO494nQyeGabML0z3+pV48uTAfZkw31sPN5KXEHB/7+FaBZPtAg3DRG4kb9mfxhMxoeE//JI6fp8Kqd14fWI6pdtGpDQPNjrV42sHt/MPzqupc1KGvZWfKqcb/U4uXFkwNtcTZ7nw8mZHLzDoeYdTgOsnKVA+grM7xwPdbfl+1LVIbCgrSk4WMbjvvUay3+62CUty2S1oQVZU0rxIV/xNXuz/AGi2e5gNXyMqBI7vs7tn5dRTqDQ0ykTIkrlKmrU8XOeFlS9WxB9R2o1Mujc9hsS5LrMhoHDoTqBHYEbVq1x4WtnEDHtcVxmYkjwSIywVjbzHxrPb19mc+IpTlufS+kb8p4aF/wBj+VLbDRuVrmBFR6PLjsR1LixUx1HCXVlIy2o43UM75znvUWztPXVchlT63GnVBKmikDI94K2zjc5x3qty13S1tKivx3mE99be3yNLsV1Q1fIa3ZC2mE41qCQhIOO+Ooz3NLOOlJXuOGYFhc0UqRZJZjNtIAU2CHEnckdiKDXtEiW289PLxS5jS0VAAHt1T/brXGb3GnXRTjaknRlXvDxdu5rs+/JS1omaRz143X4kJO3l2qLGrXz3LWZb4kZ6Xa2GG7fKt7UYlGpbpY5oX8U9idhn1FC1cG/e859y3TY0eKAFoSG1AlOPe0529d6SC/dJUchalDPKSkDJKev1qSJxRMdjsoIbbwNQOMbEY8qtVyokb4w5r4g+TwhMi+KPKYlq0EgIJQo46gZ69u++aBRH9EgMNlwOOHl6UHfr0x1yelXty8TGloYemKQy5hLilnCEknqds5H6UKukd1iYLhDeYeQ9lZeabyELSQArP4SSEn4n1pqPYk+bFtIAhP8A8ebj8N/eErWSt/SW2kalJ+O+R3zkDtU2XZkRJ0Ri1oalQ3o6XFrVhKUAjIKiVE6gRg4P0oNwwuTbUvPypSvZ3lcrKPE2vPvAk9Cf86UbmRpKHHG4uHEveBJY0BaEaQBlJISSOnUZOTtmo8r2225OxauZClWh6BObkxlhcRw4JV4SFeXrT/3Qmddor4dfaQhJ1uM6VKQM+RIyKVYZXIlLt10VHlFgght9kpT06KSrooeh9QTUaBcZS58tK3UNsNyClppI1YA+B6bjHypTZMqWb6/7PLlINmaPbl2GBBecjqmLeAK1PLbzrV2zjYDpXeE7pKucHmyUoVjYOAYKz1JP5CgFvmOQ5QLkrTAS2FSGHiCVHGSSPpt2yKuFousW4sEw2w2y0rQDpABNW4MoysDdfr7i3NmE0dKwP7VECFxxOS2nSh1KHQQNskb/AJit7CkpTqUoBI3UT2FZZxZCi8QXByWtsKyrAPoNhVb1BDleRBUyPP0oD7CH0YxsNwagOJSwsFtD0ZWO3Qn4VdtOUYBpt2M24jS6kKAPyNSlbHM9jyNjNqaMFwr0gsJRc8LIGlD6Enwn1qNc7Y1cSp9t9sPKGeag+Fw/1DsaIyLRDdaUEthJAyCnbFBZUORF8TWvT11JG5pDYmBtZ1cXiKOuzUCxAr8OZHcPOZUD54yD86jFkLWAR0PWrml11xhlxE95LyexRkj8qgybDJeVzwpIWskkJTpB+XanozfyEgzrpxzhY/4MrVvn3K2PKct8l5hxJI1NKwfn5/Orpa/tRubLCU3eIxObAAK8aF4+PQ/lVckWybDdK1NZSRnKd96HOsFbqkLynV0+dODScNNXY4t4QvqA1IdMNxY9ySjb69PzqLL+zy1XDU/bvZ1BWSFML0k/tWWexOaN+o7V1uRLgKS7DfeYV0PKURmtJBjFyES0TeAbna3w/E1q0HOlwY//AEAR+VBr3br2860owF8plpKM6kqJI6qODkk5qfb/ALQuJIKglUwPI8nUZ/MYo3G+1RS0n7xszT3mW1DP5ivbBGecZRjNultWpxuI6wgpwc74OME57U3ZJ0iRcEMMNLdXJUEBCSPEe1aKeOuD56f9Zb5Ec9yAT+hNPR7twQd413ci+i0D9wKEYge4f5Dfcqy493uLqILdplpdUdGXI6gkHO25GNqvlp+ye3RrOF3qY8zM8S3lNOjlAeWCMbdSfSiFsvlkS3oPEEV5s7hJSBn6GjYvFjdwo3pvbpudqNMaKtQMmZnbcZQr/wABqs9peVYrquU/jwxUgBLgO/qM/TNAY3D3E05t1xiDIZXyMZdWE4I+ecfCtccuVmKMpvLCj/Uo0yb9aWAdV3hgeqyf2pb4MbdxZJMzxoOQIoauMdLsj8bjXj39cjNQnrsW5DBgW4a16g4WoeCegBJxjNaBM4w4WQCZV1iLPfCMk/Whcn7TuHISAmI1Jf8AIIAQmpjoce4m5lGda4SVeUqfvPM1vNo8CEhGnGO+dzsN6scSDbuHrelsqSzGRkhThyVfuazO5/a9cHllu1wmogJ99fiVQeFeZ92lqVOkqecX7pX+E1VjQYloTGM0S+cQKuDZjwQW4vdR6ufHyFAQstmmoTquWUnJUP8ADUkbp1A9e2K9d8xJNycpSW0DYk1xa0FGQe/egkTiKPLVgNPA9s4/vRdpQkJBGQKAMDGFSI40kEHJyN68jTp2SjGMYxSHSWk4T1PUmvJOlGfOigxYRoSdIA8sV0BQbOQM+ldQvDeDXt9JPY1lQTPYQpo6kg7jrUORbYkrZxhGc7EDepZGAryxXkr8XyrZkDSOGmVnWytSDjcZoJN4cktOjSUuBXaryk5QrPkKQohSht0NYRNuZrKtUpnIejrCk9wM5qCuKlRCk+HPvJO2DWtOAFkK0JJxjemnLPBkpOthOTtnFeFzbMydUDJ90aT3FRVW51OrGTj9K1VzhWA4k8sFGDjY1Cc4RTuEScHGNxnatDkTd0yx2KtCvd60gtLB6GtHkcILKVHntHT0yk9qhI4ZUVctRaIPQ5Ox+lFvm7pRMLB3JrxQo771d18LOHCdbPfB3/tTcbhVx9XLDjQUe+/X6VvmCbuEpoyARpzSg4QMb4q7K4Mf0BXOYz6ZpKOB3S8EqktAd8Amt3CbYlRaCnSABuatdjt74b5q21D1IxTxjq4dWtpgIUpR2dzv+n71J/8AInHkobcaC8K3Cu/z61JlzuOFE6Wl0OLOtvkqGmGXlsF7R7pwpSRtn5U8lt3GpJAJ643pdkuTKpGG2nYzoGSWV4GBRCSwFpQ+gJQhQxsPEfjvil49UDw3cXqvDGxm8fIn/9k="}",
                                        height: 100,
                                        width: 168,
                                        fit: BoxFit.cover,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                      padding: EdgeInsets.fromLTRB(10, 0, 8, 8),
                                      width: 190,
                                      child: Text(
                                        "${nama[index]['display']['displayName']}",
                                        style: TextStyle(fontSize: 14),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Container(
                                          padding: EdgeInsets.fromLTRB(10, 0, 8, 8),
                                          child: const Icon(Icons.star,color: Colors.yellow, size: 18,),
                                        ),
                                        Container(
                                          padding: EdgeInsets.fromLTRB(0, 0, 8, 8),
                                          child: Text(nama[index]['content']['reviews'] != null ? nama[index]['content']['reviews']['averageRating'] == null ? "3" : Convert(nama[index]['content']['reviews']['averageRating'].toString()) : "3" )
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(85, 0, 0, 5),
                                          child: Container(
                                            width: 30,
                                            height: 30,
                                            decoration: BoxDecoration(
                                              color: Colors.blue,
                                              borderRadius: BorderRadius.circular(20)
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.fromLTRB(4, 8, 0, 0),
                                              child: Text("50K",
                                              style: TextStyle(fontSize: 12, color: Colors.white),
                                              ),
                                            )
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ));
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
