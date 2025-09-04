class AppUser {
  final String id;
  final String fullName;
  final String email;
  final String isVerified;
  final String profilePicture;
  final String authType;

  AppUser({
    required this.id,
    required this.fullName,
    required this.email,
    required this.isVerified,
    required this.profilePicture,
    required this.authType,
  });

  // to json
  factory AppUser.fromJson(Map<String, dynamic> json) {
    return AppUser(
      id: json['id'],
      fullName: json['fullName'],
      email: json['email'],
      isVerified: json['isVerified'] ?? '',
      profilePicture: json['profilePicture'] ?? '',
      authType: json['authType'] ?? '',
    );
  }

  // from json
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'fullName': fullName,
      'email': email,
      'profilePicture': profilePicture,
      'authType': authType,
    };
  }

  @override
  String toString() {
    return """
AppUser{
  id: $id, 
  fullName: $fullName, 
  email: $email, 
  profilePicture: $profilePicture, 
  authType: $authType
}""";
  }
}
