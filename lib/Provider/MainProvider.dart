import 'dart:collection';
import 'dart:developer';
import 'dart:ffi';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wellclean/ModelClass/Model_Class.dart';

import 'package:wellclean/User/addaddress.dart';
import 'package:wellclean/User/bookings.dart';
import 'package:wellclean/User/home.dart';

class MainProvider extends ChangeNotifier {
  Reference ref = FirebaseStorage.instance.ref("IMAGEURL");
  FirebaseFirestore db = FirebaseFirestore.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  List<Booking> _allBookings = [];

  List<Booking> get allBookings => _allBookings;

  MainProvider() {
    _listenToBookings();
  }
  void _listenToBookings() {
    _firestore.collection('BOOKINGS').snapshots().listen((snapshot) {
      _allBookings = snapshot.docs
          .map((doc) => Booking.fromMap(doc.data() as Map<String, dynamic>))
          .toList();
      notifyListeners();
    });
  }


  Stream<List<Booking>> get bookingsStream {
    return _firestore.collection('BOOKINGS').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => Booking.fromMap(doc.data() as Map<String, dynamic>)).toList();
    });
  }

  Future<void> addBooking(Booking booking) async {
     String id= DateTime.now().millisecondsSinceEpoch.toString();
    try {
      await _firestore.collection('BOOKINGS').doc(id).set(booking.toMap());
      // No need to call notifyListeners() here as the listener will handle it
    } catch (e) {
      print('Error adding booking: $e');
      throw e;
    }
  }

  Future<List<Booking>> getUserBookings(String uid) async {
    try {
      print('Fetching bookings for user: $uid');

      QuerySnapshot querySnapshot = await _firestore
          .collection('BOOKINGS')
          .where('userId', isEqualTo: uid)
          .get();

      print('Number of bookings found: ${querySnapshot.docs.length}');

      List<Booking> bookings = querySnapshot.docs
          .map((doc) {
        try {
          return Booking.fromMap(doc.data() as Map<String, dynamic>);
        } catch (e) {
          print('Error parsing booking document: $e');
          return null;
        }
      })
          .where((booking) => booking != null)
          .cast<Booking>()
          .toList();

      print('Number of valid bookings: ${bookings.length}');
      return bookings;
    } catch (e) {
      print('Error getting user bookings: $e');
      throw e;
    }
  }

  Future<void> updateBookingStatus(String bookingId, String newStatus) async {
    try {
      await _firestore.collection('BOOKINGS').doc(bookingId).update({
        'status': newStatus,
      });
    } catch (e) {
      print('Error updating booking status: $e');
      throw e;
    }
  }

  String dropdown ="Pending";

  final List<String> statusOptions = ['Pending', 'Confirmed', 'In Progress', 'Completed', 'Cancelled'];

  void statuschange(var value ){
    dropdown =value;
    notifyListeners();
  }



  void bookingstatus(String id){
    print("fvfvf"+id);
    Map<String ,dynamic> map = HashMap();
    map["status"]=dropdown;
    db.collection("BOOKINGS").doc(id).update(map);
    notifyListeners();
  }


