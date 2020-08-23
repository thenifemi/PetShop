class UserDataProfile {
  String name;
  String phone;
  String email;
  String profilePhoto;

  UserDataProfile.fromMap(Map<String, dynamic> data) {
    name = data["name"];
    phone = data["phone"];
    email = data["email"];
    profilePhoto = data["profilePhoto"];
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'phone': phone,
      'email': email,
      'profilePhoto': profilePhoto,
    };
  }
}

class UserDataAddress {
  String addressLocation;
  String addressNumber;
  String fullLegalName;

  UserDataAddress(
    this.addressLocation,
    this.addressNumber,
    this.fullLegalName,
  );

  UserDataAddress.fromMap(Map<String, dynamic> data) {
    addressLocation = data["addressLocation"];
    addressNumber = data["addressNumber"];
    fullLegalName = data["fullLegalName"];
  }

  Map<String, dynamic> toMap() {
    return {
      'addressLocation': addressLocation,
      'addressNumber': addressNumber,
      'fullLegalName': fullLegalName,
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
