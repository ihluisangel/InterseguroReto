import 'dart:convert';
import 'dart:developer';

// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;
import '../../domain/models/auth/login_response.dart';

import '../../commons/exception.dart';
import '../../commons/urls.dart';

abstract class AuthRemoteDataSource {
  Future<LoginResponse> login(
      {required String username, required String password});
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final http.Client client;

  AuthRemoteDataSourceImpl({required this.client});

  @override
  Future<LoginResponse> login(
      {required String username, required String password}) async {
    final response = await client.post(Uri.parse(Urls.login),
        body: json.encode({"user": username, "password": password}));

    log(json.decode(response.body).toString());
    if (response.statusCode == 200) {
      return LoginResponse.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }
}