//login

  TextEditingController usernameController = TextEditingController();
  TextEditingController usernumberController = TextEditingController();

  void addUser() {
    String id = DateTime.now().millisecondsSinceEpoch.toString();
    HashMap<String, dynamic> map = HashMap();
    map["User_Id"] = id;
    map["User_Name"] = usernameController.text;
    map["User_Number"] = usernumberController.text;
    map["Type"] = "USER";
    db.collection("UserList").doc(id).set(map);
    db.collection("USERS").doc(id).set(map);
    getUser();
    notifyListeners();
  }

  List<usermodelclass> UserDetails = [];

  void getUser() {
    db.collection("USERS").get().then((value) {
      if (value.docs.isNotEmpty) {
        UserDetails.clear();
        for (var element in value.docs) {
          UserDetails.add(
            usermodelclass(
              element.id,
              element.get("User_Name").toString(),
              element.get("User_Number").toString(),
            ),
          );
          notifyListeners();
        }
      }
      notifyListeners();
    });
  }

  // servicegrid
  int servicecount = 0;
  int serviceindex = 0;

  //residentialpage
  // service residence dropdown
  // dynamic dropresidencevalue;

  // setDropvalue0(value) {
  //   dropresidencevalue = value;
  //   notifyListeners();
  // }

  // servicetyperadiobutton
  // int radiotypelist=[1, 2];
  int residentialradiotypevalue = 0;
  bool residentialradioselectvalue = false;

  radiovalue0(value) {
    residentialradiotypevalue = value;

    notifyListeners();
  }

  //residentialpage

  //commercialpage
  // service commercial dropdown

  // var dropcommercialvalue = "Office";

  // setDropvalue1(value) {
  //   dropcommercialvalue = value;
  //   notifyListeners();
  // }

  // servicetyperadiobutton
  // int radiotypelist=[1, 2];
  int commercialradiotypevalue = 0;
  bool commercialradioselectvalue = false;

  radiovalue1(value) {
    commercialradiotypevalue = value;

    notifyListeners();
  }

  //listviewservices
  int activeIndex = 0;

  Map<int, bool> _checkboxStates = {};

  bool getCheckboxValue(int index) {
    return _checkboxStates[index] ?? false;
  }

  void setCheckboxValue(int index, bool value) {
    _checkboxStates[index] = value;
    notifyListeners();
  }

  void clearSelections() {
    _checkboxStates.clear();
    VentureController.clear();
    ventureSelectedid = '';
    dateController.clear();
    notifyListeners();
  }

  List<ResidenceCTypemodelclass> getSelectedServices() {
    List<ResidenceCTypemodelclass> selectedServices = [];
    _checkboxStates.forEach((index, isSelected) {
      if (isSelected && index < ResidenceCTypemodelclasslist.length) {
        selectedServices.add(ResidenceCTypemodelclasslist[index]);
      }
    });
    return selectedServices;
  }

  int othersradiotypevalue = 0;
  bool othersradioselectvalue = false;

  radiovalue2(value) {
    othersradiotypevalue = value;

    notifyListeners();
  }

  //otherspage

  // chekoutadio
  int checkoutradiovalue = 0;
  checkradiovalue(value) {
    checkoutradiovalue = value;

    notifyListeners();
  }

  List<Color> servlistContainercolor = [
    Color(0xff61cefa),
    Color(0xff895389),
    Color(0xff515a8a),
    Color(0xffe18181),
    Color(0xff6fbf77),
    Color(0xFFAB8181),
    Color(0xFF8467D7),
    Color(0xff50a5b8),
    Color(0xffff78c1),
  ];
  List<Color> servlistselectcolor = [
    Color(0xd9bbd8ff),
    Color(0x89c5a3c5),
    Color(0x889299bb),
    Color(0xccffbaba),
    Color(0xabbee0c1),
    Color(0xB3CFB7B7),
    Color(0xA8BAA6F2),
    Color(0xad9CCCD6),
    Color(0xa1ffbde0),
  ];

  //date
  TextEditingController dateController = TextEditingController();
  var outputDateFormat = DateFormat('dd/MM/yyyy');
  DateTime scheduledDate = DateTime.now();
  String scheduledDayNode = "";
  DateTime _date = DateTime.now();

  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),



    );

    if (picked != null) {
      _date = picked;
      scheduledDate = DateTime(_date.year, _date.month, _date.day);
      dateController.text = outputDateFormat.format(scheduledDate);
      notifyListeners();
    }
    notifyListeners();
  }

  //settingspage

  int settingscount = 0;
  int settingsindex = 0;
  List<String> settingslistimages = [
    "assets/Test Account.png",
    "assets/Messaging.png",
    "assets/infromation.png",
  ];

  List<String> settingslistnames = [
    "Edit Profile",
    "Chat with us",
    "About us",
  ];

  //adminside

  // admindashboard
  int dashcount = 0;
  int dashindex = 0;
  List<String> dashboardimages = [
    "assets/dashboard1.png",
    "assets/dashboard2.png",
    "assets/dashboard3.png",
    "assets/dashboard4.png",
    // "assets/dashboard5.png",
    // "assets/dashboard6.png",
  ];
  List<String> dashboardnames = [
    "Carousel",
    "User List",
    "Manage Services",
    "Bookings",
    // "Ventures",
    // "Cleaning Types"
  ];

  //adminbookingsstatus
  var bookingstatuslist = ["Service Booked", "Pending", "Completed"];
  var bookingstatusvalue = "Service Booked";

  statusDropvalue(value) {
    bookingstatusvalue = value;
    notifyListeners();
  }

  notifyListeners();

  // carousel

  File? carouselfileimg = null;
  String carouselimg = "";

  Future<void> addcarousel() async {
    String id = DateTime.now().millisecondsSinceEpoch.toString();
    HashMap<String, dynamic> map = HashMap();
    map["CAROUSEL_ID"] = id;

    if (carouselfileimg != null) {
      String photoId = DateTime.now().millisecondsSinceEpoch.toString();
      ref = FirebaseStorage.instance.ref().child(photoId);
      await ref.putFile(carouselfileimg!).whenComplete(() async {
        await ref.getDownloadURL().then((value) {
          map["PHOTO"] = value;
          notifyListeners();
        });
        notifyListeners();
      });
      notifyListeners();
    } else {
      map['PHOTO'] = carouselimg;
    }

    db.collection("CAROUSEL").doc(id).set(map);
    notifyListeners();
  }

  void setImage2(File image) {
    carouselfileimg = image;
    notifyListeners();
  }

  Future getImagegallery() async {
    final imagePicker = ImagePicker();
    final pickedImage =
        await imagePicker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      cropImage(pickedImage.path, "");

      print("tgyhjkmnb" + pickedImage.path);
    } else {
      print('No image selected.');
    }
  }

  Future getImagecamera() async {
    final imagePicker = ImagePicker();
    final pickedImage = await imagePicker.pickImage(source: ImageSource.camera);

    if (pickedImage != null) {
      cropImage(pickedImage.path, "");
    } else {
      print('No image selected.');
    }
  }

  Future<void> cropImage(String path, String from) async {
    final croppedFile = await ImageCropper().cropImage(
      sourcePath: path,
      aspectRatioPresets: Platform.isAndroid
          ? [
              CropAspectRatioPreset.square,
              CropAspectRatioPreset.ratio3x2,
              CropAspectRatioPreset.original,
              CropAspectRatioPreset.ratio4x3,
              CropAspectRatioPreset.ratio16x9,
            ]
          : [
              CropAspectRatioPreset.original,
              CropAspectRatioPreset.square,
              CropAspectRatioPreset.ratio3x2,
              CropAspectRatioPreset.ratio4x3,
              CropAspectRatioPreset.ratio5x3,
              CropAspectRatioPreset.ratio5x4,
              CropAspectRatioPreset.ratio7x5,
              CropAspectRatioPreset.ratio16x9,
              CropAspectRatioPreset.ratio16x9
            ],
      uiSettings: [
        AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: Colors.white,
            toolbarWidgetColor: Colors.black,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        IOSUiSettings(
          title: 'Cropper',
        )
      ],
    );
    if (croppedFile != null) {
      carouselfileimg = File(croppedFile.path);
      notifyListeners();
    }
  }

  int carouselcount = 0;
  int carouselindex = 0;
  void Activeindex(int index) {
    carouselindex = index;
    notifyListeners();
  }

  List<carouselmodelclass> carouselimages = [];
  // void getCarousel() {
  //   db.collection("CAROUSEL").get().then((value) {
  //     if (value.docs.isNotEmpty) {
  //       carouselimages.clear();
  //       for (var element in value.docs) {
  //         carouselimages.add(
  //             carouselmodelclass(element.id, element.get("PHOTO").toString()));
  //         notifyListeners();
  //       }
  //     }
  //     notifyListeners();
  //   });
  // }
  Future<void> getCarousel() async {
    try {
      final value = await db.collection("CAROUSEL").get();
      if (value.docs.isNotEmpty) {
        carouselimages.clear();
        for (var element in value.docs) {
          carouselimages.add(
              carouselmodelclass(element.id, element.get("PHOTO").toString())
          );
        }
      }
      notifyListeners();
    } catch (e) {
      print("Error in getCarousel: $e");
    }
  }

  void deleteCarousel(id, BuildContext context) {
    db.collection("CAROUSEL").doc(id).delete();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text("Deleted Successfully"),
      backgroundColor: Colors.redAccent,
    ));
    notifyListeners();
    getCarousel();
  }

  void clearCarouselpick() {
    carouselfileimg = null;
    carouselimg = "";
  }

