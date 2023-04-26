class Member {
  final int id;
  final String email;
  final String password;
  final String role;
  final String nickname;
  final String profile_image_url;
  final String sign_type;

  Member({
    required this.id,
    required this.email,
    required this.password,
    required this.role,
    required this.nickname,
    required this.profile_image_url,
    required this.sign_type,
  });

  factory Member.fromJson(Map<String, dynamic> json) => Member(
        id: json['id'],
        email: json['email'],
        password: json['password'],
        role: json['role'],
        nickname: json['nickname'],
        profile_image_url: json['profile_image_url'],
        sign_type: json['sign_type'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'email': email,
        'password': password,
        'role': role,
        'nickname': nickname,
        'profile_image_url': profile_image_url,
        'sign_type': sign_type,
      };
}
