// user_provider.dart

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:medi_deliver/model/user.dart' as model;

class UserProvider extends ChangeNotifier {
  model.User? loggedInUser;

  void setLoggedInUser(model.User user) {
    loggedInUser = user;
    notifyListeners();
  }
}
