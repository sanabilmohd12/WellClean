import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:wellclean/Constants/customwidgets.dart';
import 'package:wellclean/Provider/MainProvider.dart';
import 'package:wellclean/Provider/loginprovider.dart';
import 'package:wellclean/signup.dart';

class loginPage extends StatelessWidget {
  const loginPage({super.key});

  @override
  Widget build(BuildContext context) {
    bool _loading = false;

    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Color(0xFF641870),
      body:
      Padding(
        padding: const EdgeInsets.only(top: 68),
        child: SingleChildScrollView(
          child: Consumer<loginprovider>(
            builder: (context, value, child) {
              return Column(
                verticalDirection: VerticalDirection.up,
                children: [
                  SizedBox(
                    height: height / 1.1,
                    child: Stack(
                        children:[
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
                              'Login',
                              style: TextStyle(
                                color: Color(0xFF6B526B),
                                fontSize: 33,
                                fontWeight: FontWeight.w700,

                              ),
                            ),
                            Text(
                              'Login to your account',
                              style: TextStyle(
                                color: Color(0xBC6B526B),
                                fontSize: 15,
                                fontWeight: FontWeight.w700,

                              ),
                            ),
                            Padding(
                              padding:  EdgeInsets.only(top: height/12),
                              child:
                              // SizedBox(height: height/20,width:width/1.2,
                              //     child:
                              //   logininput(CupertinoIcons.phone,"Mobile Number", TextInputType.number,value.Loginphnnumber),
                                SizedBox(
                                  width: 300,
                                  height: 48,
                                  child: TextFormField(
                                    inputFormatters: [LengthLimitingTextInputFormatter(10)],
                                      controller: value.Loginphnnumber,
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                          floatingLabelStyle: TextStyle(color: Color(0xbd380038)),
                                          prefixIcon: Icon(CupertinoIcons.phone),
                                          hintText: "Type Here",
                                          hintStyle: TextStyle(
                                            color: Color(0xBC6B526B),
                                            fontSize: 10,
                                          ),
                                          labelText: "Mobile Number",


                                          focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(color: Color(0xff730083))),
                                          border: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              width: 10,
                                              color: Color(0xBC6B526B),
                                            ),
                                            borderRadius: BorderRadius.circular(6),
                                          ))),
                                )
                              // ),
                            ),
                            Padding(
                              padding:  EdgeInsets.only(top: height/9),
                              child: InkWell(onTap: () {

                                value.sendotp(context);
                              },
                                child: SizedBox(height: height/24,width:width/1.2,
                                    child:
                                   value.loader?SpinKitRipple(color: Color(0xFF6B526B),):Loginbuttons( Color(0xFF6B526B), "Get OTP")

                                      ),
                              ),
                            ),
                            InkWell(onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => signupPage(),));
                            },
                              child: Padding(
                                padding:  EdgeInsets.only(top: height/2.94),
                                child: bottomtext("New Member?", "Signup Now"),
                              ),
                            )
                          ],
                        ),
                      ),
                    ]),
                  ),
                ],
              );
            }
          ),
        ),
      ),
    );
  }
}
