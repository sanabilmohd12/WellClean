import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import 'package:wellclean/Constants/customwidgets.dart';
import 'package:wellclean/ModelClass/Model_Class.dart';
import 'package:wellclean/Provider/MainProvider.dart';
import 'package:wellclean/User/addaddress.dart';

class editProfile extends StatelessWidget {
  final String userId;
  const editProfile({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    MainProvider mainprovider =
        Provider.of<MainProvider>(context, listen: false);

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      mainprovider.getAddressesFunction(userId);
    });
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
          title: Text("Edit Profile",
              style: TextStyle(
                color: Color.fromARGB(255, 251, 241, 226),
              )),
          centerTitle: true,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(15),
                  bottomRight: Radius.circular(15)))),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // space(),
              // Container(
              //   height: 125,
              //   width: 125,
              //   decoration: ShapeDecoration(
              //       color: Color(0xffe4b3ee),
              //       shape: RoundedRectangleBorder(
              //           borderRadius: BorderRadius.circular(100))),
              // ),
              // space(),
              // adressinput("Type here", "UserName", TextInputType.name),
              space(),
              Consumer<MainProvider>(builder: (context, value, child) {
                return value.userAddresses.isNotEmpty?ListView.builder(
                  padding: EdgeInsets.zero,
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: value.userAddresses.length,
                  itemBuilder: (context, index) {
                    UserAddressmodelclass address = value.userAddresses[index];

                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 5.0, horizontal: 12),
                      child: Container(
                        width: width / 1.1,
                        height: height / 4,
                        decoration: ShapeDecoration(
                            shadows: [
                              BoxShadow(
                                  blurRadius: 5,
                                  spreadRadius: 0.1,
                                  offset: Offset(2, 5),
                                  color: Colors.black26)
                            ],
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)),
                            color: Color(0xbd563c56)),
                        child: Padding(
                          padding: EdgeInsets.only(left: 30),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 20.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      address.username,
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xfffff1e2)),
                                    ),
                                    Text(
                                      address.useraddress,
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xfffff1e2)),
                                    ),
                                    Text(
                                      address.mobilenumber,
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xfffff1e2)),
                                    ),
                                    Text(
                                      address.district,
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xfffff1e2)),
                                    ),
                                    Text(
                                      address.state,
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xfffff1e2)),
                                    ),
                                    Text(
                                      address.pincode,
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xfffff1e2)),
                                    ),
                                  ],
                                ),
                              ),
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding:  EdgeInsets.only(left: 50.0),
                                    child: IconButton(
                                        onPressed: () {
                                          value.deleteAddressFunction(
                                              address.addressId, context);
                                          value.getAddressesFunction(userId);
                                        },
                                        icon: Icon(
                                          Icons.delete,
                                          color: Colors.red,
                                        )),
                                  ),
                                  Row(
                                    children: [
                                      if (address.isDefault)
                                        Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: Shimmer(
                                            duration: const Duration(
                                                seconds: 1), //Default value
                                            interval:
                                                const Duration(seconds: 2),
                                            color: Colors.white,
                                            colorOpacity: 0.3, //Default value
                                            enabled: true, //Default value
                                            direction: ShimmerDirection
                                                .fromLeftToRight(),
                                            child: Container(
                                              height: height / 21,
                                              width: width / 4.2,
                                              decoration: ShapeDecoration(
                                                shadows: [
                                                  BoxShadow(
                                                      blurRadius: 5,
                                                      spreadRadius: 0.1,
                                                      offset: Offset(2, 5),
                                                      color: Colors.black26)
                                                ],
                                                color: Color(0xff750475),

                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(6),
                                                ),
                                              ),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  Text(
                                                    "Default",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color:
                                                            Color(0xFFFEF1E2),
                                                        fontSize: 13),
                                                  ),
                                                  Icon(Icons.check_circle,
                                                      color: Colors.green,
                                                      size: 20),
                                                ],
                                              ),
                                            ),
                                          ),
                                        )
                                      else
                                        Padding(
                                          padding: EdgeInsets.only(bottom: 5.0,right: 10),
                                          child: Shimmer(
                                            duration: const Duration(
                                                seconds: 1), //Default value
                                            interval:
                                            const Duration(seconds: 2),
                                            color: Color(0xff750475),
                                            colorOpacity: 0.3, //Default value
                                            enabled: true, //Default value
                                            direction: ShimmerDirection
                                                .fromLeftToRight(),
                                            child:  TextButton(
                                                onPressed: () =>
                                                    value.setDefaultAddress(
                                                        address.addressId),
                                                style: ButtonStyle(
                                                    overlayColor:
                                                        MaterialStatePropertyAll(
                                                            Color(0xff750475)),
                                                    elevation:
                                                        MaterialStatePropertyAll(
                                                            1),
                                                    fixedSize:
                                                        MaterialStatePropertyAll(
                                                            Size(85, 10)),
                                                    backgroundColor:
                                                        MaterialStatePropertyAll(
                                                            Color(0xffffffff)),
                                                    shape: MaterialStatePropertyAll(
                                                        RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius.circular(6)))),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: [
                                                    Text(
                                                      "Change",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color:
                                                              Color(0xff750475),
                                                          fontSize: 13),
                                                    ),
                                                    Icon(
                                                        Icons
                                                            .check_circle_outline,
                                                        color: Color(0xff750475),
                                                        size: 20),
                                                  ],
                                                )),
                                          ),
                                        )
                                    ],
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ):Text("No Address found");
              }),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => addAddress(
                        userId: userId,
                      )));
        },
        child: Icon(Icons.add_box_rounded, color: Colors.white, size: 30),
        backgroundColor: Color(0x5AF400FF),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      ),
    );
  }
}
