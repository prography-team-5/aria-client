import 'package:aria_client/models/size.dart';

class Art {
  final int artId;
  final int memberId;
  final String mainImageUrl;
  final String style;
  final String title;
  final int year;
  final List<String> artTags;
  final Size size;
  final String description;

  Art({
    required this.artId,
    required this.memberId,
    required this.mainImageUrl,
    required this.style,
    required this.title,
    required this.year,
    required this.artTags,
    required this.size,
    required this.description,
  });

  factory Art.fromJson(Map<String, dynamic> json) => Art(
    artId: json['artId'],
    memberId: json['memberId'],
    mainImageUrl: json['mainImageUrl'],
    style: json['style'],
    title: json['title'],
    year: json['year'],
    artTags: json['artTags'],
    size: json['size'],
    description: json['description'],
  );

  Map<String, dynamic> toJson() => {
    'artId': artId,
    'memberId': memberId,
    'mainImageUrl': mainImageUrl,
    'style': style,
    'title': title,
    'year': year,
    'artTags' : artTags,
    'size': size,
    'description': description,
  };
}