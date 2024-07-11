import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wellclean/Provider/MainProvider.dart';

class addCarousel extends StatelessWidget {
  const addCarousel({super.key});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Color(0xff651971),
      appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 101, 25, 113),
          toolbarHeight: 70,
          title: Text("Carousel",
              style: TextStyle(fontSize: 18,
                color: Color.fromARGB(255, 251, 241, 226),
              )),
          centerTitle: true,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(15),
                  bottomRight: Radius.circular(15)))),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
              child: Consumer<MainProvider>(
                builder: (context,value,child) {
                  return GestureDetector(
                    onTap: (){
                      showBottomSheet(
                        context,
                      );
                    },
                    child:value.carouselfileimg!=null? Container(
                      width: 340,
                      height: 150,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12), color: Colors.white24),
                      child: Image.file(value.carouselfileimg!)
                    ):Container(
            width: 340,
            height: 150,
            decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12), color: Colors.white),
                      child: Icon(Icons.add_box_rounded,color: Color(0xff6a516b)),
          ),
                  );
                }
              )),
          Consumer<MainProvider>(
            builder: (context,value,child) {
              return Padding(
                padding: const EdgeInsets.all(58.0),
                child: GestureDetector(
                  onTap: (){
                    value.addcarousel();
                    Navigator.pop(context);

                  },
                  child: Container(
                    width: width / 4.6,
                    height: 50,decoration: ShapeDecoration(color: Color(0xffffffff),shape: RoundedRectangleBorder(
                      side: BorderSide(color: Color(0xbd563c56)),
                      borderRadius: BorderRadius.circular(6)),
                  ),
                    child: Center(
                      child: Text("Done",
                          style: TextStyle(
                              color: Color(0xbd563c56),
                              fontWeight: FontWeight.bold,
                              fontSize: 16.3)),
                    ),
                  ),
                ),
              );
            }
          ),
        ],
      ),
    );
  }
}

void showBottomSheet(BuildContext context) {
  showModalBottomSheet(
      elevation: 10,
      backgroundColor: Color(0xFFFFF1E2),
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10.0),
            topRight: Radius.circular(10.0),
          )),
      context: context,
      builder: (BuildContext bc) {
        return Consumer<MainProvider>(
          builder: (context,value,child) {
            return Container(height: 120,
              child: Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Column(children: [
                  InkWell(onTap: () {
                    value.getImagegallery();
                    Navigator.pop(context);

                  },
                    child: ListTile(
                      leading: Icon(Icons.image,color: Color(0xbd4b284b),size: 25),
                      title: Text("Gallery",style: TextStyle(color: Color(0xbd4b284b),fontSize: 20))
                      ,),
                  ) ,
                  InkWell(onTap: () {
                    value.getImagecamera();
                    Navigator.pop(context);
                  },
                    child: ListTile(
                      leading: Icon(Icons.camera,color: Color(0xbd4b284b),size: 25),
                      title: Text("Camera",style: TextStyle(color: Color(0xbd4b284b),fontSize: 20))
                      ,),
                  )
                ],),
              ),
            );
          }
        );
      });
  //ImageSource
}
