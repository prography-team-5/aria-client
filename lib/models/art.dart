import 'package:aria_client/models/size.dart';

class Art {
  final int? artId;
  final int? memberId;
  final String? artistNickname;
  final String? artistProfileImageUrl;
  final String? mainImageUrl;
  final List<String>? imagesUrl;
  final String style;
  final String title;
  final int year;
  final List<dynamic>? artTags;
  final Size size;
  final String? description;
  final List<Sns>? artistSocialLinks;

  Art({
    this.artId,
    this.memberId,
    this.artistNickname,
    this.artistProfileImageUrl,
    this.mainImageUrl,
    this.imagesUrl,
    required this.style,
    required this.title,
    required this.year,
    this.artTags,
    required this.size,
    this.description,
    this.artistSocialLinks,
  });

  factory Art.fromJson(Map<String, dynamic> json) => Art(
        artId: json['artId'],
        memberId: json['memberId'],
        artistNickname: json['artistNickname'],
        artistProfileImageUrl: json['artistProfileImageUrl'],
        mainImageUrl: json['mainImageUrl'],
        imagesUrl: (json['imagesUrl'] as List?)?.map((item) => item as String).toList(),
        style: json['style'],
        title: json['title'],
        year: json['year'],
        artTags: json['artTags'],
        size: Size.fromJson(json['size']),
        description: json['description'],
        artistSocialLinks: (json['artistSocialLinks'] as List?)
            ?.map((item) => Sns.fromJson(item))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'artId': artId,
        'memberId': memberId,
        'artistNickname': artistNickname,
        'artistProfileImageUrl': artistProfileImageUrl,
        'mainImageUrl': mainImageUrl,
        'imagesUrl': imagesUrl,
        'style': style,
        'title': title,
        'year': year,
        'artTags': artTags,
        'size': size,
        'description': description,
        'artistSocialLinks': artistSocialLinks,
      };
}

class Sns {
  final String url;
  final String socialType;

  Sns({
    required this.url,
    required this.socialType,
  });

  factory Sns.fromJson(Map<String, dynamic> json) => Sns(
        url: json['url'],
        socialType: json['socialType'],
      );

  Map<String, dynamic> toJson() => {
        'url': url,
        'socialType': socialType,
      };
}
