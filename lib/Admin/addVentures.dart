import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wellclean/Constants/customwidgets.dart';
import 'package:wellclean/Provider/MainProvider.dart';

class addVentures extends StatelessWidget {
  final String serviceId;
  const addVentures({super.key,required this.serviceId});



  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Color(0xff651971),
      appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 101, 25, 113),
          toolbarHeight: 70,
          title: Text("Residence",
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

          Center(child: space()),
          Consumer<MainProvider>(
              builder: (context, value, child) {

                return Container(
                  width: 250,
                  height: 58,
                  decoration: ShapeDecoration(
                      color: Color(0xffffffff),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6))),
                  child: TextFormField(textAlign: TextAlign.center,
                      controller: value.VentureController,
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
                  value.addVentures(serviceId);
                  Navigator.pop(context);
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
    );
  }
}