// carousel

// MANAGESERVICE

  File? manageservicesfileimg = null;
  String manageservicesimg = "";
  TextEditingController ManageServiceNameController = TextEditingController();
  TextEditingController AdvanceAmountController = TextEditingController();

  Future<void> addManageservices() async {
    String id = DateTime.now().millisecondsSinceEpoch.toString();
    HashMap<String, dynamic> map = HashMap();
    map["MANAGESERVICES_ID"] = id;

    if (manageservicesfileimg != null) {
      String photoId = DateTime.now().millisecondsSinceEpoch.toString();
      ref = FirebaseStorage.instance.ref().child(photoId);
      await ref.putFile(manageservicesfileimg!).whenComplete(() async {
        await ref.getDownloadURL().then((value) {
          map["PHOTO"] = value;
          map["NAME"] = ManageServiceNameController.text;
          map["ADVANCE_AMOUNT"] = AdvanceAmountController.text;
          notifyListeners();
        });
        notifyListeners();
      });
      notifyListeners();
    } else {
      map['PHOTO'] = manageservicesimg;
    }

    db.collection("MANAGESERVICES").doc(id).set(map).then((value) {
      Fluttertoast.showToast(
          msg: "SuccessFully Added",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Color(0xda4b4b4b),
          textColor: Colors.white,
          fontSize: 16.0);
    });
    getManageservices();
    notifyListeners();
  }

  void MSsetImage2(File image) {
    manageservicesfileimg = image;
    notifyListeners();
  }

  Future MSgetImagegallery() async {
    final imagePicker = ImagePicker();
    final pickedImage =
        await imagePicker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      MScropImage(pickedImage.path, "");

      print("tgyhjkmnb" + pickedImage.path);
    } else {
      print('No image selected.');
    }
  }

  Future MSgetImagecamera() async {
    final imagePicker = ImagePicker();
    final pickedImage = await imagePicker.pickImage(source: ImageSource.camera);

    if (pickedImage != null) {
      MScropImage(pickedImage.path, "");
    } else {
      print('No image selected.');
    }
  }

  Future<void> MScropImage(String path, String from) async {
    final croppedFile = await ImageCropper().cropImage(
      sourcePath: path,
      aspectRatioPresets: Platform.isAndroid
          ? [
              CropAspectRatioPreset.square,
              CropAspectRatioPreset.ratio3x2,
              CropAspectRatioPreset.original,
              CropAspectRatioPreset.ratio4x3,
              CropAspectRatioPreset.ratio16x9,
            ]
          : [
              CropAspectRatioPreset.original,
              CropAspectRatioPreset.square,
              CropAspectRatioPreset.ratio3x2,
              CropAspectRatioPreset.ratio4x3,
              CropAspectRatioPreset.ratio5x3,
              CropAspectRatioPreset.ratio5x4,
              CropAspectRatioPreset.ratio7x5,
              CropAspectRatioPreset.ratio16x9,
              CropAspectRatioPreset.ratio16x9
            ],
      uiSettings: [
        AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: Colors.white,
            toolbarWidgetColor: Colors.black,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        IOSUiSettings(
          title: 'Cropper',
        )
      ],
    );
    if (croppedFile != null) {
      manageservicesfileimg = File(croppedFile.path);
      notifyListeners();
    }
  }

  List<ManageServicesmodelclass> ManageServicesmodelclasslist = [];
  // void getManageservices() {
  //   db.collection("MANAGESERVICES").get().then((value) {
  //     if (value.docs.isNotEmpty) {
  //       ManageServicesmodelclasslist.clear();
  //       for (var element in value.docs) {
  //         ManageServicesmodelclasslist.add(
  //             ManageServicesmodelclass(
  //                 element.id,
  //             element.get("PHOTO"),
  //             element.get("NAME").toString(),
  //               element.get("ADVANCE_AMOUNT").toString()
  //             ));
  //         notifyListeners();
  //       }
  //     }
  //     notifyListeners();
  //   });
  // }
  Future<void> getManageservices() async {
    try {
      final value = await db.collection("MANAGESERVICES").get();
      if (value.docs.isNotEmpty) {
        ManageServicesmodelclasslist.clear();
        for (var element in value.docs) {
          ManageServicesmodelclasslist.add(
              ManageServicesmodelclass(
                  element.id,
                  element.get("PHOTO"),
                  element.get("NAME").toString(),
                  element.get("ADVANCE_AMOUNT").toString()
              )
          );
        }
      }
      notifyListeners();
    } catch (e) {
      print("Error in getManageservices: $e");
    }
  }

  void deleteManageservices(id, BuildContext context) {
    db.collection("MANAGESERVICES").doc(id).delete();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text("Deleted Successfully"),
      backgroundColor: Colors.redAccent,
    ));
    notifyListeners();
    getManageservices();
  }

  void clearManageServiceController() {
    ManageServiceNameController.clear();
    AdvanceAmountController.clear(); // Add this line
    manageservicesfileimg = null;
    manageservicesimg = "";
  }

