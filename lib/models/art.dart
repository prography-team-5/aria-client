import 'package:aria_client/models/size.dart';

class Art {
  final int artId;
  final int memberId;
  final String? artistNickname;
  final String? mainImageUrl;
  final List<String>? imagesUrl;
  final String style;
  final String title;
  final int year;
  final List<String> artTags;
  final Size size;
  final String description;

  Art({
    required this.artId,
    required this.memberId,
    this.artistNickname,
    this.mainImageUrl,
    this.imagesUrl,
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
    artistNickname: json['artistNickname'],
    mainImageUrl: json['mainImageUrl'],
    imagesUrl: json['imagesUrl'],
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
    'artistNickname': artistNickname,
    'mainImageUrl': mainImageUrl,
    'imagesUrl': imagesUrl,
    'style': style,
    'title': title,
    'year': year,
    'artTags' : artTags,
    'size': size,
    'description': description,
  };
}