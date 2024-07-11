import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import 'package:wellclean/Constants/customwidgets.dart';
import 'package:wellclean/Provider/MainProvider.dart';

class addAddress extends StatelessWidget {
  final String userId;
  addAddress({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Color(0xFFFEF1E2),
      appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 101, 25, 113),
          toolbarHeight: 70,
          leading: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(CupertinoIcons.back,
                  color: Color.fromARGB(255, 251, 241, 226))),
          title: Text("Add Address",
              style: TextStyle(
                color: Color.fromARGB(255, 251, 241, 226),
              )),
          centerTitle: true,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(15),
                  bottomRight: Radius.circular(15)))),
      body: Center(
        child: Consumer<MainProvider>(builder: (context, value, child) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // Text(userId),
              adressinput("Type here", "Name", TextInputType.name,
                  value.nameController,context),
              SizedBox(
                width: 300,
                height: 70,
                child: TextFormField(
                    onEditingComplete: () => FocusScope.of(context).nextFocus(),
                    controller: value.addressController,
                    keyboardType: TextInputType.streetAddress,
                    maxLines: 3,
                    autofocus: true,
                    decoration: InputDecoration(
                        hintText: "Type here",
                        hintStyle: TextStyle(
                          color: Color(0xBC6B526B),
                          fontSize: 15,
                        ),
                        labelText: "Address",
                        floatingLabelStyle: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xBC6B526B),
                          ),
                          borderRadius: BorderRadius.circular(6),
                        ))),
              ),
              SizedBox(
                width: 300,
                height: 48,
                child: TextFormField(
                    onEditingComplete: () => FocusScope.of(context).nextFocus(),
                    controller: value.mobilenumberController,
                    keyboardType: TextInputType.number,
                    inputFormatters: [LengthLimitingTextInputFormatter(10)],
                    autofocus: true,
                    decoration: InputDecoration(
                        hintText: "Type here",
                        hintStyle: TextStyle(
                          color: Color(0xBC6B526B),
                          fontSize: 15,
                        ),
                        labelText: "Mobile Number",
                        floatingLabelStyle: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xBC6B526B),
                          ),
                          borderRadius: BorderRadius.circular(6),
                        ))),
              ),
              adressinput("Type here", "District", TextInputType.name,
                  value.districtController,context),
              adressinput("Type here", "State", TextInputType.name,
                  value.stateController,context),
              SizedBox(
                width: 300,
                height: 48,
                child: TextFormField(
                    onEditingComplete: () => FocusScope.of(context).unfocus(),
                    controller: value.pincodeController,
                    keyboardType: TextInputType.number,
                    inputFormatters: [LengthLimitingTextInputFormatter(6)],
                    autofocus: true,
                    decoration: InputDecoration(
                        hintText: "Type here",
                        hintStyle: TextStyle(
                          color: Color(0xBC6B526B),
                          fontSize: 15,
                        ),
                        labelText: "Pincode",
                        floatingLabelStyle: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xBC6B526B),
                          ),
                          borderRadius: BorderRadius.circular(6),
                        ))),
              ),
              Shimmer(
                duration: const Duration(seconds: 1), //Default value
                interval: const Duration(seconds: 2),
                color: Colors.white,
                colorOpacity: 0.3, //Default value
                enabled: true, //Default value
                direction: ShimmerDirection.fromLeftToRight(),
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStatePropertyAll(Color(0xff750475)),
                    shape: MaterialStatePropertyAll(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6)),
                    ),
                    fixedSize: MaterialStatePropertyAll(Size(190, 40)),
                    // shadowColor: MaterialStatePropertyAll(Color(0xBD000000)),
                  ),
                  onPressed: () {
                    String nameField = value.nameController.text;
                    String addressField = value.addressController.text;
                    String mobileField = value.mobilenumberController.text;
                    String cityField = value.districtController.text;
                    String stateField = value.stateController.text;
                    String pincodeField = value.pincodeController.text;

                    if (nameField.isNotEmpty &&
                        addressField.isNotEmpty &&
                        mobileField.isNotEmpty &&
                        cityField.isNotEmpty &&
                        stateField.isNotEmpty &&
                        pincodeField.isNotEmpty)
                    {
                      value.addAddressFunction(userId);
                      Navigator.pop(context);
                      value.clearAddress();
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                            content: Text('Please Fill all the fields above')),
                      );
                    }
                  },
                  child: Center(
                      child: Text(
                    "Done",
                    style: TextStyle(color: Color(0xFFFEF1E2), fontSize: 15),
                  )),
                ),
              )
            ],
          );
        }),
      ),
    );
  }
}
