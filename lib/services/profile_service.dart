// fetchProfile()
// updateProfile()

import 'package:aria_client/helpers/env.dart';
import 'package:aria_client/helpers/network_adapter.dart';
import 'package:aria_client/models/artist_info.dart';
import 'package:get/get.dart';

import '../viewmodels/auth/signin_viewmodel.dart';

class ProfileService extends GetxService {
  Future<List<ArtistInfo>> fetchFolloweeList() async {
    final signInViewModel = Get.find<SigninViewModel>();
    List<ArtistInfo> followeeList = [];
    Map<String, dynamic> response = await NetworkAdapter().get(
        path: '/follows/followees/me', params: {}, token: signInViewModel.jwt);
    if (response['statusCode'] == 200) {
      followeeList = (response['body'] as List)
          .map((e) => ArtistInfo.fromJson(e))
          .toList();
    } else {
      followeeList = [];
    }
    // DEV
    if (Env.env == Environ.test) {
      return [
        ArtistInfo(
          profile_art_image_url: 'https://picsum.photos/200',
          artist_profile: ArtistProfile(
            member_id: 1,
            profile_image_url: 'https://picsum.photos/200',
            nickname: '테스트',
          ),
          intro: '안녕하세요',
          artist_tags: [
            ArtistTag(artist_tag_id: 1, name: '그림'),
            ArtistTag(artist_tag_id: 2, name: '디자인'),
            ArtistTag(artist_tag_id: 3, name: '사진'),
          ],
          social_links: [
            SocialLink(
                social_link_id: 1,
                social_type: 'instagram',
                url: 'https://www.instagram.com/'),
            SocialLink(
                social_link_id: 2,
                social_type: 'facebook',
                url: 'https://www.facebook.com/'),
            SocialLink(
                social_link_id: 3,
                social_type: 'twitter',
                url: 'https://www.twitter.com/'),
          ],
          isFollowee: true,
          follower_count: 100,
        ),
        ArtistInfo(
          profile_art_image_url: 'https://picsum.photos/200',
          artist_profile: ArtistProfile(
            member_id: 1,
            profile_image_url: 'https://picsum.photos/200',
            nickname: '테스트',
          ),
          intro: '안녕하세요',
          artist_tags: [
            ArtistTag(artist_tag_id: 1, name: '그림'),
            ArtistTag(artist_tag_id: 2, name: '디자인'),
            ArtistTag(artist_tag_id: 3, name: '사진'),
          ],
          social_links: [
            SocialLink(
                social_link_id: 1,
                social_type: 'instagram',
                url: 'https://www.instagram.com/'),
            SocialLink(
                social_link_id: 2,
                social_type: 'facebook',
                url: 'https://www.facebook.com/'),
            SocialLink(
                social_link_id: 3,
                social_type: 'twitter',
                url: 'https://www.twitter.com/'),
          ],
          isFollowee: true,
          follower_count: 100,
        ),
      ];
    }
    return followeeList;
  }
}
