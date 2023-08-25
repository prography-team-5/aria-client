import 'dart:io';

import 'package:aria_client/helpers/env.dart';
import 'package:aria_client/helpers/network_adapter.dart';
import 'package:aria_client/models/art.dart';
import 'package:aria_client/models/size.dart';
import 'package:aria_client/viewmodels/auth/signin_viewmodel.dart';
import 'package:get/get.dart';

class ArtService extends GetxService {
  NetworkAdapter networkAdapter = NetworkAdapter();
  final signInViewModel = Get.find<SigninViewModel>();

  Future<Map<String, dynamic>> fetchArtDetails(int artId) async {
    Art artInfo;
    // if (Env.env == Environ.dev) {
    //   artInfo = Art(
    //       artistNickname: '작가 아리아',
    //       artistProfileImageUrl:
    //           'https://i.pinimg.com/564x/9c/d3/ba/9cd3ba37ee042e5d610c100670473f18.jpg',
    //       imagesUrl: [
    //         'https://i.pinimg.com/564x/63/17/70/6317705051deb0f18512f35dd5da9e0c.jpg',
    //         'https://i.pinimg.com/564x/f8/32/9d/f8329dc4cc8fa50086be9abc710124ea.jpg',
    //         'https://i.pinimg.com/564x/82/0b/91/820b91b0ed6f1d37f4688da8eaf030fa.jpg'
    //       ],
    //       title: '[from view model] 작가의 작품 제목 공간인데요 어디까지 쓸 수 있는지 테스트를 진행하고 있',
    //       year: 2021,
    //       style: '아크릴 캔버스',
    //       artTags: ['현대', '아크릴', '공예 캔버스'],
    //       size: Size(width: 30.5, height: 30.8),
    //       description:
    //           '[from view model] 작품 설명 작품 설명 작품 설명 작품 설명 작품 설명 작품 설명 작품 설명 작품 설명 작품 설명 작품 설명 작품 설명 작품 설명 작품 설명 작품 설명 작품 설명 작품 설명 작품 설명 작품 설명 작품 설명 작품 설명 작품 설명 작품 설명 작품 설명 작품 설명 작품 설명 작품 설명 작품 설명 작품 설명');
    //   return {'artInfo': artInfo};
    // }

    Map<String, dynamic> data = await networkAdapter
        .get(path: '/arts/$artId', params: {}, token: signInViewModel.jwt);
    if (data['statusCode'] == 200) {
      artInfo = Art.fromJson(data['body']);
      return {'artInfo': artInfo};
    } else
      exit(200);
  }

