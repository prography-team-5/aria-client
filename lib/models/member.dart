class Member {
  final int memberId;
  final String nickname;
  final String profileImageUrl;
  final String role;

  Member({
    required this.memberId,
    required this.nickname,
    required this.profileImageUrl,
    required this.role,
  });

  factory Member.fromJson(Map<String, dynamic> json) => Member(
        memberId: json['memberId'],
        nickname: json['nickname'],
        profileImageUrl: json['profileImageUrl'],
        role: json['role'],
      );

  Map<String, dynamic> toJson() => {
        'memberId': memberId,
        'nickname': nickname,
        'profileImageUrl': profileImageUrl,
        'role': role,
      };
}
