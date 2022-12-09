import './user.dart';

class LoginResponse {
  LoginResponse({
    required this.code,
    required this.message,
    this.body,
  });

  int code;
  String message;
  User? body;

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
        code: json["code"],
        message: json["message"],
        body: json["body"] == null ? null : User.fromJson(json["body"]),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "message": message,
        "body": body == null ? null : body!.toJson(),
      };
}
