class carouselmodelclass{

  String id;
  String image;


  carouselmodelclass(this.id,this.image);
}

class ManageServicesmodelclass {
  String id;
  String image;
  String name;
  String advance;

  ManageServicesmodelclass(
      this.id,
      this.image,
      this.name,
      this.advance

      );
}

class ResidenceCTypemodelclass{

  String id;
  String image;
  String name;


  ResidenceCTypemodelclass(this.id,this.image,this.name);
}

class usermodelclass {

  String id;
  String username;
  String Number;


  usermodelclass(this.id,this.username,this.Number);

}


class ventureResidencemdlclss {

  String id;
  String venturename;


  ventureResidencemdlclss(this.id,this.venturename);

}

class UserAddressmodelclass {
  final String userId;
  final String addressId;
  final String username;
  final String useraddress;
  final String mobilenumber;
  final String district;
  final String state;
  final String pincode;
  final bool isDefault;

  UserAddressmodelclass({
    required this.userId,
    required this.addressId,
    required this.username,
    required this.useraddress,
    required this.mobilenumber,
    required this.district,
    required this.state,
    required this.pincode,
    required this.isDefault,
  });

  factory UserAddressmodelclass.fromMap(Map<String, dynamic> map) {
    return UserAddressmodelclass(
      userId: map['User_Id'] ?? '',
      addressId: map['Address_Id'] ?? '',
      username: map['Name'] ?? '',
      useraddress: map['Address'] ?? '',
      mobilenumber: map['Mobile'] ?? '',
      district: map['District'] ?? '',
      state: map['State'] ?? '',
      pincode: map['Pincode'] ?? '',
      isDefault: map['IsDefault'] ?? false,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'User_Id': userId,
      'Address_Id': addressId,
      'Name': username,
      'Address': useraddress,
      'Mobile': mobilenumber,
      'District': district,
      'State': state,
      'Pincode': pincode,
      'IsDefault': isDefault,
    };
  }
}

class Booking {
  final String id;
  final String userId;
  final String serviceType;
  final String selectedVenture;
  final List<String> selectedServices;
  final String date;
  final String bookedDate; // Add this line
  String status;
  final double advancePayment;
  final Address serviceAddress;

  Booking({
    required this.id,
    required this.userId,
    required this.serviceType,
    required this.selectedVenture,
    required this.selectedServices,
    required this.date,
    required this.bookedDate, // Add this line
    required this.status,
    required this.advancePayment,
    required this.serviceAddress,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'serviceType': serviceType,
      'selectedVenture': selectedVenture,
      'selectedServices': selectedServices,
      'date': date,
      'bookedDate': bookedDate, // Add this line
      'status': status,
      'advancePayment': advancePayment,
      'serviceAddress': serviceAddress.toMap(),
    };
  }

  factory Booking.fromMap(Map<String, dynamic> map) {
    return Booking(
      id: map['id'],
      userId: map['userId'],
      serviceType: map['serviceType'],
      selectedVenture: map['selectedVenture'],
      selectedServices: List<String>.from(map['selectedServices']),
      date: map['date'],
      bookedDate: map['bookedDate'], // Add this line
      status: map['status'],
      advancePayment: map['advancePayment'],
      serviceAddress: Address.fromMap(map['serviceAddress']),
    );
  }

  Booking copyWith({String? status}) {
    return Booking(
      id: this.id,
      userId: this.userId,
      serviceType: this.serviceType,
      selectedVenture: this.selectedVenture,
      selectedServices: this.selectedServices,
      date: this.date,
      status: status ?? this.status,
      advancePayment: this.advancePayment,
      serviceAddress: this.serviceAddress, bookedDate: this.bookedDate,
    );
  }
}

class Address {
  final String username;
  final String userAddress;
  final String mobileNumber;
  final String district;
  final String state;
  final String pincode;

  Address({
    required this.username,
    required this.userAddress,
    required this.mobileNumber,
    required this.district,
    required this.state,
    required this.pincode,
  });

  Map<String, dynamic> toMap() {
    return {
      'username': username,
      'userAddress': userAddress,
      'mobileNumber': mobileNumber,
      'district': district,
      'state': state,
      'pincode': pincode,
    };
  }

  factory Address.fromMap(Map<String, dynamic> map) {
    return Address(
      username: map['username'],
      userAddress: map['userAddress'],
      mobileNumber: map['mobileNumber'],
      district: map['district'],
      state: map['state'],
      pincode: map['pincode'],
    );
  }
}