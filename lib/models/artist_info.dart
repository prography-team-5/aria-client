class ArtistInfo {
  final int id;
  final int member_id;
  final String profile_art_image_url;
  final String intro;

  ArtistInfo({
    required this.id,
    required this.member_id,
    required this.profile_art_image_url,
    required this.intro,
  });

  factory ArtistInfo.fromJson(Map<String, dynamic> json) => ArtistInfo(
        id: json['id'],
        member_id: json['member_id'],
        profile_art_image_url: json['profile_art_image_url'],
        intro: json['intro'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'member_id': member_id,
        'profile_art_image_url': profile_art_image_url,
        'intro': intro,
      };
}
