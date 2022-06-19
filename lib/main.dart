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

List nama = [];

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
    home: MainPage(),
    //home: Home(),
  ));
}

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          // if (snapshot.hasData) {
          //   return ProfilePage();
          //   //return MyApp();
          // } else {
          //   //return LoginPage();
          // }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text("Something was Wrong"),
            );
          } else if (snapshot.hasData) {
            return NavBar();
          } else {
            return LoginPage();
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
  final email_Controller = TextEditingController();
  final password_Controller = TextEditingController();
  void dispose() {
    email_Controller.dispose();
    password_Controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 40),
          TextField(
            controller: email_Controller,
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(labelText: "Email"),
          ),
          SizedBox(height: 40),
          TextField(
            controller: password_Controller,
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(labelText: "Password"),
          ),
          ElevatedButton(
            onPressed: () {
              signIn();
            },
            child: Text("Sign In"),
          ),
          ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return SignUp_Page();
                    },
                  ),
                );
              },
              child: Text("Sign Up"))
        ],
      ),
    );
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
      'X-RapidAPI-Key': '8c00a4169emsh39f8279befde855p16b47cjsnef7ede20adb9'
    });
    var items = json.decode(response.body)['feed'];
    setState(() {
      nama = items;
    });
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
                        style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                  ),
                  ],
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                      child: IconButton(onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context){
                          return Filter(isi: nama);
                        } ));
                      }, icon: Icon(Icons.filter_alt_outlined)),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                      child: IconButton(onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context){
                          return Cart();
                        } ));
                      } , icon: Icon(Icons.shopping_cart_outlined)),
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
                  (index) {
                    return GestureDetector(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return detMakanan(
                              id: nama,
                              item_id: index,
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
                                        "${nama[index]['display']['images'][0]}",
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
                                  "${nama[index]['display']['displayName']}",
                                  style: TextStyle(fontSize: 15),
                                ),
                              )
                            ],
                          ),
                        )
                      );
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
