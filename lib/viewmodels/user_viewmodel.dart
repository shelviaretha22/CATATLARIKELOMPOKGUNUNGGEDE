import 'package:flutter/material.dart';
import '../models/user_model.dart';

class UserViewModel extends ChangeNotifier {

  UserModel user;

  UserViewModel({
    required this.user,
  });

  void updateUser(UserModel updatedUser) {
    user = updatedUser;
    notifyListeners();
  }
}