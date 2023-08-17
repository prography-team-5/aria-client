// fetchProfile()
// updateProfile()

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
      followeeList = (response['body']['data'] as List)
          .map((e) => ArtistInfo.fromJson(e))
          .toList();
    } else {
      followeeList = [];
    }
    // DEV
    return [
      ArtistInfo(
          id: 1,
          member_id: 1,
          profile_art_image_url: 'https://picsum.photos/200/300',
          intro: ''),
      ArtistInfo(
          id: 2,
          member_id: 2,
          profile_art_image_url: 'https://picsum.photos/200/300',
          intro: ''),
      ArtistInfo(
          id: 3,
          member_id: 3,
          profile_art_image_url: 'https://picsum.photos/200/300',
          intro: ''),
      ArtistInfo(
          id: 4,
          member_id: 4,
          profile_art_image_url: 'https://picsum.photos/200/300',
          intro: ''),
      ArtistInfo(
          id: 5,
          member_id: 5,
          profile_art_image_url: 'https://picsum.photos/200/300',
          intro: ''),
      ArtistInfo(
          id: 6,
          member_id: 6,
          profile_art_image_url: 'https://picsum.photos/200/300',
          intro: ''),
      ArtistInfo(
          id: 7,
          member_id: 7,
          profile_art_image_url: 'https://picsum.photos/200/300',
          intro: ''),
      ArtistInfo(
          id: 8,
          member_id: 8,
          profile_art_image_url: 'https://picsum.photos/200/300',
          intro: ''),
      ArtistInfo(
          id: 9,
          member_id: 9,
          profile_art_image_url: 'https://picsum.photos/200/300',
          intro: ''),
      ArtistInfo(
          id: 9,
          member_id: 9,
          profile_art_image_url: 'https://picsum.photos/200/300',
          intro: ''),
      ArtistInfo(
          id: 9,
          member_id: 9,
          profile_art_image_url: 'https://picsum.photos/200/300',
          intro: ''),
      ArtistInfo(
          id: 9,
          member_id: 9,
          profile_art_image_url: 'https://picsum.photos/200/300',
          intro: ''),
      ArtistInfo(
          id: 9,
          member_id: 9,
          profile_art_image_url: 'https://picsum.photos/200/300',
          intro: ''),
      ArtistInfo(
          id: 9,
          member_id: 9,
          profile_art_image_url: 'https://picsum.photos/200/300',
          intro: ''),
    ];
    return followeeList;
  }
}
