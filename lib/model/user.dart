class User {

  String? uid;
  String? fullName;
  String? email;
  String? address;
  String profileImage;
  String? phoneNumber;
  User({
    this.uid,
    this.address,
    this.fullName,
    this.email,
    this.phoneNumber,
    required this.profileImage,
  });
}
