import 'package:logger/logger.dart';
import 'package:lumi/features/auth/domain/entity/user_entity.dart';

class UserModel extends UserEntity {
  final String token;
  final String refreshToken;

  UserModel({
    required super.id,
    required super.fullName,
    required super.email,
    required super.isVerified,
    required super.profilePicture,
    required super.authType,
    required this.token,
    required this.refreshToken,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    Logger logger = Logger();
    logger.i("UserEntity.fromJson json: $json");

    UserModel userModel = UserModel(
      id: json['id'],
      fullName: json['full_name'],
      email: json['email'],
      isVerified: json['isVerified'] ?? '',
      profilePicture: json['profilePicture'] ?? '',
      authType: json['authType'] ?? '',
      token: json['token'] ?? '',
      refreshToken: json['refreshToken'] ?? '',
    );

    logger.i("UserEntity.fromJson userModel: ${userModel.toString()}");

    return userModel;
  }

  UserEntity toEntity() {
    return UserEntity(
      id: id,
      fullName: fullName,
      email: email,
      isVerified: isVerified,
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
      'isVerified': isVerified,
      'profilePicture': profilePicture,
      'authType': authType,
      'token': token,
      'refreshToken': refreshToken,
    };
  }

  @override
  String toString() {
    return """
UserModel{
  id: $id, 
  fullName: $fullName, 
  email: $email, 
  profilePicture: $profilePicture, 
  authType: $authType,
  token: $token,
  refreshToken: $refreshToken
}""";
  }
}
