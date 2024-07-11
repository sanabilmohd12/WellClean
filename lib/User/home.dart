import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:wellclean/Constants/customwidgets.dart';
import 'package:wellclean/Constants/my_flutter_icons.dart';
import 'package:wellclean/ModelClass/Model_Class.dart';
import 'package:wellclean/Provider/MainProvider.dart';
import 'package:wellclean/Provider/loginprovider.dart';
import 'package:wellclean/User/ServicePage.dart';

import 'package:wellclean/login.dart';

class homePage extends StatelessWidget {
  final String userId;

  const homePage({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    MainProvider mainprovider =
        Provider.of<MainProvider>(context, listen: false);

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await Future.delayed(Duration(seconds: 2)); // Add a 2-second delay
      await Future.wait([
        mainprovider.getCarousel(),
        mainprovider.getManageservices(),
      ]);
      mainprovider.setLoading(false);
    });


    return Scaffold(
      backgroundColor: Color(0xFFFEF1E2),
      appBar: AppBar(automaticallyImplyLeading: false,
          backgroundColor: Color.fromARGB(255, 101, 25, 113),
          toolbarHeight: 90,
          title: Center(
              child: Text("WellClean",
                  style: TextStyle(
                    color: Color.fromARGB(255, 251, 241, 226),
                  ))),
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
                                        child: Text("Yes",
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
      body: SingleChildScrollView(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // CircleAvatar(radius: 25),
            Padding(
              padding: const EdgeInsets.only(top: 14, bottom: 35),
              child: Consumer<MainProvider>(builder: (context, value, child) {
                return value.isLoading
                    ? _buildShimmerCarousel()
                    :CarouselSlider.builder(
                  itemCount: value.carouselimages.length,
                  itemBuilder: (context, index, realIndex) {
                    return ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.network(
                            value.carouselimages[index].image.toString()));
                  },
                  options: CarouselOptions(
                      autoPlay: true,
                      aspectRatio: 3.0,
                      viewportFraction: 1,
                      enableInfiniteScroll: true,
                      enlargeCenterPage: true,
                      onPageChanged: (index, context) {
                        value.Activeindex(index);
                        // setState(() {
                        //   currentindex = index;
                        // });
                      }),
                );
              }),
            ),
            toplefttext("Available Services"),
            SizedBox(
              width: width / 1.1,
              child: Consumer<MainProvider>(builder: (context, value, child) {
                return value.isLoading
                    ? _buildShimmerGrid()
                    : GridView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: value.ManageServicesmodelclasslist.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8),
                  itemBuilder: (context, index) {
                    ManageServicesmodelclass item =  value.ManageServicesmodelclasslist[index];
                    return InkWell(
                        onTap: () {
                          value.clearSelections();

                          Navigator.push(
                                    context,
                                    MaterialPageRoute(

                                      builder: (context) => servicePage(serviceId: item.id,serviceType: item.name,advance: item.advance, userId: userId),
                                    ));

                          // if (index == 0) {
                          //   Navigator.push(
                          //       context,
                          //       MaterialPageRoute(
                          //         builder: (context) => residentialPage(),
                          //       ));
                          // }
                          // else if (index == 1) {
                          //   Navigator.push(
                          //       context,
                          //       MaterialPageRoute(
                          //         builder: (context) => commercialPage(),
                          //       ));
                          // } else if (index == 2) {
                          //   Navigator.push(
                          //       context,
                          //       MaterialPageRoute(
                          //         builder: (context) => carwashPage(),
                          //       ));
                          // } else if (index == 3) {
                          //   Navigator.push(
                          //       context,
                          //       MaterialPageRoute(
                          //         builder: (context) => otherservicesPage(),
                          //       ));
                          // }
                        },
                        child: serviceGrid(
                            Color(0x5AC957D0
                                // 0x5AF400FF
                                ),
                            item.image
                                .toString(),
                            item.name
                                .toString()));
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
Widget _buildShimmerGrid() {
  return Shimmer.fromColors(
    baseColor: Colors.grey[300]!,
    highlightColor: Colors.grey[100]!,
    child: GridView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: 4,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
      ),
      itemBuilder: (context, index) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
        );
      },
    ),
  );
}
Widget _buildShimmerCarousel() {
  return Shimmer.fromColors(
    baseColor: Colors.grey[300]!,
    highlightColor: Colors.grey[100]!,
    child: Container(
      height: 200,
      width: double.infinity,
      color: Colors.white,
    ),
  );
}