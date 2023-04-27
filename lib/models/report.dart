class Report {
  final int id;
  final int member_id;
  final int target_id;
  final String title;
  final String content;
  final String type;

  Report({
    required this.id,
    required this.member_id,
    required this.target_id,
    required this.title,
    required this.content,
    required this.type,
  });

  factory Report.fromJson(Map<String, dynamic> json) => Report(
        id: json['id'],
        member_id: json['member_id'],
        target_id: json['target_id'],
        title: json['title'],
        content: json['content'],
        type: json['type'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'member_id': member_id,
        'target_id': target_id,
        'title': title,
        'content': content,
        'type': type,
      };
}
