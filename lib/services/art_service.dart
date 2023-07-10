// fetchArt()
// fetchArts()
// ...

import 'package:aria_client/helpers/env.dart';
import 'package:aria_client/models/art.dart';
import 'package:aria_client/models/size.dart';
import 'package:get/get.dart';

class ArtService extends GetxService {
  Future<Art?> fetchArt() async {
    if (Env.env == Environ.dev) {
      return Art(
          artId: 1,
          memberId: 1,
          mainImageUrl: 'assets/images/example_image.png',
          style: '아크릴 캔버스',
          title: 'Art Title',
          year: 2021,
          artTags: ['현대', '아크릴', '공예 캔버스'],
          size: Size(width: 100, height: 100),
          description: 'Art Description');
    } else {
      // TODO: fetch from API
      return null;
    }
  }

  Future<List<Art>?> fetchArts() async {
    if (Env.env == Environ.dev) {
      return [
        Art(
            artId: 1,
            memberId: 1,
            mainImageUrl: 'assets/images/example_image.png',
            style: '아크릴 캔버스',
            title: 'Art Title',
            year: 2021,
            artTags: ['현대', '아크릴', '공예 캔버스'],
            size: Size(width: 100, height: 100),
            description: '혼란한 공간의 구원자라는 존재를 기존의 상식과는 다르게 비틀어 반영웅적인 이미지를 만들고.'
                '혼란한 공간의 구원자라는 존재를 기존의 상식과는 다르게 비틀어 반영웅적인 이미지를 만들고.'
                '혼란한 공간의 구원자라는 존재를 기존의 상식과는 다르게 비틀어 반영웅적인 이미지를 만들고.'),
        Art(
            artId: 2,
            memberId: 1,
            mainImageUrl: 'assets/images/example_image_2.jpg',
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
        Art(
            artId: 3,
            memberId: 1,
            mainImageUrl: 'assets/images/example_image_2.jpg',
            style: '아크릴 캔버스',
            title: 'Art Title 3',
            year: 2023,
            artTags: ['현대', '아크릴', '공예 캔버스'],
            size: Size(width: 100.28, height: 50.4),
            description: 'Art Description'),
        Art(
            artId: 4,
            memberId: 1,
            mainImageUrl: 'assets/images/example_image_2.jpg',
            style: '아크릴 캔버스',
            title: 'Art Title 4',
            year: 2023,
            artTags: ['현대', '아크릴', '공예 캔버스'],
            size: Size(width: 100.28, height: 50.4),
            description: 'Art Description'),
        Art(
            artId: 5,
            memberId: 1,
            mainImageUrl: 'assets/images/example_image_2.jpg',
            style: '아크릴 캔버스',
            title: 'Art Title 5',
            year: 2023,
            artTags: ['현대', '아크릴', '공예 캔버스'],
            size: Size(width: 100.28, height: 50.4),
            description: 'Art Description'),
        Art(
            artId: 6,
            memberId: 1,
            mainImageUrl: 'assets/images/example_image_2.jpg',
            style: '아크릴 캔버스',
            title: 'Art Title 6',
            year: 2023,
            artTags: ['현대', '아크릴', '공예 캔버스'],
            size: Size(width: 100.28, height: 50.4),
            description: 'Art Description'),
      ];
    } else {
      // TODO: fetch from API
      return null;
    }
  }
}
