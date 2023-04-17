class Art {
  final int id;
  final int member_id;
  final String image_url;
  final String title;
  final int year;
  final String style;
  final int size;
  final String description;

  Art({
    required this.id,
    required this.member_id,
    required this.image_url,
    required this.title,
    required this.year,
    required this.style,
    required this.size,
    required this.description,
  });

  factory Art.fromJson(Map<String, dynamic> json) => Art(
    id: json['id'],
    member_id: json['member_id'],
    image_url: json['image_url'],
    title: json['title'],
    year: json['year'],
    style: json['style'],
    size: json['size'],
    description: json['description'],
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'member_id': member_id,
    'image_url': image_url,
    'title': title,
    'year': year,
    'style': style,
    'size': size,
    'description': description,
  };
}