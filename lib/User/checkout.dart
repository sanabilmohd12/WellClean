import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import 'package:wellclean/Constants/customwidgets.dart';
import 'package:wellclean/ModelClass/Model_Class.dart';
import 'package:wellclean/Provider/MainProvider.dart';
import 'package:wellclean/User/addaddress.dart';
import 'package:wellclean/User/bookings.dart';
import 'package:wellclean/User/bottombar.dart';
import 'package:wellclean/User/editprofile.dart';

class checkoutPage extends StatelessWidget {
  final List<ResidenceCTypemodelclass> selectedServices;
  final String selectedVenture;
  final String selectedVentureId;
  final String serviceId;
  final String serviceType;
  final String advance;
  final String userId;

  const checkoutPage({
    Key? key,
    required this.selectedServices,
    required this.selectedVenture,
    required this.selectedVentureId,
    required this.serviceId,
    required this.serviceType,
    required this.advance,
    required this.userId,
  }) : super(key: key);

  // const checkoutPage({super.key, required this.selectedServices, required this.selectedVenture, required this.selectedVentureId});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Color(0xFFFEF1E2),
      appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 101, 25, 113),
          leading: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(CupertinoIcons.back,
                  color: Color.fromARGB(255, 251, 241, 226))),
          toolbarHeight: 70,
          title: Text("Checkout",
              style: TextStyle(
                color: Color.fromARGB(255, 251, 241, 226),
              )),
          centerTitle: true,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(15),
                  bottomRight: Radius.circular(15)))),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              space(),
              toplefttext("Service To"),
              Consumer<MainProvider>(
                builder: (context, value, child) {
                  return FutureBuilder<UserAddressmodelclass?>(
                    future: value.getDefaultAddress(userId),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return SpinKitRipple(color: Color(0xbd380038));
                      } else if (snapshot.hasError) {
                        return Text("Error loading address");
                      } else if (snapshot.data == null) {
                        return Column(
                          children: [
                            Text("No default address found"),
                            TextButton(onPressed: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => addAddress(userId: userId,),));
                            }, child: Text("Add"))
                          ],
                        );
                      } else {
                        UserAddressmodelclass item = snapshot.data!;
                        return Container(
                          color: Colors.transparent,
                          width: width,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 30),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item.username,
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xbd000000)),
                                ),
                                Text(
                                  item.useraddress,
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xff000000)),
                                ),
                                Text(
                                  item.mobilenumber,
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xff000000)),
                                ),
                                Text(
                                  item.district,
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xff000000)),
                                ),
                                Text(
                                  item.state,
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xff000000)),
                                ),
                                Text(
                                  item.pincode,
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xff000000)),
                                ),
                              ],
                            ),
                          ),
                        );
                      }
                    },
                  );
                },
              ),
              Divider(height: 35, color: Colors.white, thickness: 7),
              Center(
                  child: Text("Pick A Date",
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF6B526B)))),
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Consumer<MainProvider>(builder: (context, value, child) {
                  return SizedBox(
                    width: 200,
                    height: 60,
                    child: Center(
                      child: TextField(
                        keyboardType: TextInputType.none,
                        textAlign: TextAlign.center,
                        controller: value.dateController,
                        decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.edit_calendar_outlined,
                              color: Color(0xBC6B526B),
                            ),
                            hintText: " dd/mm/yyyy ",
                            hintStyle: TextStyle(
                              color: Color(0xBC6B526B),
                              fontSize: 16,
                            ),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0xBC590059),
                              ),
                              borderRadius: BorderRadius.circular(6),
                            )),
                        onTap: () {
                          value.selectDate(context);
                        },
                        style: TextStyle(
                          color: Color(0xFF482A48),
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  );
                }),
              ),
              Divider(height: 35, color: Colors.white, thickness: 7),
              toplefttext("Booking Details"),
              Container(
                color: Colors.transparent,
                width: width,
                child: Padding(
                  padding: const EdgeInsets.only(left: 30, bottom: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(serviceType + ":",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF6B526B))),
                      ListTile(
                        title: Text('Selected Venture:',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF6B526B))),
                        subtitle: Text(selectedVenture,
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                                color: Color(0xFF6B526B))),
                      ),
                      Divider(endIndent: 40),
                      Padding(
                        padding: const EdgeInsets.only(left: 17.0),
                        child: Text('Selected Services:',
                            style: TextStyle(
                                color: Color(0xFF6B526B),
                                fontSize: 15,
                                fontWeight: FontWeight.bold)),
                      ),
                      ...selectedServices
                          .map((service) => SizedBox(
                                height: 30,
                                child: ListTile(
                                  title: Text(service.name,
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500,
                                          color: Color(0xFF6B526B))),
                                  // Add more details as needed
                                ),
                              ))
                          .toList(),
                    ],
                  ),
                ),
              ),
              Divider(height: 35, color: Colors.white, thickness: 7),
              toplefttext("Payment Methods"),
              Consumer<MainProvider>(builder: (context, value, child) {
                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        child: RadioListTile(
                          tileColor: Color(0xbd4d024d),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)),
                          selectedTileColor: Color(0xff0f4350),
                          contentPadding: EdgeInsets.only(right: 5),
                          title: Text("UPI",
                              style: TextStyle(
                                  color: Color(0xFFFFF1E2),
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold)),
                          secondary: SizedBox(
                              height: 40,
                              width: 40,
                              child: Image.asset("assets/upi.png")),

                          // selected: value.radioselectvalue,
                          // selected: true ,

                          value: 0,
                          groupValue: value.checkoutradiovalue,
                          onChanged: (val) {
                            value.checkradiovalue(val);
                          },
                          activeColor: Color(0xFFFFF1E2),
                        ),
                        height: 55,
                        width: width / 1.1,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Container(
                        child: RadioListTile(
                          tileColor: Color(0xbd4d024d),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)),
                          selectedTileColor: Color(0xff0f4350),
                          contentPadding: EdgeInsets.only(right: 5),
                          title: Text("Credit/Debit Card",
                              style: TextStyle(
                                  color: Color(0xFFFFF1E2),
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold)),
                          secondary: SizedBox(
                              height: 40,
                              width: 40,
                              child: Image.asset("assets/credit-card.png",
                                  scale: 1)),
                          // selected: value.radioselectvalue,
                          // selected: true ,

                          value: 1,
                          groupValue: value.checkoutradiovalue,
                          onChanged: (val) {
                            value.checkradiovalue(val);
                          },
                          activeColor: Color(0xFFFFF1E2),
                        ),
                        height: 55,
                        width: width / 1.1,
                      ),
                    ),
                  ],
                );
              }),
              space(),
              space(),
              space()
            ],
          ),
        ),
      ),
      bottomSheet: Consumer<MainProvider>(builder: (context, value, child) {
        String pickedDate = value.dateController.text;
        return Shimmer(
          duration: const Duration(seconds: 1), //Default value
          interval: const Duration(seconds: 2),
          color: Color(0xff651971),
          colorOpacity: 0.1, //Default value
          enabled: true, //Default value
          direction: ShimmerDirection.fromRTLB(),
          child: Container(
            width: width,
            height: height / 10,
            decoration: ShapeDecoration(
                shadows: [
                  BoxShadow(
                      color: Color(0xff47004f), spreadRadius: 1, blurRadius: 1)
                ],
                color: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(15),
                        topLeft: Radius.circular(15)))),
            child: pickedDate.isNotEmpty?  Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Padding(
                    padding:  EdgeInsets.all(10.0),
                    child: Column(mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Advance Payment",
                            style: TextStyle(
                                fontSize: 11,
                                color: Color(0xbd4b284b),
                                fontWeight: FontWeight.bold)),
                        Text("₹" + advance,
                            style: TextStyle(
                                fontSize: 22,
                                color: Color(0xbd4b284b),
                                fontWeight: FontWeight.bold))
                      ],
                    ),
                  ),
                  Shimmer(
                    duration: const Duration(seconds: 1), //Default value
                    interval: const Duration(seconds: 2),
                    color: Colors.white,
                    colorOpacity: 0.3, //Default value
                    enabled: true, //Default value
                    direction: ShimmerDirection.fromLeftToRight(),
                    child: TextButton(
                        onPressed: () async {
                          String pickedDate = value.dateController.text;

                          if (pickedDate.isNotEmpty) {
                            try {
                              // Fetch the default address
                              UserAddressmodelclass? defaultAddress = await value.getDefaultAddress(userId);

                              if (defaultAddress == null) {
                                throw Exception('No default address found');
                              }

                              Address serviceAddress = Address(
                                username: defaultAddress.username,
                                userAddress: defaultAddress.useraddress,
                                mobileNumber: defaultAddress.mobilenumber,
                                district: defaultAddress.district,
                                state: defaultAddress.state,
                                pincode: defaultAddress.pincode,
                              );

                              String bookedDate = DateTime.now().toIso8601String();

                              Booking newBooking = Booking(
                                id: DateTime.now().millisecondsSinceEpoch.toString(),
                                userId: userId,
                                serviceType: serviceType,
                                selectedVenture: selectedVenture,
                                selectedServices: selectedServices.map((s) => s.name).toList(),
                                date: pickedDate,
                                bookedDate: bookedDate,
                                status: 'Pending',
                                advancePayment: double.parse(advance),
                                serviceAddress: serviceAddress,
                              );

                              await value.addBooking(newBooking);
                              value.razorpayGateway(advance);
                              Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => BottomNavBar(userId: userId,),), (route) => false);

                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Booking confirmed successfully')),
                              );

                            } catch (e) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Error confirming booking: $e')),
                              );
                            }
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Please Pick a Date before Confirming')),
                            );
                          }
                        },
                        style: ButtonStyle(
                            elevation: MaterialStatePropertyAll(6),
                            fixedSize: MaterialStatePropertyAll(Size(150, 5)),
                            backgroundColor:
                                MaterialStatePropertyAll(Color(0xff750475)),
                            shape: MaterialStatePropertyAll(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(6)))),
                        child: Text(
                          "Confirm Booking",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color(0xFFFEF1E2),
                              fontSize: 15),
                        )),
                  ),
                ]): Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      children: [
                        Text("Advance Payment : ",
                            style: TextStyle(
                                fontSize: 16,
                                color: Color(0xbd4b284b),
                                fontWeight: FontWeight.bold)),
                        Text("₹" + advance,
                            style: TextStyle(
                                fontSize: 28,
                                color: Color(0xbd4b284b),
                                fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                ]),
          ),
        );
      }),
    );
  }
}
