import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wellclean/Admin/addManageServices.dart';
import 'package:wellclean/Admin/addPageDetails.dart';
import 'package:wellclean/Constants/customwidgets.dart';
import 'package:wellclean/ModelClass/Model_Class.dart';
import 'package:wellclean/Provider/MainProvider.dart';

class manageServices extends StatelessWidget {

  const manageServices({super.key});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    MainProvider mainprovider =
        Provider.of<MainProvider>(context, listen: false);

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      mainprovider.getManageservices();
    });
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
          title: Text("Manage Services",
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
            Center(
              child: SizedBox(
                width: width / 1.1,
                child: Consumer<MainProvider>(builder: (context, value, child) {
                  return GridView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: value.ManageServicesmodelclasslist.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 20),
                    itemBuilder: (context, index) {
                      ManageServicesmodelclass item =  value.ManageServicesmodelclasslist[index];
                      return
                          //   serviceGrid(
                          //     Color(0x5AC957D0),
                          //     value.ManageServicesmodelclasslist[index].image
                          //         .toString(),
                          //     value.ManageServicesmodelclasslist[index].name
                          //         .toString())
                          // ;
                          GestureDetector(onTap: () {
                            // value.clearVentureController();
                            // value.getVentures(serviceId);

                            Navigator.push(context, MaterialPageRoute(builder: (context) => addPageDetails(serviceId: item.id,),));
                          },
                            child: Container(
                        child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.network(
                                  item.image
                                      .toString(),
                                  scale: 12,
                                ),
                                Text(
                                  item.name
                                      .toString(),
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                      color: Color(0xFFFFF1E2)),
                                ),
                                Row(mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    InkWell(
                                    onTap:() {
                                      value.deleteManageservices(item.id, context);
                                    },
                                        child: Icon(Icons.delete_rounded,color: Colors.red)),
                                  ],
                                )
                              ]),
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
                            color: Color(0x5AC957D0),
                        ),
                      ),
                          );
                    },
                  );
                }),
              ),
            ),
            space(),
            Consumer<MainProvider>(
              builder: (context, value, child) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => addManageSerices(),
                        ));
                    value.clearManageServiceController();
                  },
                  child: Container(
                    width: width / 1.7,
                    height: 60,
                    child: Center(
                      child: ListTile(
                        contentPadding: EdgeInsets.only(left: 20, right: 20),
                        tileColor: Color(0xbdffffff),
                        shape: RoundedRectangleBorder(
                            side: BorderSide(color: Color(0xbd563c56)),
                            borderRadius: BorderRadius.circular(6)),
                        title: Text("Add New Service",
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
          ],
        ),
      ),
    );
  }
}
