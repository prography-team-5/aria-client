// fetchArt()
// fetchArts()
// ...

import 'package:aria_client/helpers/env.dart';
import 'package:aria_client/models/art.dart';
import 'package:get/get.dart';

class ArtService extends GetxService {
  Future<Art?> fetchArt() async {
    if (Env.env == Environ.dev) {
      return Art(
          id: 1,
          member_id: 1,
          image_url: 'https://picsum.photos/200/300',
          title: 'Art Title',
          year: 2021,
          style: 'Art Style',
          size: 100,
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
            id: 1,
            member_id: 1,
            image_url: 'https://picsum.photos/200/300',
            title: 'Art Title',
            year: 2021,
            style: 'Art Style',
            size: 100,
            description: 'Art Description'),
        Art(
            id: 2,
            member_id: 1,
            image_url: 'https://picsum.photos/200/300',
            title: 'Art Title',
            year: 2021,
            style: 'Art Style',
            size: 100,
            description: 'Art Description'),
        Art(
            id: 3,
            member_id: 1,
            image_url: 'https://picsum.photos/200/300',
            title: 'Art Title',
            year: 2021,
            style: 'Art Style',
            size: 100,
            description: 'Art Description'),
        Art(
            id: 4,
            member_id: 1,
            image_url: 'https://picsum.photos/200/300',
            title: 'Art Title',
            year: 2021,
            style: 'Art Style',
            size: 100,
            description: 'Art Description'),
        Art(
            id: 5,
            member_id: 1,
            image_url: 'https://picsum.photos/200/300',
            title: 'Art Title',
            year: 2021,
            style: 'Art Style',
            size: 100,
            description: 'Art Description'),
        Art(
            id: 6,
            member_id: 1,
            image_url: 'https://picsum.photos/200/300',
            title: 'Art Title',
            year: 2021,
            style: 'Art Style',
            size: 100,
            description: 'Art Description'),
      ];
    } else {
      // TODO: fetch from API
      return null;
    }
  }
}
