import 'package:lumi/features/auth/domain/entity/user_entity.dart';

class UserModel extends UserEntity {
  final String token;
  final String refreshToken; 

  UserModel({
    required super.id,
    required super.fullName,
    required super.email,
    required super.profilePicture,
    required super.authType,
    required this.token,
    required this.refreshToken,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      fullName: json['full_name'],
      email: json['email'],
      profilePicture: json['profilePicture'] ?? '',
      authType: json['authType'] ?? '',
      token: json['token'] ?? '',
      refreshToken: json['refreshToken'] ?? '',
    );
  }

  UserEntity toEntity() {
    return UserEntity(
      id: id,
      fullName: fullName,
      email: email,
      profilePicture: profilePicture,
      authType: authType,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'fullName': fullName,
      'email': email,
      'profilePicture': profilePicture,
      'authType': authType,
      'token': token,
      'refreshToken': refreshToken,
    };
  }
}
