// fetchArtist()
// fetchArtists()

import 'package:aria_client/helpers/env.dart';
import 'package:aria_client/helpers/network_adapter.dart';
import 'package:aria_client/models/art.dart';
import 'package:aria_client/models/artist_info.dart';
import 'package:aria_client/models/member.dart';
import 'package:aria_client/viewmodels/auth/signin_viewmodel.dart';
import 'package:get/get.dart';

class ArtistService extends GetxService {
  Future<ArtistInfo?> fetchArtist(int memberId) async {
    final SigninViewModel signinViewModel = Get.find<SigninViewModel>();
    if (Env.env == Environ.test) {
      return ArtistInfo(
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
      );
    } else {
      // TODO: fetch from API
      final response = await NetworkAdapter().get(
        path: '/artist-info-details',
        params: {'artistId': memberId},
        token: signinViewModel.jwt,
      );
      if (response['statusCode'] == 200) {
        return ArtistInfo.fromJson(response['body']);
      }
      return null;
    }
  }

  Future<List<Art>?> fetchArtistArts(int memberId) async {
    final SigninViewModel signinViewModel = Get.find<SigninViewModel>();
    if (Env.env == Environ.test) {
      return [];
    } else {
      final response = await NetworkAdapter().get(
        path: '/arts/artists/$memberId',
        params: {
          'artistId': memberId,
          'page': 0,
          'count': 20
        }, // TODO: remove paging hardcoding
        token: signinViewModel.jwt,
      );
      if (response['statusCode'] == 200) {
        return response['body'].map<Art>((e) => Art.fromJson(e)).toList();
      }
      return [];
    }
  }

  Future<void> addArt() async {
    return;
  }

  Future<List<Member>> fetchFollowers() async {
    return [];
  }

  Future<List<Art>> fetchMyArts() async {
    return [];
  }

  Future<void> follow(int memberId) async {
    final SigninViewModel signinViewModel = Get.find<SigninViewModel>();
    final response = await NetworkAdapter().post(
      path: '/follows/?followeeId=$memberId',
      params: {},
      accessToken: signinViewModel.jwt,
    );
    // TODO: map 형태로 반환하여 예외처리하도록
    if (response['statusCode'] == 201) {
      return;
    }
    return;
  }

  Future<void> unfollow(int memberId) async {
    final SigninViewModel signinViewModel = Get.find<SigninViewModel>();
    final response = await NetworkAdapter().delete(
      path: '/follows/?followeeId=$memberId',
      params: {},
      token: signinViewModel.jwt,
    );
    return;
  }
}
