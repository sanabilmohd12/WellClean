import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wellclean/Constants/customwidgets.dart';
import 'package:wellclean/Provider/MainProvider.dart';

class addCTypes extends StatelessWidget {
  final String serviceId;

  const addCTypes({super.key,required this.serviceId});



  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;


    return Scaffold(
      backgroundColor: Color(0xff651971),
      appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 101, 25, 113),
          toolbarHeight: 70,
          title: Text("Residence Cleaning Type",
              style: TextStyle(fontSize: 18,
                color: Color.fromARGB(255, 251, 241, 226),
              )),
          centerTitle: true,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(15),
                  bottomRight: Radius.circular(15)))),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            space(),
            Center(
                child: Consumer<MainProvider>(builder: (context, value, child) {
                  return GestureDetector(
                    onTap: () {
                      showBottomSheet(
                        context,
                      );
                    },
                    child: value.ResidenceCTypefileimg != null? Container(
                        width: 340,
                        height: 150,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Colors.white24),
                        child: Image.file(value.ResidenceCTypefileimg!))
                        : Container(
                      width: 150,
                      height: 150,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.white),
                      child:
                      Icon(Icons.add_box_rounded, color: Color(0xff6a516b)),
                    ),
                  );
                })),
            space(),
            Consumer<MainProvider>(
                builder: (context, value, child) {

                  return Container(
                    width: 200,
                    height: 58,
                    decoration: ShapeDecoration(
                        color: Color(0xffffffff),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6))),
                    child: TextFormField(textAlign: TextAlign.center,
                        controller: value.ResidenceCTypeNameController,
                        keyboardType: TextInputType.name,
                        onEditingComplete: () => FocusScope.of(context).unfocus(),
                        decoration: InputDecoration(
                            hintText: "Enter here",
                            hintStyle: TextStyle(
                              color: Color(0xBC6B526B),
                              fontSize: 15,

                            ),
                            // labelText: "labeltext",
                            // floatingLabelStyle: TextStyle(
                            //   fontSize: 17,
                            //   fontWeight: FontWeight.bold,
                            // ),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0xBC6B526B),
                              ),
                              borderRadius: BorderRadius.circular(6),
                            ))),
                  );
                }
            ),
            Consumer<MainProvider>(builder: (context, value, child) {
              return Padding(
                padding: const EdgeInsets.all(58.0),
                child: GestureDetector(
                  onTap: () {
                    value.addCType(serviceId);
                    Navigator.pop(context);
                    value.getCType(serviceId);
                    // value.clearResidenceCTypeController();

                  },
                  child: Container(
                    width: width / 4.6,
                    height: 40,
                    decoration: ShapeDecoration(
                      color: Color(0xffffffff),
                      shape: RoundedRectangleBorder(
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
            }),
          ],
        ),
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
        return Consumer<MainProvider>(builder: (context, value, child) {
          return Container(
            height: 120,
            child: Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Column(
                children: [
                  InkWell(
                    onTap: () {
                      value.ResidenceCTypegetImagegallery();
                      Navigator.pop(context);
                    },
                    child: ListTile(
                      leading:
                      Icon(Icons.image, color: Color(0xbd4b284b), size: 25),
                      title: Text("Gallery",
                          style: TextStyle(
                              color: Color(0xbd4b284b), fontSize: 20)),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      value.ResidenceCTypegetImagecamera();
                      Navigator.pop(context);
                    },
                    child: ListTile(
                      leading: Icon(Icons.camera,
                          color: Color(0xbd4b284b), size: 25),
                      title: Text("Camera",
                          style: TextStyle(
                              color: Color(0xbd4b284b), fontSize: 20)),
                    ),
                  )
                ],
              ),
            ),
          );
        });
      });
  //ImageSource
}
