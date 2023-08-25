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
            id: 1,
            member_id: 1,
            profile_art_image_url:
                'https://img1.daumcdn.net/thumb/R800x0/?scode=mtistory2&fname=https%3A%2F%2Fblog.kakaocdn.net%2Fdn%2FctPGwk%2FbtrUvU5ZKOb%2FL5IR7GxdBKqU5o221GDKRk%2Fimg.png',
            intro: ''),
        ArtistInfo(
            id: 2,
            member_id: 2,
            profile_art_image_url:
                'https://img1.daumcdn.net/thumb/R800x0/?scode=mtistory2&fname=https%3A%2F%2Fblog.kakaocdn.net%2Fdn%2FctPGwk%2FbtrUvU5ZKOb%2FL5IR7GxdBKqU5o221GDKRk%2Fimg.png',
            intro: ''),
        ArtistInfo(
            id: 3,
            member_id: 3,
            profile_art_image_url:
                'https://img1.daumcdn.net/thumb/R800x0/?scode=mtistory2&fname=https%3A%2F%2Fblog.kakaocdn.net%2Fdn%2FctPGwk%2FbtrUvU5ZKOb%2FL5IR7GxdBKqU5o221GDKRk%2Fimg.png',
            intro: ''),
        ArtistInfo(
            id: 4,
            member_id: 4,
            profile_art_image_url:
                'https://img1.daumcdn.net/thumb/R800x0/?scode=mtistory2&fname=https%3A%2F%2Fblog.kakaocdn.net%2Fdn%2FctPGwk%2FbtrUvU5ZKOb%2FL5IR7GxdBKqU5o221GDKRk%2Fimg.png',
            intro: ''),
        ArtistInfo(
            id: 5,
            member_id: 5,
            profile_art_image_url:
                'https://img1.daumcdn.net/thumb/R800x0/?scode=mtistory2&fname=https%3A%2F%2Fblog.kakaocdn.net%2Fdn%2FctPGwk%2FbtrUvU5ZKOb%2FL5IR7GxdBKqU5o221GDKRk%2Fimg.png',
            intro: ''),
        ArtistInfo(
            id: 6,
            member_id: 6,
            profile_art_image_url:
                'https://img1.daumcdn.net/thumb/R800x0/?scode=mtistory2&fname=https%3A%2F%2Fblog.kakaocdn.net%2Fdn%2FctPGwk%2FbtrUvU5ZKOb%2FL5IR7GxdBKqU5o221GDKRk%2Fimg.png',
            intro: ''),
        ArtistInfo(
            id: 7,
            member_id: 7,
            profile_art_image_url:
                'https://img1.daumcdn.net/thumb/R800x0/?scode=mtistory2&fname=https%3A%2F%2Fblog.kakaocdn.net%2Fdn%2FctPGwk%2FbtrUvU5ZKOb%2FL5IR7GxdBKqU5o221GDKRk%2Fimg.png',
            intro: ''),
        ArtistInfo(
            id: 8,
            member_id: 8,
            profile_art_image_url:
                'https://img1.daumcdn.net/thumb/R800x0/?scode=mtistory2&fname=https%3A%2F%2Fblog.kakaocdn.net%2Fdn%2FctPGwk%2FbtrUvU5ZKOb%2FL5IR7GxdBKqU5o221GDKRk%2Fimg.png',
            intro: ''),
        ArtistInfo(
            id: 9,
            member_id: 9,
            profile_art_image_url:
                'https://img1.daumcdn.net/thumb/R800x0/?scode=mtistory2&fname=https%3A%2F%2Fblog.kakaocdn.net%2Fdn%2FctPGwk%2FbtrUvU5ZKOb%2FL5IR7GxdBKqU5o221GDKRk%2Fimg.png',
            intro: ''),
        ArtistInfo(
            id: 9,
            member_id: 9,
            profile_art_image_url:
                'https://img1.daumcdn.net/thumb/R800x0/?scode=mtistory2&fname=https%3A%2F%2Fblog.kakaocdn.net%2Fdn%2FctPGwk%2FbtrUvU5ZKOb%2FL5IR7GxdBKqU5o221GDKRk%2Fimg.png',
            intro: ''),
        ArtistInfo(
            id: 9,
            member_id: 9,
            profile_art_image_url:
                'https://img1.daumcdn.net/thumb/R800x0/?scode=mtistory2&fname=https%3A%2F%2Fblog.kakaocdn.net%2Fdn%2FctPGwk%2FbtrUvU5ZKOb%2FL5IR7GxdBKqU5o221GDKRk%2Fimg.png',
            intro: ''),
        ArtistInfo(
            id: 9,
            member_id: 9,
            profile_art_image_url:
                'https://img1.daumcdn.net/thumb/R800x0/?scode=mtistory2&fname=https%3A%2F%2Fblog.kakaocdn.net%2Fdn%2FctPGwk%2FbtrUvU5ZKOb%2FL5IR7GxdBKqU5o221GDKRk%2Fimg.png',
            intro: ''),
        ArtistInfo(
            id: 9,
            member_id: 9,
            profile_art_image_url:
                'https://img1.daumcdn.net/thumb/R800x0/?scode=mtistory2&fname=https%3A%2F%2Fblog.kakaocdn.net%2Fdn%2FctPGwk%2FbtrUvU5ZKOb%2FL5IR7GxdBKqU5o221GDKRk%2Fimg.png',
            intro: ''),
        ArtistInfo(
            id: 9,
            member_id: 9,
            profile_art_image_url:
                'https://img1.daumcdn.net/thumb/R800x0/?scode=mtistory2&fname=https%3A%2F%2Fblog.kakaocdn.net%2Fdn%2FctPGwk%2FbtrUvU5ZKOb%2FL5IR7GxdBKqU5o221GDKRk%2Fimg.png',
            intro: ''),
      ];
    }
    return followeeList;
  }
}
