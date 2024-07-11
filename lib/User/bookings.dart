import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:wellclean/Constants/customwidgets.dart';
import 'package:wellclean/ModelClass/Model_Class.dart';
import 'package:wellclean/Provider/MainProvider.dart';

class bookingsPage extends StatelessWidget {
  final String userId;
  const bookingsPage({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    print('Current user: ${user?.uid ?? 'Not signed in'}');

    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: Color(0xFFFEF1E2),
        appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Color.fromARGB(255, 101, 25, 113),
            toolbarHeight: 70,
            title: Text("Bookings",
                style: TextStyle(
                  color: Color.fromARGB(255, 251, 241, 226),
                )),
            centerTitle: true,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(15),
                    bottomRight: Radius.circular(15)))),
        body: Consumer<MainProvider>(
          builder: (context, provider, child) {
            return FutureBuilder<List<Booking>>(
              future: provider.getUserBookings(userId),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                      child: SpinKitRipple(
                    color: Color(0xbd380038),
                  ));
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData) {
                  return Center(child: Text('No data received'));
                } else if (snapshot.data!.isEmpty) {
                  return Center(child: Text('No bookings found'));
                } else {
                  return ListView.builder(
                    reverse: true,
                    physics: ScrollPhysics(),
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      Booking booking = snapshot.data![index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 8),
                        child: ListTile(
                          contentPadding:
                              EdgeInsets.only(left: 10, top: 10, bottom: 10),
                          tileColor: Colors.white,
                          shape: RoundedRectangleBorder(
                              side: BorderSide(
                                  width: 1, color: Color(0xff560156)),
                              borderRadius: BorderRadius.circular(8)),
                          title: Text(
                              '${booking.serviceType} - ${booking.selectedVenture}'),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Selected Services: ${booking.selectedServices.join(",")}'),
                              Text('Booked on: ${booking.bookedDate}'),
                              Text('Service Date: ${booking.date}'),
                              Text(
                                'Address: ${booking.serviceAddress.username}\n'
                                    '${booking.serviceAddress.mobileNumber}\n'
                                    '${booking.serviceAddress.userAddress}\n'
                                    '${booking.serviceAddress.district}, ${booking.serviceAddress.state}\n'
                                    '${booking.serviceAddress.pincode}', // Adjust the style as needed
                              ),

                              RichText(
                                text: TextSpan(
                                  style: DefaultTextStyle.of(context).style,
                                  children: <TextSpan>[
                                    TextSpan(
                                      text: 'Service Status: ',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors
                                            .black, // Or any color you prefer for the label
                                      ),
                                    ),
                                    TextSpan(
                                      text: booking.status,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: provider
                                            .getStatusColor(booking.status),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          trailing: Container(
                              width: width / 5,
                              height: height / 30,
                              decoration: ShapeDecoration(
                                  gradient: LinearGradient(colors: [
                                    Color(0xff6c046c),
                                    Color(0xffa955a9),
                                    Color(0xff6c046c),
                                  ]),
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadiusDirectional.horizontal(
                                              start: Radius.circular(15)))),
                              child: Center(
                                child: Text(
                                  '₹${booking.advancePayment}',
                                  style: TextStyle(color: Color(0xfffff1e2)),
                                ),
                              )),
                          isThreeLine: true,
                        ),
                      );
                    },
                  );
                }
              },
            );
          },
        ));
  }
}

