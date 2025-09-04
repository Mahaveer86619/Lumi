class UserEntity {
  final String id;
  final String fullName;
  final String email;
  final String isVerified;
  final String profilePicture;
  final String authType;

  UserEntity({
    required this.id,
    required this.fullName,
    required this.email,
    required this.isVerified,
    required this.profilePicture,
    required this.authType,
  });

  factory UserEntity.fromJson(Map<String, dynamic> json) {
    return UserEntity(
      id: json['id'],
      fullName: json['fullName'],
      email: json['email'],
      isVerified: json['isVerified'] ?? '',
      profilePicture: json['profilePicture'] ?? '',
      authType: json['authType'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'fullName': fullName,
      'email': email,
      'isVerified': isVerified,
      'profilePicture': profilePicture,
      'authType': authType,
    };
  }

  @override
  String toString() {
    return """
UserEntity{
  id: $id, 
  fullName: $fullName, 
  email: $email, 
  profilePicture: $profilePicture, 
  authType: $authType
}""";
  }
}
