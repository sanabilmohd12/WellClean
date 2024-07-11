import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wellclean/Admin/addCarousel.dart';
import 'package:wellclean/Constants/customwidgets.dart';
import 'package:wellclean/Provider/MainProvider.dart';

class carouselPage extends StatelessWidget {
  const carouselPage({super.key});

  @override
  Widget build(BuildContext context) {
    MainProvider mainprovider =
    Provider.of<MainProvider>(context, listen: false);

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      mainprovider.getCarousel();
    });
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
          title: Text("Carousel",
              style: TextStyle(
                color: Color.fromARGB(255, 251, 241, 226),
              )),
          centerTitle: true,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(15),
                  bottomRight: Radius.circular(15)))),
      body: SingleChildScrollView(
        child: Column(
          children: [
            space(),
            Consumer<MainProvider>(builder: (context, value, child) {
              return ListView.builder(
                padding: EdgeInsets.zero,
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: value.carouselimages.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: Container(
                      width: width / 2,
                      height: 120,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              fit: BoxFit.scaleDown,
                              image: NetworkImage(value
                                  .carouselimages[index].image
                                  .toString()))),
                      child: Row(mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                              onPressed: () {
                                value.deleteCarousel(value.carouselimages[index].id, context);
                              },
                              icon: Icon(
                                Icons.delete_outline_rounded,
                                color: Colors.red,
                              )),
                        ],
                      ),
                    ),
                  );
                },
              );
            }),
            Consumer<MainProvider>(
              builder: (context, value, child) {

                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => addCarousel(),
                        ));
                    value.clearCarouselpick();
                  },
                  child: Container(
                    width: width / 1.6,
                    height: 60,
                    child: Center(
                      child: ListTile(
                        contentPadding: EdgeInsets.only(left: 20, right: 20),
                        tileColor: Color(0xbdffffff),
                        shape: RoundedRectangleBorder(
                            side: BorderSide(color: Color(0xbd563c56)),
                            borderRadius: BorderRadius.circular(6)),
                        title: Text("Add New Image",
                            style: TextStyle(
                                color: Color(0xbd563c56),
                                fontWeight: FontWeight.bold,
                                fontSize: 14.3)),
                        trailing: Icon(Icons.add_box_rounded,
                            color: Color(0xbd563c56), size: 30),
                      ),
                    ),
                  ),
                );
              }
            ),
            space(),
          ],
        ),
      ),
    );
  }
}
