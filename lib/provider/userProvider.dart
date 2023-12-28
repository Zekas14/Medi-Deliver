import 'package:flutter/material.dart';
import 'package:medi_deliver/model/user.dart' as model;

class UserProvider extends ChangeNotifier {
  model.User? loggedInUser;

  void setLoggedInUser(model.User user) {
    loggedInUser = user;
    notifyListeners();
  }

  void updateUserData({String? fullName, String? phoneNumber, String? address}) {
    if (loggedInUser != null) {
      if (fullName != null) {
        loggedInUser!.fullName = fullName;
      }
      if (phoneNumber != null) {
        loggedInUser!.phoneNumber = phoneNumber;
      }
      if (address != null) {
        loggedInUser!.address = address;
      }

      notifyListeners();
    }
  }
}
