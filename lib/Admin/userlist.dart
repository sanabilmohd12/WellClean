import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wellclean/Provider/MainProvider.dart';

class userlistPage extends StatelessWidget {
  const userlistPage({super.key});

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
          title: Text("User List",
              style: TextStyle(
                color: Color.fromARGB(255, 251, 241, 226),
              )),
          centerTitle: true,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(15),
                  bottomRight: Radius.circular(15)))),
      body: SingleChildScrollView(
        child: Consumer<MainProvider>(builder: (context, value, child) {
          return ListView.builder(
            shrinkWrap: true,
            physics: ScrollPhysics(),
            itemCount: 1,
            itemBuilder: (context, index) {
              return Container(
                margin: EdgeInsets.all(10),
                height: height / 5,
                width: width / 1.2,
                decoration: BoxDecoration(
                  border: Border.all(width: 2, color: Color(0xbd380038)),
                  color: Color(
                    0xe6a388a8,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(children: [
                    Padding(
                      padding: const EdgeInsets.all(5),
                      child: Row(
                        children: [
                          Text(
                            "Name :",
                            style: TextStyle(
                              color: Color(0xffFEF1E2),
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Text(
                            value.UserDetails[index].username.toString(),
                            style: TextStyle(
                              color: Color(0xffFEF1E2),
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5),
                      child: Row(
                        children: [
                          Text(
                            "Phone :",
                            style: TextStyle(
                              color: Color(0xffFEF1E2),
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Text(
                            value.UserDetails[index].Number.toString(),
                            style: TextStyle(
                              color: Color(0xffFEF1E2),
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [Icon(Icons.delete,color: Colors.red,size: 30,)],
                    ),
                  ]),
                ),
              );
            },
          );
        }),
      ),
    );
  }
}