// manageservices

//AddVenturesResidence

  TextEditingController VentureController = TextEditingController();
  late String ventureSelectedid;

  Future addVentures(String serviceId) async {
    String id = DateTime.now().millisecondsSinceEpoch.toString();
    HashMap<String, dynamic> map = HashMap();
    map["Venture_ID"] = id;
    map["Venture_name"] = VentureController.text;
    // map["Venture_names"] = [
    //   VentureResidenceController.text,
    // ];
    db
        .collection("MANAGESERVICES")
        .doc(serviceId)
        .collection("VENTURES")
        .doc(id)
        .set(map)
        .then((value) {
      Fluttertoast.showToast(
          msg: "SuccessFully Added",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Color(0xda4b4b4b),
          textColor: Colors.white,
          fontSize: 16.0);
    });

    getVentures(serviceId);
    clearVentureController();
    notifyListeners();
  }

  List<ventureResidencemdlclss> ventureResidence = [];

  void getVentures(String serviceId) {
    db
        .collection("MANAGESERVICES")
        .doc(serviceId)
        .collection("VENTURES")
        .get()
        .then((value) {
      if (value.docs.isNotEmpty) {
        ventureResidence.clear();
        for (var element in value.docs) {
          ventureResidence.add(
            ventureResidencemdlclss(
              element.id,
              element.get("Venture_name").toString(),
            ),
          );
          notifyListeners();
        }
      }
      notifyListeners();
    });
  }

  void deleteVentures(String serviceId, String id, BuildContext context) {
    db
        .collection("MANAGESERVICES")
        .doc(serviceId)
        .collection("VENTURES")
        .doc(id)
        .delete();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text("Deleted Successfully"),
      backgroundColor: Colors.redAccent,
    ));
    notifyListeners();
    getVentures(serviceId);
  }

  void clearVentureController() {
    VentureController.clear();
  }

