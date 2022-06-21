import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:proyekambw/Profile-Page.dart';
import 'package:proyekambw/SignUp-Page.dart';
import 'package:proyekambw/cart.dart';
import 'package:proyekambw/detMakanan.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:proyekambw/filter.dart';
import 'package:proyekambw/navbar.dart';
import 'package:proyekambw/shopping_Payment.dart';
import 'firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hexcolor/hexcolor.dart';

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

    //   child: Column(
    //     mainAxisAlignment: MainAxisAlignment.center,
    //     children: [
    //       SizedBox(height: 40),
    //       TextField(
    //         controller: email_Controller,
    //         textInputAction: TextInputAction.next,
    //         decoration: InputDecoration(labelText: "Email"),
    //       ),
    //       SizedBox(height: 40),
    //       TextField(
    //         controller: password_Controller,
    //         textInputAction: TextInputAction.next,
    //         decoration: InputDecoration(labelText: "Password"),
    //       ),
    //       ElevatedButton(
    // onPressed: () {
    //   signIn();
    // },
    // child: Text("Sign In"),
    //       ),
    //       ElevatedButton(
    //           onPressed: () {
    //             Navigator.push(
    //               context,
    //               MaterialPageRoute(
    //                 builder: (context) {
    //                   return SignUp_Page();
    //                 },
    //               ),
    //             );
    //           },
    //           child: Text("Sign Up"))
    //     ],
    //   ),
    // ),
    //);
  }

  Future signIn() async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Center(
        child: CircularProgressIndicator(),
      ),
    );
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email_Controller.text.trim(),
          password: password_Controller.text.trim());
    } on FirebaseAuthException catch (e) {
      print(e);
    }
    navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int selected = 0;
  var index = 0;

  @override
  void initState() {
    super.initState();
    getName();
  }

  getName() async {
    var url = await Uri.https(
        "yummly2.p.rapidapi.com", "/feeds/list", {"limit": "15", "start": "3"});
    // var url = Uri.https("yummly2.p.rapidapi.com", "/feeds/list", {"limit": "15", "start": "3"});
    var response = await http.get(url, headers: {
      'X-RapidAPI-Host': 'yummly2.p.rapidapi.com',
      'X-RapidAPI-Key': 'c6321e535cmshe3a45a656618a24p1c5898jsn117bc98a5908'
    });
    var items = json.decode(response.body)['feed'];
    setState(() {
      nama = items;
    });
    print(nama);
  }

  @override
  Widget build(BuildContext context) {
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
                      child: Text(
                        "Food Recipe",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
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
                      child: IconButton(
                          onPressed: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return Cart();
                            }));
                          },
                          icon: Icon(Icons.shopping_cart_outlined)),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(10),
              child: GridView.count(
                crossAxisCount: 2,
                mainAxisSpacing: 5.0,
                crossAxisSpacing: 11.0,
                childAspectRatio: 0.85,
                children: List.generate(
                  nama.length,
                  (apapun) {
                    print(" print jumlah = ${nama.length}");
                    if (apapun != 9) {
                      return GestureDetector(
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return detMakanan(
                                id: nama,
                                item_id: apapun,
                              );
                            }));
                          },
                          child: Container(
                            child: Column(
                              children: [
                                Container(
                                  padding: EdgeInsets.all(10),
                                  // ignore: unnecessary_new
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        width: 0.5, color: Colors.grey),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                  ),
                                  child: Container(
                                    child: Row(
                                      children: [
                                        Image.network(
                                          "${nama[apapun]['display']['images'][0]}",
                                          height: 130,
                                          width: 168,
                                          fit: BoxFit.cover,
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                Center(
                                  child: Text(
                                    "${nama[apapun]['display']['displayName']}",
                                    style: TextStyle(fontSize: 15),
                                  ),
                                )
                              ],
                            ),
                          ));
                    } else {
                      return GestureDetector(
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return detMakanan(
                                id: nama,
                                item_id: apapun,
                              );
                            }));
                          },
                          child: Container(
                            child: Column(
                              children: [
                                Container(
                                  padding: EdgeInsets.all(10),
                                  // ignore: unnecessary_new
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        width: 0.5, color: Colors.grey),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                  ),
                                  child: Container(
                                    child: Row(
                                      children: [Icon(Icons.android)],
                                    ),
                                  ),
                                ),
                                Center(
                                  child: Text(
                                    "${nama[apapun]['display']['displayName']}",
                                    style: TextStyle(fontSize: 15),
                                  ),
                                )
                              ],
                            ),
                          ));
                    }
                  },
                  growable: false,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