// void showBottomSheet(BuildContext context) {
//   showModalBottomSheet(barrierColor: Colors.transparent,
//       elevation: 100,
//       backgroundColor: Colors.transparent,
//       shape: const RoundedRectangleBorder(
//           borderRadius: BorderRadius.only(
//         topLeft: Radius.circular(10.0),
//         topRight: Radius.circular(10.0),
//       )),
//       context: context,
//       builder: (BuildContext bc) {
//         return Container(
//             height: 1000,
//             width: 400,
//             child: Column(
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.only(top: 4.0),
//                   child: Container(
//                     height: 5,
//                     width: 40,
//                     decoration: ShapeDecoration(
//                         color: Color(0xbd380038),
//                         shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(15))),
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Container(
//                     height: 110,
//                     width: 340,
//                     decoration: ShapeDecoration(
//                         color: Colors.white,
//                         shape: RoundedRectangleBorder(
//                             side: BorderSide(width: 2, color: Colors.black),
//                             borderRadius: BorderRadius.circular(10))),
//                     child: Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: Column(
//                           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(
//                               "Residential",
//                               style: TextStyle(
//                                   fontWeight: FontWeight.bold,
//                                   fontSize: 20,
//                                   color: Color(0xbd563c56)),
//                             ),
//                             Text(
//                               "House",
//                               style: TextStyle(
//                                   fontWeight: FontWeight.w500,
//                                   fontSize: 20,
//                                   color: Color(0xbd563c56)),
//                             ),
//                             Text(
//                               "Normal Cleaning",
//                               style: TextStyle(
//                                   fontWeight: FontWeight.w500,
//                                   fontSize: 20,
//                                   color: Color(0xbd563c56)),
//                             )
//                           ]),
//                     ),
//                   ),
//                 ),
//                 Container(
//                   height: 110,
//                   width: 340,
//                   decoration: ShapeDecoration(
//                       color: Colors.white,
//                       shape: RoundedRectangleBorder(
//                           side: BorderSide(width: 2, color: Colors.black),
//                           borderRadius: BorderRadius.circular(10))),
//                   child: Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Column(
//                         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Row(
//                             children: [
//                               SizedBox(
//                                 width: 102,
//                                 child: Row(
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceBetween,
//                                   children: [
//                                     Text(
//                                       "Booked Date",
//                                       style: TextStyle(
//                                           color: Color(0xbd563c56),
//                                           fontSize: 16,
//                                           fontWeight: FontWeight.bold),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                               Text(
//                                 ":",
//                                 style: TextStyle(
//                                     color: Color(0xbd563c56),
//                                     fontSize: 16,
//                                     fontWeight: FontWeight.bold),
//                               ),
//                               Text(
//                                 "01/12/2023",
//                                 style: TextStyle(
//                                     color: Color(0xbd563c56),
//                                     fontSize: 16,
//                                     fontWeight: FontWeight.bold),
//                               )
//                             ],
//                           ),
//                           Row(
//                             children: [
//                               SizedBox(
//                                 width: 102,
//                                 child: Row(
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceBetween,
//                                   children: [
//                                     Text(
//                                       "Service Date",
//                                       style: TextStyle(
//                                           color: Color(0xbd563c56),
//                                           fontSize: 16,
//                                           fontWeight: FontWeight.bold),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                               Text(
//                                 ":",
//                                 style: TextStyle(
//                                     color: Color(0xbd563c56),
//                                     fontSize: 16,
//                                     fontWeight: FontWeight.bold),
//                               ),
//                               Text(
//                                 "12/12/2023",
//                                 style: TextStyle(
//                                     color: Color(0xbd563c56),
//                                     fontSize: 16,
//                                     fontWeight: FontWeight.bold),
//                               )
//                             ],
//                           ),
//                           Row(
//                             children: [
//                               SizedBox(
//                                 width: 102,
//                                 child: Row(
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceBetween,
//                                   children: [
//                                     Text(
//                                       "Status",
//                                       style: TextStyle(
//                                           color: Color(0xbd563c56),
//                                           fontSize: 16,
//                                           fontWeight: FontWeight.bold),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                               Text(
//                                 ":",
//                                 style: TextStyle(
//                                     color: Color(0xbd563c56),
//                                     fontSize: 16,
//                                     fontWeight: FontWeight.bold),
//                               ),
//                               Text(
//                                 "Pending",
//                                 style: TextStyle(
//                                     color: Color(0xbd563c56),
//                                     fontSize: 16,
//                                     fontWeight: FontWeight.bold),
//                               )
//                             ],
//                           ),
//                         ]),
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Container(
//                     height: 160,
//                     width: 340,
//                     decoration: ShapeDecoration(
//                         color: Colors.white,
//                         shape: RoundedRectangleBorder(
//                             side: BorderSide(width: 2, color: Colors.black),
//                             borderRadius: BorderRadius.circular(10))),
//                     child: Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             "Mohammed Anas",
//                             style: TextStyle(
//                                 fontSize: 20,
//                                 fontWeight: FontWeight.bold,
//                                 color: Color(0xbd563c56)),
//                           ),
//                           Text(
//                             "9856478167",
//                             style: TextStyle(
//                                 fontSize: 14,
//                                 fontWeight: FontWeight.bold,
//                                 color: Color(0xbd563c56)),
//                           ),
//                           Text(
//                             "Manaladi,Mannarkkad",
//                             style: TextStyle(
//                                 fontSize: 14,
//                                 fontWeight: FontWeight.bold,
//                                 color: Color(0xbd563c56)),
//                           ),
//                           Text(
//                             "Palakkad",
//                             style: TextStyle(
//                                 fontSize: 14,
//                                 fontWeight: FontWeight.bold,
//                                 color: Color(0xbd563c56)),
//                           ),
//                           Text(
//                             "Kerala",
//                             style: TextStyle(
//                                 fontSize: 14,
//                                 fontWeight: FontWeight.bold,
//                                 color: Color(0xbd563c56)),
//                           ),
//                           Text(
//                             "987456",
//                             style: TextStyle(
//                                 fontSize: 14,
//                                 fontWeight: FontWeight.bold,
//                                 color: Color(0xbd563c56)),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ));
//       });
// }