//AddVenturesResidence


// ResidenceCType

  File? ResidenceCTypefileimg = null;
  String ResidenceCTypeimg = "";
  TextEditingController ResidenceCTypeNameController = TextEditingController();
  Future<void> addCType(String serviceId) async {
    String id = DateTime.now().millisecondsSinceEpoch.toString();
    HashMap<String, dynamic> map = HashMap();
    map["ResidenceCType_ID"] = id;

    if (ResidenceCTypefileimg != null) {
      String photoId = DateTime.now().millisecondsSinceEpoch.toString();
      ref = FirebaseStorage.instance.ref().child(photoId);
      await ref.putFile(ResidenceCTypefileimg!).whenComplete(() async {
        await ref.getDownloadURL().then((value) {
          map["PHOTO"] = value;
          map["NAME"] = ResidenceCTypeNameController.text;
          notifyListeners();
        });
        notifyListeners();
      });
      notifyListeners();
    } else {
      map['PHOTO'] = ResidenceCTypeimg;
    }

    db
        .collection("MANAGESERVICES")
        .doc(serviceId)
        .collection("CTypes")
        .doc(id)
        .set(map)
        .then((value) {
      Fluttertoast.showToast(
          msg: "SuccessFully Added",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Color(0xda4b4b4b),
          textColor: Colors.white,
          fontSize: 16.0);
    });
    getCType(serviceId);
    notifyListeners();
  }

  void ResidenceCTypesetImage2(File image) {
    ResidenceCTypefileimg = image;
    notifyListeners();
  }

  Future ResidenceCTypegetImagegallery() async {
    final imagePicker = ImagePicker();
    final pickedImage =
        await imagePicker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      ResidenceCTypecropImage(pickedImage.path, "");

      print("tgyhjkmnb" + pickedImage.path);
    } else {
      print('No image selected.');
    }
  }

  Future ResidenceCTypegetImagecamera() async {
    final imagePicker = ImagePicker();
    final pickedImage = await imagePicker.pickImage(source: ImageSource.camera);

    if (pickedImage != null) {
      ResidenceCTypecropImage(pickedImage.path, "");
    } else {
      print('No image selected.');
    }
  }

  Future<void> ResidenceCTypecropImage(String path, String from) async {
    final croppedFile = await ImageCropper().cropImage(
      sourcePath: path,
      aspectRatioPresets: Platform.isAndroid
          ? [
              CropAspectRatioPreset.square,
              CropAspectRatioPreset.ratio3x2,
              CropAspectRatioPreset.original,
              CropAspectRatioPreset.ratio4x3,
              CropAspectRatioPreset.ratio16x9,
            ]
          : [
              CropAspectRatioPreset.original,
              CropAspectRatioPreset.square,
              CropAspectRatioPreset.ratio3x2,
              CropAspectRatioPreset.ratio4x3,
              CropAspectRatioPreset.ratio5x3,
              CropAspectRatioPreset.ratio5x4,
              CropAspectRatioPreset.ratio7x5,
              CropAspectRatioPreset.ratio16x9,
              CropAspectRatioPreset.ratio16x9
            ],
      uiSettings: [
        AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: Colors.white,
            toolbarWidgetColor: Colors.black,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        IOSUiSettings(
          title: 'Cropper',
        )
      ],
    );
    if (croppedFile != null) {
      ResidenceCTypefileimg = File(croppedFile.path);
      notifyListeners();
    }
  }

  List<ResidenceCTypemodelclass> ResidenceCTypemodelclasslist = [];
  void getCType(String serviceId) {
    db
        .collection("MANAGESERVICES")
        .doc(serviceId)
        .collection("CTypes")
        .get()
        .then((value) {
      if (value.docs.isNotEmpty) {
        ResidenceCTypemodelclasslist.clear();
        for (var element in value.docs) {
          ResidenceCTypemodelclasslist.add(ResidenceCTypemodelclass(element.id,
              element.get("PHOTO"), element.get("NAME").toString()));
          notifyListeners();
        }
      }
      notifyListeners();
    });
  }

  void deleteCType(String serviceId, String id, BuildContext context) {
    db
        .collection("MANAGESERVICES")
        .doc(serviceId)
        .collection("CTypes")
        .doc(id)
        .delete();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text("Deleted Successfully"),
      backgroundColor: Colors.redAccent,
    ));
    notifyListeners();
    // getResidenceCType(serviceId);
  }

  void clearResidenceCTypeController() {
    ResidenceCTypeNameController.clear();
    ResidenceCTypefileimg = null;
    ResidenceCTypeimg = "";
  }




  ////////






