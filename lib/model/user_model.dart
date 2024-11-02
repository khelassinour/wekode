class UserModel {
  final bool success;
  final String message;
  final UserData? data;
  final dynamic debug;

  UserModel({
    required this.success,
    required this.message,
    this.data,
    this.debug,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      success: json['success'] as bool,
      message: json['message'] as String,
      data: json['data'] != null ? UserData.fromJson(json['data']) : null,
      debug: json['debug'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
      'data': data?.toJson(),
      'debug': debug,
    };
  }
}

class UserData {
  final User user;
  final String accessToken;

  UserData({
    required this.user,
    required this.accessToken,
  });

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      user: User.fromJson(json['user']),
      accessToken: json['access_token'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user': user.toJson(),
      'access_token': accessToken,
    };
  }
}

class User {
  final int id;
  final String firstName;
  final String lastName;
  final String email;
  final String? phone;
  final String? phoneCountry;
  final String? imageUrl;
  final String? emailVerifiedAt;

  User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    this.phone,
    this.phoneCountry,
    this.imageUrl,
    this.emailVerifiedAt,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as int,
      firstName: json['first_name'] as String,
      lastName: json['last_name'] as String,
      email: json['email'] as String,
      phone: json['phone'],
      phoneCountry: json['phone_country'],
      imageUrl: json['image_url'],
      emailVerifiedAt: json['email_verified_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'first_name': firstName,
      'last_name': lastName,
      'email': email,
      'phone': phone,
      'phone_country': phoneCountry,
      'image_url': imageUrl,
      'email_verified_at': emailVerifiedAt,
    };
  }
}
