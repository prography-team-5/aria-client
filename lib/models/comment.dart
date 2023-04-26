class Comment {
  final int id;
  final int art_id;
  final int member_id;
  final String content;

  Comment({
    required this.id,
    required this.art_id,
    required this.member_id,
    required this.content,
  });

  factory Comment.fromJson(Map<String, dynamic> json) => Comment(
        id: json['id'],
        art_id: json['art_id'],
        member_id: json['member_id'],
        content: json['content'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'art_id': art_id,
        'member_id': member_id,
        'content': content,
      };
}