/////////

  TextEditingController nameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController mobilenumberController = TextEditingController();
  TextEditingController districtController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController pincodeController = TextEditingController();

  List<UserAddressmodelclass> userAddresses = [];



  Future<void> addAddressFunction(String userId) async {
    String id = DateTime.now().millisecondsSinceEpoch.toString();
    bool isDefault = userAddresses.isEmpty; // First address will be default

    UserAddressmodelclass newAddress = UserAddressmodelclass(
      userId: userId,
      addressId: id,
      username: nameController.text,
      useraddress: addressController.text,
      mobilenumber: mobilenumberController.text,
      district: districtController.text,
      state: stateController.text,
      pincode: pincodeController.text,
      isDefault: isDefault,
    );

    try {
      await db.collection("USER_ADDRESS").doc(id).set(newAddress.toMap());
      userAddresses.add(newAddress);
      clearAddress();
      notifyListeners();
      print("Address added successfully");
    } catch (e) {
      print("Error adding address: $e");
    }
  }


   // List<UserAddressmodelclass> userAddressDetails =[];


  // void getaddressFunction(String userId){
  //   db..collection("USER_ADDRESS")
  //           .where("User_Id", isEqualTo: userId)
  //           .limit(1)
  //           .get().then((value){
  //     if(value.docs.isNotEmpty){
  //       userAddressDetails.clear();
  //       for(var element in value.docs){
  //         userAddressDetails.add(
  //           UserAddressmodelclass(
  //             element.get("User_Id").toString(),
  //             element.id,
  //             element.get("Name").toString(),
  //             element.get("Address").toString(),
  //             element.get("Mobile").toString(),
  //             element.get("District").toString(),
  //             element.get("State").toString(),
  //             element.get("Pincode").toString(),
  //
  //           ),
  //         );
  //         notifyListeners();
  //       }
  //     }
  //     notifyListeners();
  //   });
  // }

  Future<void> getAddressesFunction(String userId) async {
    try {
      QuerySnapshot querySnapshot = await db
          .collection("USER_ADDRESS")
          .where("User_Id", isEqualTo: userId)
          .get();

      userAddresses = querySnapshot.docs
          .map((doc) => UserAddressmodelclass.fromMap(doc.data() as Map<String, dynamic>))
          .toList();

      notifyListeners();
    } catch (e) {
      print("Error getting addresses: $e");
    }
  }



  Future<void> deleteAddressFunction(String id, BuildContext context) async {
    try {
      await db.collection("USER_ADDRESS").doc(id).delete();
      userAddresses.removeWhere((address) => address.addressId == id);

      // If the deleted address was default, set a new default if possible
      if (userAddresses.isNotEmpty && !userAddresses.any((address) => address.isDefault)) {
        await setDefaultAddress(userAddresses.first.addressId);
      }

      notifyListeners();
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Deleted Successfully"), backgroundColor: Colors.redAccent)
      );
    } catch (e) {
      print("Error deleting address: $e");
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error deleting address"), backgroundColor: Colors.redAccent)
      );
    }
  }

  UserAddressmodelclass? _selectedAddress;
  UserAddressmodelclass? get selectedAddress => _selectedAddress;

  Future<void> setDefaultAddress(String addressId) async {
    try {
      // Remove default from all addresses
      for (var address in userAddresses) {
        if (address.isDefault) {
          await db.collection("USER_ADDRESS").doc(address.addressId).update({'IsDefault': false});
        }
      }

      // Set new default
      await db.collection("USER_ADDRESS").doc(addressId).update({'IsDefault': true});

      // Update local list
      userAddresses = userAddresses.map((address) {
        if (address.addressId == addressId) {
          return UserAddressmodelclass(
            userId: address.userId,
            addressId: address.addressId,
            username: address.username,
            useraddress: address.useraddress,
            mobilenumber: address.mobilenumber,
            district: address.district,
            state: address.state,
            pincode: address.pincode,
            isDefault: true,
          );
        } else {
          return UserAddressmodelclass(
            userId: address.userId,
            addressId: address.addressId,
            username: address.username,
            useraddress: address.useraddress,
            mobilenumber: address.mobilenumber,
            district: address.district,
            state: address.state,
            pincode: address.pincode,
            isDefault: false,
          );
        }
      }).toList();

      notifyListeners();
    } catch (e) {
      print("Error setting default address: $e");
    }
  }



  Future<UserAddressmodelclass?> getDefaultAddress(String userId) async {
    try {
      QuerySnapshot querySnapshot = await db
          .collection("USER_ADDRESS")
          .where("User_Id", isEqualTo: userId)
          .where("IsDefault", isEqualTo: true)
          .limit(1)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        return UserAddressmodelclass.fromMap(querySnapshot.docs.first.data() as Map<String, dynamic>);
      } else {
        return null;
      }
    } catch (e) {
      print("Error getting default address: $e");
      return null;
    }
  }




  void clearAddress() {
    nameController.clear();
    addressController.clear();
      mobilenumberController.clear();
    districtController.clear();
      stateController.clear();
    pincodeController.clear();

    notifyListeners();
  }




