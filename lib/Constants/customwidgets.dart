import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

//loginforms
Widget logininput(
  IconData icn,
  String labeltext,
  TextInputType number,
    TextEditingController controller
) {
  return SizedBox(
    width: 300,
    height: 48,
    child: TextFormField( controller: controller,
        keyboardType: number,
        decoration: InputDecoration(
            floatingLabelStyle: TextStyle(color: Color(0xbd380038)),
            prefixIcon: Icon(icn),
            hintText: "Type Here",
            hintStyle: TextStyle(
              color: Color(0xBC6B526B),
              fontSize: 10,
            ),
            labelText: labeltext,

            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Color(0xff730083))),
            border: OutlineInputBorder(
              borderSide: BorderSide(
                width: 10,
                color: Color(0xBC6B526B),
              ),
              borderRadius: BorderRadius.circular(6),
            ))),
  );
} //loginform

//loginbuttons
Widget Loginbuttons(Color btnclr, String btntxt) {
  return Container(
    width: 190,
    height: 30,
    decoration: ShapeDecoration(
        color: btnclr,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
        shadows: [
          BoxShadow(
              spreadRadius: 0.4,
              blurRadius: 2,
              offset: Offset(1.5, 1.5),
              color: Color(0xBD000000))
        ]),
    child: Center(
        child: Text(
      btntxt,
      style: TextStyle(color: Color(0xFFFEF1E2), fontSize: 15),
    )),
  );
} //loginbuttons
// Color(0xFFFEF1E2)

// /buttonnsss
Widget buttons(Color btnclr, String btntxt, BuildContext context, Widget page) {
  return Shimmer(
    duration: const Duration(seconds: 1), //Default value
    interval: const Duration(seconds: 2),
    color: Colors.white,
    colorOpacity: 0.3, //Default value
    enabled: true, //Default value
    direction: ShimmerDirection.fromLeftToRight(),
    child: ElevatedButton(
      style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(btnclr),
        shape: MaterialStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),),
        fixedSize: MaterialStatePropertyAll(Size(190, 40)),
        // shadowColor: MaterialStatePropertyAll(Color(0xBD000000)),
      ),
      onPressed: () {

        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => page,
            ));
      },
      child: Center(
          child: Text(
            btntxt,
            style: TextStyle(color: Color(0xFFFEF1E2), fontSize: 15),
          )),
    ),
  );
} //l
// / /buttonnsss
//loginbottom
Widget bottomtext(String txt1, String txt2) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text(
        txt1,
        style: TextStyle(
            fontSize: 12,
            color: Color(0xBC6B526B),
            fontWeight: FontWeight.w500),
      ),
      Text(
        txt2,
        style: TextStyle(
            fontSize: 12,
            color: Color(0xBF0D8D9F),
            fontWeight: FontWeight.w600),
      ),
    ],
  );
} //loginbottom

Widget serviceGrid(Color gridclr, String gridimage, String gridname) {
  return Container(
    child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Image.network(
        gridimage,
        scale: 10,
      ),
      Padding(
        padding: const EdgeInsets.only(bottom: 20.0),
        child: Text(
          gridname,
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
              color: Color(0xFFFFF1E2)),
        ),
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
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        color: gridclr),
  );
} //services grid

Widget admingrid(Color gridclr, String gridimage, String gridname) {
  return Container(
    child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Image.asset(
        gridimage,
        scale: 5,
      ),
      Padding(
        padding: const EdgeInsets.only(bottom: 20.0),
        child: Text(
          gridname,
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
              color: Color(0xBF00515D)),
        ),
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
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        color: gridclr),
  );
} //admingrid

Widget serviceList(
    double leadwidth, String imgnamelist, Color leadclr, String titlename) {
  return ListTile(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
    tileColor: Colors.white,
    leading: Container(
        width: leadwidth,
        child: Center(
            child: Image.asset(
          imgnamelist,
          scale: 5,
        )),
        decoration: BoxDecoration(
            color: leadclr, borderRadius: BorderRadius.circular(15))),
    title: Text(titlename),
  );
} //servielisttile

Widget toplefttext(String textto) {
  return Padding(
    padding: EdgeInsets.only(left: 18, bottom: 8),
    child: Row(
      children: [
        Text(textto,
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF6B526B))),
      ],
    ),
  );
}

Widget space() {
  return SizedBox(height: 40);
}

// Widget servchecklisttile( String servname,String servimage,Color selectedclr,bool selectedvalue,bool valuee , onchangevalue(val)){
//   return Padding(
//     padding: const EdgeInsets.symmetric(
//         vertical: 5.0, horizontal: 12),
//     child: CheckboxListTile(
//       contentPadding: EdgeInsets.zero,
//       dense: true,
//       tileColor: Colors.white,
//       title: Text(servname,
//           style: TextStyle(
//               fontWeight: FontWeight.w300, fontSize: 17)),
//       secondary: Image.asset(servimage),
//       checkboxShape: CircleBorder(),
//       shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(15)),
//       selectedTileColor: selectedclr,
//       activeColor: Color(0xbd380038),
//       selected: selectedvalue,
//       value: valuee,
//       onChanged: (val) {
//         onchangevalue(val);
//       },
//     ),
//   );
// }

//loginforms
Widget adressinput(
  String hinttext,
  String labeltext,
  TextInputType number,
    TextEditingController controller,BuildContext context
) {
  return SizedBox(
    width: 300,
    height: 48,
    child: TextFormField(
        onEditingComplete: () => FocusScope.of(context).nextFocus(),
        controller: controller,
        keyboardType: number,
        autofocus: true,
        decoration: InputDecoration(
            hintText: hinttext,
            hintStyle: TextStyle(
              color: Color(0xBC6B526B),
              fontSize: 15,
            ),
            labelText: labeltext,
            floatingLabelStyle: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
            ),
            border: OutlineInputBorder(
              borderSide: BorderSide(
                color: Color(0xBC6B526B),
              ),
              borderRadius: BorderRadius.circular(6),
            ))),
  );
}

void showBottomSheet(BuildContext context) {
  showModalBottomSheet(
      elevation: 100,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
        topLeft: Radius.circular(10.0),
        topRight: Radius.circular(10.0),
      )),
      context: context,
      builder: (BuildContext bc) {
        return Wrap(
          children: <Widget>[
            // ListTile(
            //     leading:  Icon(
            //       Icons.camera_enhance_sharp,
            //       color: Color(0xffeeb2f7),
            //     ),
            //     title: const Text('Camera',),
            //     onTap: () => {laundryprovider.getImagecamera(), Navigator.pop(context)}),
            ListTile(
              leading: Icon(Icons.photo, color: Color(0xffeeb2f7)),
              title: const Text(
                'Gallery',
              ),
            ),
          ],
        );
      });
  //ImageSource
}



