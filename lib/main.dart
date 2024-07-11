import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wellclean/Admin/manageservices.dart';
import 'package:wellclean/Provider/MainProvider.dart';
import 'package:wellclean/Provider/loginprovider.dart';
import 'package:wellclean/User/bookings.dart';
import 'package:wellclean/User/bottombar.dart';
import 'package:wellclean/User/checkout.dart';
import 'package:wellclean/User/editprofile.dart';
import 'package:wellclean/User/home.dart';
import 'package:wellclean/User/otpscreen.dart';
import 'package:wellclean/User/profile.dart';
import 'package:wellclean/Admin/admindashboard.dart';
import 'package:wellclean/login.dart';
import 'package:wellclean/signup.dart';
import 'package:wellclean/splashScreen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(
        apiKey: "AIzaSyC9hg2bQbk0rsCEb89bWaPMj_qZKR9tcto",
        appId: "1:883301328379:android:b8b8be5f67c63dfee3975e",
        messagingSenderId: "883301328379",
        projectId: "well-clean-a3318",
        storageBucket: "well-clean-a3318.appspot.com"),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => MainProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => loginprovider(),
        )
      ],
      child: MaterialApp(
        theme: ThemeData(
            colorScheme: ColorScheme(
                brightness: Brightness.light,
                primary: Color(0xff651971),
                onPrimary: Color(0xfffff1e2),
                secondary: Colors.blue,
                onSecondary: Colors.cyan,
                error: Colors.red,
                onError: Colors.redAccent,
                background: Colors.lightGreenAccent,
                onBackground: Colors.lime,
                surface: Colors.brown,
                onSurface: Color(0xbd720072))),
        debugShowCheckedModeBanner: false,
        home: SplashScreen(),
        // home: BottomNavBar(),
        // home: const homePage(),
        // home: dashboardPage(),
        // home: profilePage(),
        // home: editProfile(),
        // home: manageServices(),
        // home: bookingsPage(),
        // home: loginPage(),
        // home: signupPage(),
        // home: otpscreen(),
      ),
    );
  }
}
