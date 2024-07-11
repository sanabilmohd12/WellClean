import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wellclean/Admin/addCTypes.dart';
import 'package:wellclean/Admin/addVentures.dart';
import 'package:wellclean/Constants/customwidgets.dart';
import 'package:wellclean/Provider/MainProvider.dart';

class addPageDetails extends StatelessWidget {
  final String serviceId;
  const addPageDetails({super.key,required this.serviceId});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    MainProvider mainprovider =
    Provider.of<MainProvider>(context, listen: false);

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      mainprovider.getVentures(serviceId);
      mainprovider.getCType(serviceId);
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
        child: Column(mainAxisAlignment: MainAxisAlignment.center,
          children: [
            space(),
            toplefttext("Ventures"),
            Consumer<MainProvider>(builder: (context, value, child) {
              return ListView.builder(
                padding: EdgeInsets.zero,
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: value.ventureResidence.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: ListTile(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                      tileColor: Color(0xff563c56),
                      title: Text(value.ventureResidence[index].venturename.toString(),
                          style: TextStyle(color: Color(0xffffffff),
                              fontSize: 18, fontWeight: FontWeight.bold)),
                      trailing: IconButton(onPressed: () {
                        value.deleteVentures(serviceId,
                            value.ventureResidence[index].id,
                            context);

                      }, icon: Icon(Icons.delete_outline_rounded,color: Colors.red,)),
                    ),
                  );
                },
              );
            }),
            GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => addVentures(serviceId: serviceId,),));

              },
              child: Container(
                width: width / 3.1,
                height: 60,
                child: Center(
                  child: ListTile(
                    contentPadding: EdgeInsets.only(left: 20, right: 20),
                    tileColor: Color(0xbdffffff),
                    shape: RoundedRectangleBorder(
                        side: BorderSide(color: Color(0xbd563c56)),
                        borderRadius: BorderRadius.circular(6)),
                    title: Text("Add",
                        style: TextStyle(
                            color: Color(0xbd563c56),
                            fontWeight: FontWeight.bold,
                            fontSize: 14.3)),
                    trailing: Icon(Icons.add_box_rounded,
                        color: Color(0xbd563c56), size: 30),
                  ),
                ),
              ),
            ),
            space(),

            Divider(endIndent: 1,indent: 1,color: Colors.black87,height: 2),
            space(),

            toplefttext("Cleaning Types"),
            Consumer<MainProvider>(builder: (context, value, child) {
              return ListView.builder(
                padding: EdgeInsets.zero,
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: value.ResidenceCTypemodelclasslist.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: ListTile(
                      contentPadding: EdgeInsets.zero,
                      dense: true,
                      tileColor: Colors.white,
                      title: Text(value.ResidenceCTypemodelclasslist[index].name.toString(),
                          style: TextStyle(
                              fontWeight: FontWeight.w300, fontSize: 17)),
                      leading: Container(
                        height: 48,
                        width: 48,
                        decoration: ShapeDecoration(
                            color: value.servlistContainercolor[index],
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            image: DecorationImage(image: NetworkImage(value.ResidenceCTypemodelclasslist[index].image.toString()))
                        ),
                        // child: Image.network(
                        //     value.ResidenceCTypemodelclasslist[index].image.toString())
                      ),
                      trailing: IconButton(onPressed: () {
                        value.deleteCType(serviceId,value.ResidenceCTypemodelclasslist[index].id, context);

                      }, icon: Icon(Icons.delete_outline_rounded,color: Colors.red,)),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),

                    ),
                  );
                },
              );
            }),
            Consumer<MainProvider>(
                builder: (context, value, child) {

                  return GestureDetector(onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => addCTypes(serviceId: serviceId,),));
                    value.clearResidenceCTypeController();
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
            space(),
          ],
        ),
      ),
    );
  }
}