//





  void razorpayGateway(String advance){

    int amountInPaise;
    try {
      amountInPaise = (double.parse(advance) * 100).round();
    } catch (e) {
      print('Invalid amount format: $advance');
      // Handle the error appropriately
      return;
    }

    Razorpay razorpay = Razorpay();
    var options = {
      'key': 'rzp_test_1DP5mmOlF5G5ag',
      'amount': amountInPaise.toString(),
      'name': "WellClean",
      'description': "Pay the Advance Amount",
      'retry': {'enabled': true, 'max_count': 1},
      'send_sms_hash': true,
      'prefill': {
        'contact': '9988776655',
        // 'email': 'test@razorpay.com'
      },
      'external': {
        'wallets': ['paytm']
      },
      'theme': {
        'color': '#750475', // Replace with your desired color (Hex code)
      },
      'image': 'https://i.ibb.co/QFMCBkp/IMG-20240705-WA0038.jpg',

    };
    razorpay.on(
        Razorpay.EVENT_PAYMENT_ERROR, handlePaymentErrorResponse);
    razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS,
        handlePaymentSuccessResponse);
    razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET,
        handleExternalWalletSelected);
    razorpay.open(options);

  }
  void handlePaymentErrorResponse(PaymentFailureResponse response) {
    /*
  * PaymentFailureResponse contains three values:
  * 1. Error Code
  * 2. Error Description
  * 3. Metadata
  * */

  }

  void handlePaymentSuccessResponse(PaymentSuccessResponse response) {
    // Log the success response
    log(response.data.toString() + "success");

  }

  void handleExternalWalletSelected(ExternalWalletResponse response) {

  }




  // / call
  void makingPhoneCall(String Phone) async {
    String url = "";
    url = 'tel:$Phone';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

//whatsapp
  void launchWhatsApp({required String phoneNumber, required String message}) async {
    String url = "https://wa.me/$phoneNumber?text=${Uri.encodeComponent(message)}";

    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
    }



  Color getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'pending':
        return Colors.orange;
      case 'confirmed':
        return Colors.blue;
      case 'in progress':
        return Colors.yellow;
      case 'completed':
        return Colors.green;
      case 'cancelled':
        return Colors.red;
      default:
        return Colors.black;
    }
  }

  bool isLoading = true;

  void setLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }












} //
