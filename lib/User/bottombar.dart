// import 'package:flutter/material.dart';
// import 'package:curved_navigation_bar/curved_navigation_bar.dart';
// import 'package:wellclean/Constants/my_flutter_icons.dart';
// import 'package:wellclean/User/bookings.dart';
// import 'package:wellclean/User/home.dart';
// import 'package:wellclean/User/notifications.dart';
// import 'package:wellclean/User/profile.dart';
//
//
// class BottomNavBar extends StatefulWidget {
//     String userId;
//
//    BottomNavBar({super.key, required this.userId});
//   @override
//   _BottomNavBarState createState() => _BottomNavBarState();
// }
//
// class _BottomNavBarState extends State<BottomNavBar> {
//   int index = 0;
//   // GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();
//   final navigationanKey = GlobalKey<CurvedNavigationBarState>();
//
//   final Screen = [
//     homePage(),
//     bookingsPage(),
//     // notification(),
//     profilePage(userId:widget.userId,)
//
//   ];
//
//   final  items= <Widget>[
//
//     // Icon(Icons.home_outlined,color: Colors.white,),
//     // Icon(Icons.book,color: Colors.white),
//     // Icon(Icons.book,color: Colors.white),
//
//     Container(
//       height: 40,
//       width: 40,
//       decoration: ShapeDecoration(
//           shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(100)),
//           color: Color(0xff651971)),
//       child: Icon(MyFlutterIcons.homeicon,color: Color(0xFFFEF1E2),),
//
//
//     ),
//     Container(
//       height: 40,
//       width: 40,
//       decoration: ShapeDecoration(
//           shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(100)),
//           color: Color(0xff651971)),
//       child: Icon(MyFlutterIcons.bookings,color: Color(0xFFFEF1E2),),
//
//
//     ),
//     // Container(
//     //   height: 40,
//     //   width: 40,
//     //   decoration: ShapeDecoration(
//     //       shape: RoundedRectangleBorder(
//     //           borderRadius: BorderRadius.circular(100)),
//     //       color: Color(0xff651971)),
//     //   child: Icon(MyFlutterIcons.notification,color: Color(0xFFFEF1E2),),
//     //
//     //
//     // ),
//     Container(
//       height: 40,
//       width: 40,
//       decoration: ShapeDecoration(
//           shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(100)),
//           color: Color(0xff651971)),
//       child: Icon(MyFlutterIcons.user,color: Color(0xFFFEF1E2),),
//
//
//     ),
//
//
//     // CircleAvatar(backgroundColor: Colors.transparent,radius: 20,backgroundImage: AssetImage("assets/homebutton.png")),
//     // CircleAvatar(backgroundColor: Colors.transparent,radius: 20,backgroundImage: AssetImage("assets/bookingsbutton.png")),
//     // CircleAvatar(backgroundColor: Colors.transparent,radius: 20,backgroundImage: AssetImage("assets/profilebutton.png")),
//
//
//
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         backgroundColor: Colors.transparent,
//         bottomNavigationBar: CurvedNavigationBar(
//           items: items,
//           index: index,
//           height: 60.0,
//           onTap: (index) => setState(() {
//             this.index=index;
//           }),
//           color: Color(0xff651971),
//           // buttonBackgroundColor: Colors.white,
//           backgroundColor: Color(0xFFFEF1E2),
//           animationCurve: Curves.easeInOut,
//           animationDuration: Duration(milliseconds: 600),
//           letIndexChange: (index) => true,
//         ),
//         body: Screen[index]);
//   }
// }
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:wellclean/Constants/my_flutter_icons.dart';
import 'package:wellclean/User/bookings.dart';
import 'package:wellclean/User/home.dart';
import 'package:wellclean/User/profile.dart';
class BottomNavBar extends StatefulWidget {
  final String userId;
  const BottomNavBar({Key? key, required this.userId}) : super(key: key);

  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int index = 0;
  final navigationKey = GlobalKey<CurvedNavigationBarState>();

  late final List<Widget> screens;

  @override
  void initState() {
    super.initState();
    screens = [
      homePage(userId: widget.userId,),
      bookingsPage(userId: widget.userId,),
      profilePage(userId: widget.userId),
    ];
  }

  final items = <Widget>[
    Container(
      height: 40,
      width: 40,
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(100),
        ),
        color: Color(0xff651971),
      ),
      child: Icon(MyFlutterIcons.homeicon, color: Color(0xFFFEF1E2)),
    ),
    Container(
      height: 40,
      width: 40,
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(100),
        ),
        color: Color(0xff651971),
      ),
      child: Icon(MyFlutterIcons.bookings, color: Color(0xFFFEF1E2)),
    ),
    Container(
      height: 40,
      width: 40,
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(100),
        ),
        color: Color(0xff651971),
      ),
      child: Icon(MyFlutterIcons.user, color: Color(0xFFFEF1E2)),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      bottomNavigationBar: CurvedNavigationBar(
        key: navigationKey,
        items: items,
        index: index,
        height: 60.0,
        onTap: (index) => setState(() {
          this.index = index;
        }),
        color: Color(0xff651971),
        backgroundColor: Color(0xFFFEF1E2),
        animationCurve: Curves.easeInOut,
        animationDuration: Duration(milliseconds: 600),
        letIndexChange: (index) => true,
      ),
      body: screens[index],
    );
  }
}