class ArtistTag {
  final int id;
  final int member_id;
  final int tag_id;

  ArtistTag({
    required this.id,
    required this.member_id,
    required this.tag_id,
  });

  factory ArtistTag.fromJson(Map<String, dynamic> json) => ArtistTag(
        id: json['id'],
        member_id: json['member_id'],
        tag_id: json['tag_id'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'member_id': member_id,
        'tag_id': tag_id,
      };
}
