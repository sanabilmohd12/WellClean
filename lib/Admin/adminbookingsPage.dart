import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:wellclean/Constants/customwidgets.dart';
import 'package:wellclean/ModelClass/Model_Class.dart';
import 'package:wellclean/Provider/MainProvider.dart';

class adminbookingsPage extends StatelessWidget {
  const adminbookingsPage({super.key});

  @override
  Widget build(BuildContext context) {

    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Color(0xffFEF1E2),
      appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 101, 25, 113),
          leading: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(CupertinoIcons.back,
                  color: Color.fromARGB(255, 251, 241, 226))),
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
      body: StreamBuilder<List<Booking>>(
        stream: Provider.of<MainProvider>(context, listen: false).bookingsStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: SpinKitRipple(color: Color(0xbd380038),));
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No bookings found'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                Booking booking = snapshot.data![index];
                return ExpansionTile(
                  title: Text('${booking.serviceType} - ${booking.selectedVenture}'),
                  subtitle: Text('Date: ${booking.date}, Status: ${booking.status}'),
                  children: [
                    ListTile(
                      title: Text('Name: ${booking.serviceAddress.username}'),
                      subtitle: Text('Mobile: ${booking.serviceAddress.mobileNumber}'),
                    ),
                    ListTile(
                      title: Text('Address: ${booking.serviceAddress.userAddress}'),
                      subtitle: Text('${booking.serviceAddress.district}, ${booking.serviceAddress.state} - ${booking.serviceAddress.pincode}'),
                    ),
                    ListTile(
                      title: Text('Advance Payment: ₹${booking.advancePayment}'),
                      subtitle: Text('Booked Date: ${booking.bookedDate}'),
                    ),
                    Consumer<MainProvider>(
                      builder: (context,value,child) {
                        return ListTile(
                          title: Text('Change Status:'),
                          trailing: DropdownButton<String>(
                            value:value.dropdown,
                            items: value.statusOptions.map<DropdownMenuItem<String>>(
                                    (String status) {
                              return DropdownMenuItem<String>(
                                value: status,
                                child: Text(status),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                                  value.statuschange(newValue);
                                  value.bookingstatus(booking.id);

                            },
                          ),
                        );
                      }
                    ),

                  ],
                );
              },
            );
          }
        },
      ),
    );
  }

}

//
// Container(
// height: 30,
// width: width / 2.5,
// decoration: BoxDecoration(
// color: Color(0xbd563c56),
// borderRadius: BorderRadius.circular(5),
// ),
// child: DropdownButton(
// padding:
// EdgeInsets.only(left: 10, right: 10),
// isExpanded: true,
// items: value.bookingstatuslist
//     .map<DropdownMenuItem<String>>(
// (String value) {
// return DropdownMenuItem<String>(
// alignment: Alignment.center,
// value: value,
// child: Text(value),
// );
// }).toList(),
// onChanged: (val) {
// value.statusDropvalue(val);
// },
// value: value.bookingstatusvalue,
// borderRadius: BorderRadius.circular(10),
// icon: Icon(Icons.arrow_drop_down),
// iconEnabledColor: Colors.white,
// dropdownColor: Color(0xbd563c56),
// style: TextStyle(color: Colors.white),
// ),
// ),
