class LoginModel {
  final String? uid;
  final String? email;
  final String? accessToken;
  final String? refreshToken;
  final bool? isVerified;

  LoginModel({
    this.uid,
    this.email,
    this.accessToken,
    this.refreshToken,
    this.isVerified,
  });

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'email': email,
      'accessToken': accessToken,
      'refreshToken': refreshToken,
      'isVerified': isVerified,
    };
  }

  factory LoginModel.fromJson(Map<String, dynamic> json) {
    return LoginModel(
      uid: json['uid'],
      email: json['email'],
      accessToken: json['accessToken'],
      refreshToken: json['refreshToken'],
      isVerified: json['isVerified'],
    );
  }

  LoginModel copyWith({
    String? uid,
    String? email,
    String? accessToken,
    String? refreshToken,
    bool? isVerified,
  }) {
    return LoginModel(
      uid: uid ?? this.uid,
    );
  }
}