  Future<List<Art>> fetchArts() async {
    if (Env.env == Environ.dev) {
      return [
        Art(
            artId: 1,
            memberId: 1,
            mainImageUrl:
                'https://i.pinimg.com/564x/82/0b/91/820b91b0ed6f1d37f4688da8eaf030fa.jpg',
            style: '아크릴 캔버스',
            title: 'Art Title',
            year: 2021,
            artTags: ['현대대대대대대ㅐ', '아크릴아아아ㅏ', '공예 캔버스'],
            size: Size(width: 100.34, height: 50.28),
            description: '혼란한 공간의 구원자라는 존재를 기존의 상식과는 다르게 비틀어 반영웅적인 이미지를 만들고.'
                '혼란한 공간의 구원자라는 존재를 기존의 상식과는 다르게 비틀어 반영웅적인 이미지를 만들고.'
                '혼란한 공간의 구원자라는 존재를 기존의 상식과는 다르게 비틀어 반영웅적인 이미지를 만들고.'),
        Art(
            artId: 1,
            memberId: 1,
            mainImageUrl:
                'https://i.pinimg.com/564x/82/0b/91/820b91b0ed6f1d37f4688da8eaf030fa.jpg',
            style: '아크릴 캔버스',
            title: 'Art Title',
            year: 2021,
            artTags: ['현대대대대대대ㅐ', '아크릴아아아ㅏ', '공예 캔버스'],
            size: Size(width: 100.34, height: 50.28),
            description: '혼란한 공간의 구원자라는 존재를 기존의 상식과는 다르게 비틀어 반영웅적인 이미지를 만들고.'
                '혼란한 공간의 구원자라는 존재를 기존의 상식과는 다르게 비틀어 반영웅적인 이미지를 만들고.'
                '혼란한 공간의 구원자라는 존재를 기존의 상식과는 다르게 비틀어 반영웅적인 이미지를 만들고.'),
        Art(
            artId: 2,
            memberId: 1,
            mainImageUrl:
                'https://i.pinimg.com/564x/42/9f/14/429f142e244ac812ce81d32030e1191b.jpg',
            style: '아크릴 캔버스',
            title: 'Art Title 2',
            year: 2023,
            artTags: ['현대', '아크릴'],
            size: Size(width: 100.28, height: 50.4),
            description:
                '혼란한 공간의 구원자라는 존재를 기존의 상식과는 다르게 비틀어 반영웅적인 이미지를 만들고.\n\n'
                '혼란한 공간의 구원자라는 존재를 기존의 상식과는 다르게 비틀어 반영웅적인 이미지를 만들고.'
                '혼란한 공간의 구원자라는 존재를 기존의 상식과는 다르게 비틀어 반영웅적인 이미지를 만들고.\n\n'
                '혼란한 공간의 구원자라는 존재를 기존의 상식과는 다르게 비틀어 반영웅적인 이미지를 만들고.'
                '혼란한 공간의 구원자라는 존재를 기존의 상식과는 다르게 비틀어 반영웅적인 이미지를 만들고.\n\n'
                '혼란한 공간의 구원자라는 존재를 기존의 상식과는 다르게 비틀어 반영웅적인 이미지를 만들고.'
                '혼란한 공간의 구원자라는 존재를 기존의 상식과는 다르게 비틀어 반영웅적인 이미지를 만들고.\n\n'
                '혼란한 공간의 구원자라는 존재를 기존의 상식과는 다르게 비틀어 반영웅적인 이미지를 만들고.'
                '혼란한 공간의 구원자라는 존재를 기존의 상식과는 다르게 비틀어 반영웅적인 이미지를 만들고.\n\n'
                '혼란한 공간의 구원자라는 존재를 기존의 상식과는 다르게 비틀어 반영웅적인 이미지를 만들고.'),
        Art(
            artId: 3,
            memberId: 1,
            mainImageUrl:
                'https://i.pinimg.com/564x/9c/d3/ba/9cd3ba37ee042e5d610c100670473f18.jpg',
            style: '아크릴 캔버스',
            title: '일러스트',
            year: 2023,
            artTags: ['현대', '아크릴', '공예 캔버스'],
            size: Size(width: 100.28, height: 50.4),
            description: 'Art Description'),
        Art(
            artId: 4,
            memberId: 1,
            mainImageUrl:
                'https://i.pinimg.com/564x/d9/17/15/d9171548cadc8164d8e987b160e51286.jpg',
            style: '아크릴 캔버스',
            title: 'Art Title 4',
            year: 2023,
            artTags: ['현대', '아크릴', '공예 캔버스'],
            size: Size(width: 100.28, height: 50.4),
            description: 'Art Description'),
        Art(
            artId: 5,
            memberId: 1,
            mainImageUrl:
                'https://i.pinimg.com/564x/f8/32/9d/f8329dc4cc8fa50086be9abc710124ea.jpg',
            style: '아크릴 캔버스',
            title: 'Art Title 5',
            year: 2023,
            artTags: ['현대', '아크릴', '공예 캔버스'],
            size: Size(width: 100.28, height: 50.4),
            description: 'Art Description'),
        Art(
            artId: 6,
            memberId: 1,
            mainImageUrl:
                'https://i.pinimg.com/564x/63/17/70/6317705051deb0f18512f35dd5da9e0c.jpg',
            style: '아크릴 캔버스',
            title: 'Art Title 6',
            year: 2023,
            artTags: ['현대', '아크릴', '공예 캔버스'],
            size: Size(width: 100.28, height: 50.4),
            description: 'Art Description'),
      ];
    }

    // TODO: fetch from API
    return [];
  }

