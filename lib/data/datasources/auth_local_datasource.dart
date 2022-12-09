import 'dart:convert';

import 'package:interseguroapp/commons/local_name_pref.dart';
import 'package:interseguroapp/domain/models/auth/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class AuthLocalDatasource {
  Future<User> saveUser(User user);
  Future<User?> getUser();
  Future<bool> removeUser();
}

class AuthLocalDatasourceImpl implements AuthLocalDatasource {
  @override
  Future<User?> getUser() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var user = sharedPreferences.getString(LocalNamePref.userPref);
    if (user == null) {
      return null;
    } else {
      return User.fromJson(json.decode(user));
    }
  }

  @override
  Future<bool> removeUser() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    if (sharedPreferences.containsKey(LocalNamePref.userPref)) {
      await sharedPreferences.remove(LocalNamePref.userPref);
    }
    return true;
  }

  @override
  Future<User> saveUser(User user) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    await sharedPreferences.setString(
        LocalNamePref.userPref, json.encode(user.toJson()));
    return user;
  }
}
