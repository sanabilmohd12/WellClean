import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wellclean/Admin/adminbookingsPage.dart';
import 'package:wellclean/Admin/manageservices.dart';
import 'package:wellclean/Admin/carousels.dart';
import 'package:wellclean/Admin/userlist.dart';
import 'package:wellclean/Constants/customwidgets.dart';
import 'package:wellclean/Provider/MainProvider.dart';
import 'package:wellclean/Provider/loginprovider.dart';
import 'package:wellclean/login.dart';

class dashboardPage extends StatelessWidget {
  const dashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    MainProvider mainprovider =
        Provider.of<MainProvider>(context, listen: false);

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      mainprovider.getCarousel();
      mainprovider.getManageservices();
      // mainprovider.getVentures(serviceId:);
      // mainprovider.getVentures();
      mainprovider.getUser();
    });
    return Scaffold(
      backgroundColor: Color(0xFF651971),
      appBar: AppBar(automaticallyImplyLeading: false,
        backgroundColor: Color.fromARGB(255, 101, 25, 113),
        toolbarHeight: 70,
        title: Text("Admin",
            style: TextStyle(
              fontSize: 30,
              color: Color.fromARGB(255, 251, 241, 226),
            )),
        centerTitle: true,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(15),
                bottomRight: Radius.circular(15))),
        actions: [
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            GestureDetector(
              onTap: () {
                showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                          backgroundColor: Colors.red,
                          elevation: 20,
                          content: Text("Do you want to Logout ?",
                              style: TextStyle(
                                  fontSize: 17,
                                  fontFamily: 'ink nut',
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white)),
                          actions: <Widget>[
                            Row(
                              children: [
                                Consumer<loginprovider>(
                                  builder: (context,value,child) {
                                    return TextButton(
                                      onPressed: () {
                                        FirebaseAuth auth = FirebaseAuth.instance;
                                        auth.signOut();
                                        Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => loginPage(),
                                            ));
                                        value.clearLoginPageNumber();


                                      },
                                      child: Container(
                                        height: 45,
                                        width: 90,
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(8),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Color(0x26000000),
                                                blurRadius:
                                                    2.0, // soften the shadow
                                                spreadRadius:
                                                    1.0, //extend the shadow
                                              ),
                                            ]),
                                        child: Center(
                                            child: Text("yes",
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 17,
                                                    fontWeight: FontWeight.w700))),
                                      ),
                                    );
                                  }
                                ),
                                TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Container(
                                      height: 45,
                                      width: 90,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        color: Colors.green,
                                        boxShadow: [
                                          BoxShadow(
                                            color: Color(0x26000000),
                                            blurRadius:
                                                2.0, // soften the shadow
                                            spreadRadius:
                                                1.0, //extend the shadow
                                          ),
                                        ],
                                      ),
                                      child: Center(
                                          child: Text("No",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 17,
                                                  fontWeight:
                                                      FontWeight.w700))),
                                    ))
                              ],
                            )
                          ],
                        ));
              },
              child: Padding(
                padding:  EdgeInsets.only(right: 12),
                child: Icon(Icons.logout_rounded),
              ),
            )
          ])
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: SizedBox(
              width: width / 1.1,
              child: Consumer<MainProvider>(builder: (context, value, child) {
                return GridView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: value.dashboardnames.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8),
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        if (index == 0) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => carouselPage(),
                              ));
                        } else if (index == 1) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => userlistPage(),
                              ));
                        } else if (index == 2) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => manageServices(),
                              ));
                        } else if (index == 3) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => adminbookingsPage(),
                              ));
                        }
                      },
                      child: admingrid(
                          Color(0xFFFFF1E2),
                          value.dashboardimages[index],
                          value.dashboardnames[index]),
                    );
                  },
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}