  Future<Map<String, dynamic>> fetchArtsApi(int count) async {
    List<Art> artsList;
    List<dynamic> artsListTmp;

    if (Env.env != Environ.dev) {
      artsList = [
        Art(
            artId: 1,
            memberId: 1,
            mainImageUrl:
                'https://i.pinimg.com/564x/82/0b/91/820b91b0ed6f1d37f4688da8eaf030fa.jpg',
            style: '아크릴 캔버스',
            title: 'Art Title',
            year: 2021,
            artTags: ['현대대대대대대ㅐ', '아크릴아아아ㅏ', '공예 캔버스'],
            size: Size(width: 100.34, height: 50.28),
            description: '혼란한 공간의 구원자라는 존재를 기존의 상식과는 다르게 비틀어 반영웅적인 이미지를 만들고.'
                '혼란한 공간의 구원자라는 존재를 기존의 상식과는 다르게 비틀어 반영웅적인 이미지를 만들고.'
                '혼란한 공간의 구원자라는 존재를 기존의 상식과는 다르게 비틀어 반영웅적인 이미지를 만들고.'),
        Art(
            artId: 2,
            memberId: 1,
            mainImageUrl:
                'https://i.pinimg.com/564x/42/9f/14/429f142e244ac812ce81d32030e1191b.jpg',
            style: '아크릴 캔버스',
            title: 'Art Title 2',
            year: 2023,
            artTags: ['현대', '아크릴'],
            size: Size(width: 100.28, height: 50.4),
            description:
                '혼란한 공간의 구원자라는 존재를 기존의 상식과는 다르게 비틀어 반영웅적인 이미지를 만들고.\n\n'
                '혼란한 공간의 구원자라는 존재를 기존의 상식과는 다르게 비틀어 반영웅적인 이미지를 만들고.'
                '혼란한 공간의 구원자라는 존재를 기존의 상식과는 다르게 비틀어 반영웅적인 이미지를 만들고.\n\n'
                '혼란한 공간의 구원자라는 존재를 기존의 상식과는 다르게 비틀어 반영웅적인 이미지를 만들고.'
                '혼란한 공간의 구원자라는 존재를 기존의 상식과는 다르게 비틀어 반영웅적인 이미지를 만들고.\n\n'
                '혼란한 공간의 구원자라는 존재를 기존의 상식과는 다르게 비틀어 반영웅적인 이미지를 만들고.'
                '혼란한 공간의 구원자라는 존재를 기존의 상식과는 다르게 비틀어 반영웅적인 이미지를 만들고.\n\n'
                '혼란한 공간의 구원자라는 존재를 기존의 상식과는 다르게 비틀어 반영웅적인 이미지를 만들고.'
                '혼란한 공간의 구원자라는 존재를 기존의 상식과는 다르게 비틀어 반영웅적인 이미지를 만들고.\n\n'
                '혼란한 공간의 구원자라는 존재를 기존의 상식과는 다르게 비틀어 반영웅적인 이미지를 만들고.'),
        Art(
            artId: 3,
            memberId: 1,
            mainImageUrl:
                'https://i.pinimg.com/564x/9c/d3/ba/9cd3ba37ee042e5d610c100670473f18.jpg',
            style: '아크릴 캔버스',
            title: '일러스트',
            year: 2023,
            artTags: ['현대', '아크릴', '공예 캔버스'],
            size: Size(width: 100.28, height: 50.4),
            description: 'Art Description'),
        Art(
            artId: 4,
            memberId: 1,
            mainImageUrl:
                'https://i.pinimg.com/564x/d9/17/15/d9171548cadc8164d8e987b160e51286.jpg',
            style: '아크릴 캔버스',
            title: 'Art Title 4',
            year: 2023,
            artTags: ['현대', '아크릴', '공예 캔버스'],
            size: Size(width: 100.28, height: 50.4),
            description: 'Art Description'),
        Art(
            artId: 5,
            memberId: 1,
            mainImageUrl:
                'https://i.pinimg.com/564x/f8/32/9d/f8329dc4cc8fa50086be9abc710124ea.jpg',
            style: '아크릴 캔버스',
            title: 'Art Title 5',
            year: 2023,
            artTags: ['현대', '아크릴', '공예 캔버스'],
            size: Size(width: 100.28, height: 50.4),
            description: 'Art Description'),
        Art(
            artId: 6,
            memberId: 1,
            mainImageUrl:
                'https://i.pinimg.com/564x/63/17/70/6317705051deb0f18512f35dd5da9e0c.jpg',
            style: '아크릴 캔버스',
            title: 'Art Title 6',
            year: 2023,
            artTags: ['현대', '아크릴', '공예 캔버스'],
            size: Size(width: 100.28, height: 50.4),
            description: 'Art Description'),
      ];
      return {'artsList': artsList};
    }

    Map<String, dynamic> data = await networkAdapter
        .get(path: '/arts/random', params: {'count': count});
    //TODO: error 처리
    if (data['statusCode'] == 200) {
      artsListTmp = data['body']
          .map((item) {
            return Art.fromJson(item);
          })
          .toList()
          ?.cast<Art>();
      return {'artsList': artsListTmp};
    } else
      exit(200);
  }

