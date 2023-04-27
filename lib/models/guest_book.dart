class GuestBook {
  final int id;
  final int artist_info_id;
  final int member_id;
  final String content;

  GuestBook({
    required this.id,
    required this.artist_info_id,
    required this.member_id,
    required this.content,
  });

  factory GuestBook.fromJson(Map<String, dynamic> json) => GuestBook(
        id: json['id'],
        artist_info_id: json['artist_info_id'],
        member_id: json['member_id'],
        content: json['content'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'artist_info_id': artist_info_id,
        'member_id': member_id,
        'content': content,
      };
}
