class Like {
  final int id;
  final int art_id;
  final int member_id;

  Like({
    required this.id,
    required this.art_id,
    required this.member_id,
  });

  factory Like.fromJson(Map<String, dynamic> json) => Like(
        id: json['id'],
        art_id: json['art_id'],
        member_id: json['member_id'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'art_id': art_id,
        'member_id': member_id,
      };
}
