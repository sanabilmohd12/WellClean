import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';
import 'package:wellclean/Provider/loginprovider.dart';

class otpscreen extends StatelessWidget {
  String mobile;
   otpscreen({super.key,required this.mobile});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Color(0xFFFEF1E2),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 108.0),
                child: Lottie.asset("assets/otpanimation.json",height: 120,width: 120),
              ),

              Padding(
                padding: const EdgeInsets.only(top: 70.0,bottom: 10),
                child: Text(
                  'OTP Verification',
                  style: TextStyle(
                    color: Color(0xFF6B526B),
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 20.0),
                child: Text(
                  'Enter the OTP sent to +91 '+ mobile,
                  style: TextStyle(
                    color: Color(0xCD6B526B),
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),

              Consumer<loginprovider>(builder: (context, value, child) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 30),
                  child: Pinput(
                    controller:value.otpverifycontroller,
                    length: 6,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    defaultPinTheme: PinTheme(
                        textStyle: TextStyle(fontWeight: FontWeight.bold),
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.transparent,
                                blurRadius: 2.0, // soften the shadow
                                spreadRadius: 1.0, //extend the shadow
                              ),
                            ],
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              width: 2,
                              color: Color(0xFF6B526B),
                            ))),

                    onCompleted: (pin) {
                      print("jffhi");
                      value.verify(context);
                    },
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
