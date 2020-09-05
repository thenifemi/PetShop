class Brands {
  String brandName;
  String brandImage;

  Brands.fromMap(Map<String, dynamic> data) {
    brandName = data["brandName"];
    brandImage = data["brandsImage"];
  }
}