  Future<Map<String, dynamic>> fetchSearchedArts(String query, int page, int count) async {
    List<Art> artsList;
    if (Env.env != Environ.dev) {
      artsList = [
        Art(
            artId: 1,
            memberId: 1,
            mainImageUrl:
            'https://i.pinimg.com/564x/82/0b/91/820b91b0ed6f1d37f4688da8eaf030fa.jpg',
            style: '아크릴 캔버스',
            title: 'Art Title',
            year: 2021,
            artTags: ['현대대대대대대ㅐ', '아크릴아아아ㅏ', '공예 캔버스'],
            size: Size(width: 100.34, height: 50.28),
            description: '혼란한 공간의 구원자라는 존재를 기존의 상식과는 다르게 비틀어 반영웅적인 이미지를 만들고.'
                '혼란한 공간의 구원자라는 존재를 기존의 상식과는 다르게 비틀어 반영웅적인 이미지를 만들고.'
                '혼란한 공간의 구원자라는 존재를 기존의 상식과는 다르게 비틀어 반영웅적인 이미지를 만들고.'),
        Art(
            artId: 2,
            memberId: 1,
            mainImageUrl:
            'https://i.pinimg.com/564x/42/9f/14/429f142e244ac812ce81d32030e1191b.jpg',
            style: '아크릴 캔버스',
            title: 'Art Title 2',
            year: 2023,
            artTags: ['현대', '아크릴'],
            size: Size(width: 100.28, height: 50.4),
            description: '혼란한 공간의 구원자라는 존재를 기존의 상식과는 다르게 비틀어 반영웅적인 이미지를 만들고.\n\n'
                '혼란한 공간의 구원자라는 존재를 기존의 상식과는 다르게 비틀어 반영웅적인 이미지를 만들고.'
                '혼란한 공간의 구원자라는 존재를 기존의 상식과는 다르게 비틀어 반영웅적인 이미지를 만들고.\n\n'
                '혼란한 공간의 구원자라는 존재를 기존의 상식과는 다르게 비틀어 반영웅적인 이미지를 만들고.'
                '혼란한 공간의 구원자라는 존재를 기존의 상식과는 다르게 비틀어 반영웅적인 이미지를 만들고.\n\n'
                '혼란한 공간의 구원자라는 존재를 기존의 상식과는 다르게 비틀어 반영웅적인 이미지를 만들고.'
                '혼란한 공간의 구원자라는 존재를 기존의 상식과는 다르게 비틀어 반영웅적인 이미지를 만들고.\n\n'
                '혼란한 공간의 구원자라는 존재를 기존의 상식과는 다르게 비틀어 반영웅적인 이미지를 만들고.'
                '혼란한 공간의 구원자라는 존재를 기존의 상식과는 다르게 비틀어 반영웅적인 이미지를 만들고.\n\n'
                '혼란한 공간의 구원자라는 존재를 기존의 상식과는 다르게 비틀어 반영웅적인 이미지를 만들고.'),
      ];
      return {'artsList': artsList};
    }

    Map<String, dynamic> data = await networkAdapter
        .get(path: '/arts/search', params: {'query': query, 'page': page, 'count': count}, token: signInViewModel.jwt);
    //TODO: error 처리
    if (data['statusCode'] == 200) {
      artsList = data['body']
          .map((item) {
        return Art.fromJson(item);
      })
          .toList()
          ?.cast<Art>();
      return {'artsList': artsList};
    } else
      exit(200);
  }
}
