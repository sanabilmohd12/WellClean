import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wellclean/Provider/MainProvider.dart';
import 'package:wellclean/Provider/loginprovider.dart';
import 'package:wellclean/login.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {

    // print("codee id here");

    Timer? _timer;
    final FirebaseFirestore db = FirebaseFirestore.instance;
    String type= '';

    FirebaseAuth auth = FirebaseAuth.instance;
    var loginUser = auth.currentUser;

    super.initState();

    loginprovider loginProvider = Provider.of<loginprovider>(context, listen: false);
    MainProvider mainProvider = Provider.of<MainProvider>(context, listen: false);



    Timer(const Duration(seconds: 3), () {
      if (loginUser == null) {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => loginPage()));
      }
      else {
        loginProvider.userAuthorized(loginUser.phoneNumber, context);
      }
    });

  }
  @override
  Widget build(BuildContext context) {
    MainProvider provider = Provider.of<MainProvider>(context, listen: true);

    return Scaffold(
      backgroundColor: Color(0xFFFEF1E2),
      body: Center(child: Image.asset("assets/SplashImage.png",scale: 4.5,)),

    );
  }
}