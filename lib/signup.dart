import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wellclean/Constants/customwidgets.dart';
import 'package:wellclean/Provider/MainProvider.dart';

class signupPage extends StatelessWidget {
  const signupPage({super.key});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Color(0xFF641870),
      body: Padding(
        padding: const EdgeInsets.only(top: 68),
        child: SingleChildScrollView(
          child: Consumer<MainProvider>(builder: (context, value, child) {
            return Column(
              verticalDirection: VerticalDirection.up,
              children: [
                SizedBox(
                  height: height / 1.1,
                  child: Stack(children: [
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.only(
                            right: 10, left: 10, top: 40, bottom: 10),
                        child: Container(
                          width: width / 1,
                          decoration: ShapeDecoration(
                            color: Color(0xFFFEF1E2),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Center(
                      child: Column(
                        children: [
                          Image.asset(
                            "assets/login.png",
                            scale: 4.5,
                          ),
                          Text(
                            'Sign up',
                            style: TextStyle(
                              color: Color(0xFF6B526B),
                              fontSize: 33,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Text(
                            'Create a new account',
                            style: TextStyle(
                              color: Color(0xBC6B526B),
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: height / 12),
                            child: SizedBox(
                                height: height / 20,
                                width: width / 1.2,
                                child: logininput(
                                  CupertinoIcons.person,
                                  "Name",
                                  TextInputType.name,
                                    value.usernameController
                                )),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: height / 24),
                            child: SizedBox(
                                height: height / 20,
                                width: width / 1.2,
                                child: logininput(CupertinoIcons.phone,
                                    "Mobile Number", TextInputType.number,
                                  value.usernumberController
                                )),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: height / 9),
                            child: SizedBox(
                                height: height / 24,
                                width: width / 2.2,
                                child: GestureDetector(onTap:() {
                                  value.addUser();
                                },
                                  child: Loginbuttons(
                                      Color(0xFF6B526B), "Create Account"),
                                )),
                          ),
                          GestureDetector(onTap: () {
                            Navigator.pop(context);
                          },
                            child: Padding(
                              padding: EdgeInsets.only(top: height / 3.8),
                              child:
                                  bottomtext("Already Registered?", "Login Now"),
                            ),
                          )
                        ],
                      ),
                    ),
                  ]),
                ),
              ],
            );
          }),
        ),
      ),
    );
  }
}
