class Follow {
  final int id;
  final int follower_id;
  final int followee_id;

  Follow({
    required this.id,
    required this.follower_id,
    required this.followee_id,
  });

  factory Follow.fromJson(Map<String, dynamic> json) => Follow(
        id: json['id'],
        follower_id: json['follower_id'],
        followee_id: json['followee_id'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'follower_id': follower_id,
        'followee_id': followee_id,
      };
}

class Followee {
  final int followId;
  final int followeeId;
  final String followeeNickname;
  final String followeeProfileImageUrl;

  Followee({
    required this.followId,
    required this.followeeId,
    required this.followeeNickname,
    required this.followeeProfileImageUrl,
  });

  factory Followee.fromJson(Map<String, dynamic> json) => Followee(
        followId: json['followId'],
        followeeId: json['followeeId'],
        followeeNickname: json['followeeNickname'],
        followeeProfileImageUrl: json['followeeProfileImageUrl'],
      );
}
