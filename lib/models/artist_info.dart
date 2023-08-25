// TODO: make model class following json schema

class ArtistInfo {
  final String profile_art_image_url;
  final ArtistProfile artist_profile;
  final String intro;
  final List<ArtistTag> artist_tags;
  final List<SocialLink> social_links;
  final bool isFollowee;
  final int follower_count;

  ArtistInfo({
    required this.profile_art_image_url,
    required this.artist_profile,
    required this.intro,
    required this.artist_tags,
    required this.social_links,
    required this.isFollowee,
    required this.follower_count,
  });

  factory ArtistInfo.fromJson(Map<String, dynamic> json) {
    return ArtistInfo(
      profile_art_image_url: json['profileArtImageUrl'],
      artist_profile: ArtistProfile.fromJson(json['artistProfile']),
      intro: json['intro'] ?? '',
      artist_tags: json['artistTags']
          .map<ArtistTag>((e) => ArtistTag.fromJson(e))
          .toList(),
      social_links: json['socialLinks']
          .map<SocialLink>((e) => SocialLink.fromJson(e))
          .toList(),
      isFollowee: json['isFollowee'],
      follower_count: json['followerCount'],
    );
  }
}

class ArtistProfile {
  final int member_id;
  final String profile_image_url;
  final String nickname;

  ArtistProfile({
    required this.member_id,
    required this.profile_image_url,
    required this.nickname,
  });

  factory ArtistProfile.fromJson(Map<String, dynamic> json) {
    return ArtistProfile(
      member_id: json['memberId'],
      profile_image_url: json['profileImageUrl'],
      nickname: json['nickname'],
    );
  }
}

class ArtistTag {
  final int artist_tag_id;
  final String name;

  ArtistTag({
    required this.artist_tag_id,
    required this.name,
  });

  factory ArtistTag.fromJson(Map<String, dynamic> json) {
    return ArtistTag(
      artist_tag_id: json['artistTagId'],
      name: json['name'],
    );
  }
}

class SocialLink {
  final int social_link_id;
  final String social_type;
  final String url;

  SocialLink({
    required this.social_link_id,
    required this.social_type,
    required this.url,
  });

  factory SocialLink.fromJson(Map<String, dynamic> json) {
    return SocialLink(
      social_link_id: json['socialLinkId'],
      social_type: json['socialType'],
      url: json['url'],
    );
  }
}
