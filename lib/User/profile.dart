import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wellclean/Constants/customwidgets.dart';
import 'package:wellclean/Provider/MainProvider.dart';
import 'package:wellclean/User/aboutus.dart';
import 'package:wellclean/User/editprofile.dart';

class profilePage extends StatelessWidget {
   String userId;
   profilePage({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Color(0xFFFEF1E2),
      appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 101, 25, 113),
          toolbarHeight: 70,
          title: Text("Profile",
              style: TextStyle(
                color: Color.fromARGB(255, 251, 241, 226),
              )),
          centerTitle: true,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(15),
                  bottomRight: Radius.circular(15)))),
      body: Center(
        child: Column(
          children: [
            space(),
            Container(
              height: 125,
              width: 125,
              decoration: ShapeDecoration(
                  color: Color(0xffe4b3ee),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100))),
            ),
            Text("Mohammed Anas",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                    color: Color(0xff6a516b))),
            space(),
            Consumer<MainProvider>(builder: (context, value, child) {
              return ListView.builder(
                padding: EdgeInsets.zero,
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: value.settingslistnames.length,
                itemBuilder: (context, index) {
                  return InkWell(onTap: () {
                    if(index==0){
                      value.getAddressesFunction(userId);
                      Navigator.push(context, MaterialPageRoute(builder: (context) => editProfile(userId: userId,),));
                    }else if(index==1){
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Center(
                            child: const Text("Contact Us",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontFamily: "semibold",
                                  color: Colors.white,
                                )),
                          ),
                          contentPadding: EdgeInsets.zero,
                          backgroundColor: Color(0xff380038),
                          content: Padding(
                            padding: const EdgeInsets.only(top: 20),
                            child: Container(
                              height: height / 4.8,
                              width: width,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.vertical(bottom: Radius.circular(5.9),top: Radius.circular(10))),
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 25,
                                  ),
                                  Consumer<MainProvider>(
                                      builder: (context, value, child) {
                                        return GestureDetector(
                                          onTap: () {
                                            value.makingPhoneCall("+917907863998");
                                          },
                                          child: Container(
                                            height: height / 20.5,
                                            width: width / 1.5,
                                            decoration: BoxDecoration(
                                              color: Colors.purple,
                                              borderRadius: BorderRadius.circular(8),
                                            ),
                                            child: Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment.center,
                                              children: [
                                                Icon(
                                                  Icons.phone,
                                                  color: Colors.blue,
                                                  size: 16,
                                                ),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Text(
                                                  "+91 7907863998",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 12,
                                                      fontFamily: "semibold",
                                                      fontWeight: FontWeight.w700),
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      }),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  Consumer<MainProvider>(
                                      builder: (context, value, child) {
                                        return GestureDetector(
                                          onTap: () {
                                            value.launchWhatsApp(
                                              phoneNumber: '+917907863998', // Replace with the target phone number
                                              message: 'Hello, How can I help you?',
                                            );
                                          },
                                          child: Container(
                                            height: height / 20.5,
                                            width: width / 1.5,
                                            decoration: BoxDecoration(
                                              color: Colors.purple,
                                              borderRadius: BorderRadius.circular(8),
                                            ),
                                            child: Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment.center,
                                              children: [
                                                Image.asset(
                                                  "assets/Test Account.png",
                                                  scale: 4,
                                                ),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Text(
                                                  "+91 7907863998",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 12,
                                                      fontFamily: "semibold",
                                                      fontWeight: FontWeight.w700),
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      }),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    }else if(index==2){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => aboutUs(),));
                    }
                  },
                    child: ListTile(
                      leading: Image.asset(
                        value.settingslistimages[index],
                        scale: 5,
                      ),
                      title: Text(value.settingslistnames[index],style: TextStyle(fontSize: 17,color: Color(0xbd563c56),fontWeight: FontWeight.bold)),
                      trailing: Icon(CupertinoIcons.forward,color: Color(0xbd563c56),),
                      shape: LinearBorder(
                          bottom: LinearBorderEdge(size: 1),
                          side: BorderSide(color: Color(0xbd563c56))),
                    ),
                  );
                },
              );
            })
          ],
        ),
      ),
    );
  }
}


