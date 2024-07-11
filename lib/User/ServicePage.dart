import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import 'package:wellclean/Constants/customwidgets.dart';
import 'package:wellclean/ModelClass/Model_Class.dart';
import 'package:wellclean/ModelClass/Model_Class.dart';
import 'package:wellclean/Provider/MainProvider.dart';
import 'package:wellclean/User/checkout.dart';

class servicePage extends StatelessWidget {
  final String serviceId;
  final String serviceType;
  final String advance;
  final String userId;

  const servicePage({super.key, required this.serviceId,required this.serviceType, required this.advance, required this.userId,});

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
      backgroundColor: Color(0xFFFEF1E2),
      appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 101, 25, 113),
          leading: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(CupertinoIcons.back,
                  color: Color.fromARGB(255, 251, 241, 226))),
          toolbarHeight: 70,
          title: Text(serviceType,
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
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            space(),
            toplefttext("Select your Place"),
            // Consumer<MainProvider>(builder: (context, value, child) {
            //   return Container(
            //     width: width / 1.1,
            //     decoration: BoxDecoration(
            //       borderRadius: BorderRadius.circular(15),
            //     ),
            //     child: DropdownButton(
            //       isExpanded: true,
            //       value: value.dropresidencevalue,
            //       icon: Icon(Icons.arrow_drop_down_circle_outlined),
            //       onChanged: (val) {
            //         value.setDropvalue0(val);
            //       },
            //       items: value.dropresidencelist
            //           .map<DropdownMenuItem<String>>((String value) {
            //         return DropdownMenuItem<String>(
            //           value: value,
            //           child: Text(value),
            //         );
            //       }).toList(),
            //       borderRadius: BorderRadius.circular(12),
            //       iconEnabledColor: Color(0xff6a516b),
            //       dropdownColor: Colors.white,
            //       style: TextStyle(
            //           fontSize: 18,
            //           fontWeight: FontWeight.bold,
            //           color: Color(0xff6a516b)),
            //     ),
            //   );
            // }),
            Consumer<MainProvider>(builder: (context, value, child) {
              return Autocomplete<ventureResidencemdlclss>(
                optionsBuilder: (TextEditingValue textEditingValue) {
                  return value.ventureResidence
                      .where((ventureResidencemdlclss item) => item.venturename
                          .toLowerCase()
                          .contains(textEditingValue.text.toLowerCase()))
                      .toList();
                },
                displayStringForOption: (ventureResidencemdlclss option) =>
                    option.venturename,
                fieldViewBuilder: (BuildContext context,
                    TextEditingController fieldTextEditingController,
                    FocusNode fieldFocusNode,
                    VoidCallback onFieldSubmitted) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    fieldTextEditingController.text =
                        value.VentureController.text;
                  });

                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(decoration: BoxDecoration(color:Colors.white,borderRadius: BorderRadius.circular(10)),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width / 1.1,
                        child: TextFormField(
                          cursorColor: Color(0xff6e217a),
                          maxLines: 1,
                          style: const TextStyle(
                              color: Color(0xbd490b49),
                              fontWeight: FontWeight.w500),
                          decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Color(0xbd563c56)),
                                borderRadius: BorderRadius.circular(10)),
                            hintText: "Select One                                                    >",
                            hintStyle: const TextStyle(
                                color: Color(0xbd563c56),
                                fontWeight: FontWeight.bold),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          onChanged: (txt) {},
                          controller: fieldTextEditingController,
                          focusNode: fieldFocusNode,
                        ),
                      ),
                    ),
                  );
                },
                onSelected: (ventureResidencemdlclss selection) {
                  value.VentureController.text = selection.venturename;
                  value.ventureSelectedid = selection.id;
                },
                optionsViewBuilder: (BuildContext context,
                    AutocompleteOnSelected<ventureResidencemdlclss> onSelected,
                    Iterable<ventureResidencemdlclss> options) {
                  return Align(
                    alignment: Alignment.topCenter,
                    child: Material(
                      color: Colors.transparent,
                      child: Container(
                        decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                  color: Color(0xad380038),
                                  spreadRadius: 1,
                                  blurRadius: 1)
                            ],
                            color: Color(0xFFFFFCFF),
                            borderRadius: BorderRadius.circular(10)),
                        width: 200,
                        height: 160,
                        child: ListView.builder(
                          padding: const EdgeInsets.all(10.0),
                          itemCount: options.length,
                          itemBuilder: (BuildContext context, int index) {
                            final ventureResidencemdlclss option =
                                options.elementAt(index);

                            return GestureDetector(
                              onTap: () {
                                onSelected(option);
                              },
                              child: Column(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                        color: Colors.transparent
                                        // border: Border(left: BorderSide(color: Colors.white,width: .6,
                                        // ))
                                        ),
                                    height: 30,
                                    width: 200,
                                    child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Center(
                                            child: Text(option.venturename,
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.black,
                                                )),
                                          ),
                                        ]),
                                  ),
                                  Divider(
                                    thickness: 1,
                                    color: Colors.black,
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  );
                },
              );

              //   Container(
              //   width: width / 1.01,
              //   decoration: BoxDecoration(
              //     borderRadius: BorderRadius.circular(15),
              //   ),
              //   child:
              //
              //
              //
              //   DropdownButton<ventureResidencemdlclss>(
              //     isExpanded: true,
              //     value: value.dropresidencevalue,
              //     icon: Icon(Icons.arrow_drop_down_circle_outlined),
              //     onChanged: (val) {
              //       // value.layerSelection(val!.venturename.toString());
              //       value.setDropvalue0(val);
              //     },
              //     items: value.ventureResidence
              //         .map((ventureResidencemdlclss item) {
              //       return DropdownMenuItem<ventureResidencemdlclss>(
              //         value: item,
              //         child: Text(item.venturename),
              //       );
              //     }).toList(),
              //     borderRadius: BorderRadius.circular(12),
              //     iconEnabledColor: Color(0xff6a516b),
              //     dropdownColor: Colors.white,
              //     style: TextStyle(
              //         fontSize: 18,
              //         fontWeight: FontWeight.bold,
              //         color: Color(0xff6a516b)),
              //     // hint: Icon(Icons.search_rounded),
              //   ),
              // );
            }),

            space(),
            // toplefttext("Type of Cleaning"),
            // Consumer<MainProvider>(builder: (context, value, child) {
            //   return Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //     children: [
            //       Container(
            //         height: 180,
            //         width: 155,
            //         decoration: BoxDecoration(
            //             image: DecorationImage(
            //                 image: AssetImage("assets/type1.png")),
            //             borderRadius: BorderRadius.circular(15)),
            //         child: RadioListTile(
            //             tileColor: Color(0xff5d9296),
            //             shape: RoundedRectangleBorder(
            //                 borderRadius: BorderRadius.circular(15)),
            //             selectedTileColor: Color(0xff0f4350),
            //             // selected: true,
            //             // selected: value.radioselectvalue,
            //             value: 1,
            //             groupValue: value.residentialradiotypevalue,
            //             onChanged: (val) {
            //               value.radiovalue0(val);
            //             },
            //             activeColor: Color(0xFFFFF1E2)),
            //       ),
            //       Container(
            //         height: 180,
            //         width: 155,
            //         decoration: BoxDecoration(
            //             image: DecorationImage(
            //                 image: AssetImage("assets/type2.png")),
            //             borderRadius: BorderRadius.circular(15)),
            //         child: RadioListTile(
            //           tileColor: Color(0xff5d9296),
            //           shape: RoundedRectangleBorder(
            //               borderRadius: BorderRadius.circular(15)),
            //           selectedTileColor: Color(0xff0f4350),
            //           // selected: value.radioselectvalue,
            //           // selected: true ,
            //
            //           value: 0,
            //           groupValue: value.residentialradiotypevalue,
            //           onChanged: (val) {
            //             value.radiovalue0(val);
            //           },
            //           activeColor: Color(0xFFFFF1E2),
            //         ),
            //       ),
            //     ],
            //   );
            // }),
            // space(),
            toplefttext("Services"),
            Consumer<MainProvider>(builder: (context, value, child) {
              return ListView.builder(
                  padding: EdgeInsets.zero,
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: value.ResidenceCTypemodelclasslist.length,
                  itemBuilder: (context, index) {
                    bool isSelected = value.getCheckboxValue(index);
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 5.0, horizontal: 12),
                      child: CheckboxListTile(
                        contentPadding: EdgeInsets.zero,
                        dense: true,
                        tileColor: Colors.white,
                        title: Text(
                            value.ResidenceCTypemodelclasslist[index].name
                                .toString(),
                            style: TextStyle(
                                fontWeight: FontWeight.w300, fontSize: 17)),
                        secondary: Container(
                          height: 48,
                          width: 48,
                          decoration: ShapeDecoration(
                              color: value.servlistContainercolor[index],
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              image: DecorationImage(
                                  image: NetworkImage(value
                                      .ResidenceCTypemodelclasslist[index].image
                                      .toString()))),
                          // child: Image.network(
                          //     value.ResidenceCTypemodelclasslist[index].image.toString())
                        ),
                        checkboxShape: CircleBorder(),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        selectedTileColor: value.servlistselectcolor[index],
                        activeColor: Color(0xbd380038),
                        selected: isSelected,
                        value: isSelected,
                        onChanged: (bool? newValue) {
                          value.setCheckboxValue(index, newValue ?? false);
                        },
                      ),
                    );
                  });
            }),
            space(),
          Consumer<MainProvider>(
            builder: (context,value,child) {
              return Shimmer(
                duration: const Duration(seconds: 1), //Default value
                interval: const Duration(seconds: 2),
                color: Colors.white,
                colorOpacity: 0.3, //Default value
                enabled: true, //Default value
                direction: ShimmerDirection.fromLeftToRight(),
                child: ElevatedButton(
                  style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(Color(0xff750475)),
                    shape: MaterialStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),),
                    fixedSize: MaterialStatePropertyAll(Size(190, 40)),
                    // shadowColor: MaterialStatePropertyAll(Color(0xBD000000)),
                  ),
                  onPressed: () {

                    List<ResidenceCTypemodelclass> selectedServices = value.getSelectedServices();

                    String selectedVenture = value.VentureController.text;
                    String selectedVentureId = value.ventureSelectedid;

                    if (selectedVenture.isNotEmpty && selectedServices.isNotEmpty) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => checkoutPage(
                            selectedServices: selectedServices,
                            selectedVenture: selectedVenture,
                            selectedVentureId: selectedVentureId,
                            serviceId: serviceId,
                            serviceType: serviceType,
                            advance: advance, userId: userId,
                          ),
                        ),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Please select a venture and at least one service')),
                      );
                    }
                  },
                  child: Center(
                      child: Text(
                        "Continue",
                        style: TextStyle(color: Color(0xFFFEF1E2), fontSize: 15),
                      )),
                ),
              );
            }
          ),
            // buttons(Color(0xff750475), "Continue", context, checkoutPage()),
            space()
          ],
        ),
      ),
    );
  }
}
