import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:proyekambw/Profile-Page.dart';
import 'package:proyekambw/detMakanan.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:proyekambw/navbar.dart';
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
    home: MainPage(),
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
              child: Text("Sign In"))
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
      'X-RapidAPI-Key': 'e62549d6b6mshb04641adf26a586p1f4c67jsnead451b22fa7'
    });
    var items = json.decode(response.body)['feed'];
    setState(() {
      nama = items;
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.restaurant_menu),
            Text("Food Recipe"),
          ],
        ),
        backgroundColor: Colors.blueGrey,
      ),
      body: Container(
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
                          decoration: new BoxDecoration(
                              color: Theme.of(context).primaryColorLight,
                              // ignore: prefer_const_literals_to_create_immutables
                              boxShadow: [
                                // ignore: prefer_const_constructors
                                BoxShadow(
                                  color: Colors.grey,
                                  spreadRadius: 3,
                                  blurRadius: 10,
                                  offset: Offset(0, 3),
                                )
                              ]),
                          child: Container(
                            child: Row(
                              children: [
                                Image.network(
                                  "${nama[index]['display']['images'][0]}",
                                  height: 140,
                                  width: 170,
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
                  ));
            },
          ),
        ),
      ),
    );
  }
}
