class UserDataProfile {
  String name;
  String phone;
  String email;

  UserDataProfile.fromMap(Map<String, dynamic> data) {
    name = data["name"];
    phone = data["phone"];
    email = data["email"];
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'phone': phone,
      'email': email,
    };
  }
}

class UserDataAddress {
  String fullLegalName;
  String addressLine1;
  String addressLine2;
  String city;
  String zipcode;
  String state;

  UserDataAddress.fromMap(Map<String, dynamic> data) {
    fullLegalName = data["fullLegalName"];
    addressLine1 = data["addressLine1"];
    addressLine2 = data["addressLine2"];
    city = data["city"];
    zipcode = data["zipcode"];
    state = data["state"];
  }

  Map<String, dynamic> toMap() {
    return {
      'fullLegalName': fullLegalName,
      'addressLine1': addressLine1,
      'addressLine2': addressLine2,
      'city': city,
      'zipcode': zipcode,
      'state': state,
    };
  }
}

class UserDataCard {
  String cardHolder;
  String cardNumber;
  String validThrough;
  String securityCode;

  UserDataCard.fromMap(Map<String, dynamic> data) {
    cardHolder = data["cardHolder"];
    cardNumber = data["cardNumber"];
    validThrough = data["validThrough"];
    securityCode = data["securityCode"];
  }

  Map<String, dynamic> toMap() {
    return {
      'cardHolder': cardHolder,
      'cardNumber': cardNumber,
      'validThrough': validThrough,
      'securityCode': securityCode,
    };
  }
}
