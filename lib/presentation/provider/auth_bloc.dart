import 'package:flutter/material.dart';
import 'package:interseguroapp/domain/usecases/get_user.dart';
import 'package:interseguroapp/domain/usecases/is_remember.dart';
import 'package:interseguroapp/domain/usecases/on_login.dart';
import 'package:interseguroapp/domain/usecases/on_logout.dart';

import '../../commons/state_enum.dart';
import '../../domain/models/auth/user.dart';

class AuthBloc extends ChangeNotifier {
  User? _user;
  User? get user => _user;

  RequestState _userState = RequestState.empty;
  RequestState get userState => _userState;

  String _message = '';
  String get message => _message;

  final formLogin = GlobalKey<FormState>();
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();

  bool isRemember = false;

  RequestState _logoutState = RequestState.empty;
  RequestState get logoutState => _logoutState;

  final OnLogin onLogin;
  final GetUser getUser;
  final IsRemember isRememberCase;
  final OnLogout onLogoutCase;

  AuthBloc(
      {required this.onLogin,
      required this.getUser,
      required this.isRememberCase,
      required this.onLogoutCase});

  Future<void> login() async {
    _userState = RequestState.loading;
    notifyListeners();

    final userResult = await onLogin.execute(
        username: username.text,
        password: password.text,
        isRemember: isRemember);

    userResult.fold(
      (failure) {
        _userState = RequestState.error;
        _message = failure.message;
        notifyListeners();
      },
      (user) {
        _userState = RequestState.loaded;
        _user = user;
        notifyListeners();
      },
    );
  }

  Future<void> getOnlogout() async {
    _logoutState = RequestState.loading;
    notifyListeners();
    final userResult = await onLogoutCase.execute();

    userResult.fold(
      (failure) {
        _logoutState = RequestState.error;

        notifyListeners();
      },
      (res) {
        _logoutState = RequestState.loaded;

        notifyListeners();
      },
    );
  }

  Future<void> onGetUser() async {
    _userState = RequestState.loading;
    notifyListeners();

    final userResult = await getUser.execute();

    userResult.fold(
      (failure) {
        _userState = RequestState.error;
        _message = failure.message;
        notifyListeners();
      },
      (user) {
        _userState = RequestState.loaded;
        _user = user;
        notifyListeners();
      },
    );
  }

  Future<void> getIsRemeber() async {
    final userResult = await isRememberCase.execute();

    userResult.fold(
      (failure) {
        isRemember = false;
        notifyListeners();
      },
      (res) {
        isRemember = res;
        notifyListeners();
      },
    );
  }

  changeRemember() {
    isRemember = !isRemember;
    notifyListeners();
  }

  resetIsRemember() {
    isRemember = false;
    _logoutState = RequestState.empty;
    notifyListeners();
  }
}
