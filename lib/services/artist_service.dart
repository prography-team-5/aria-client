// fetchArtist()
// fetchArtists()

import 'package:aria_client/helpers/env.dart';
import 'package:aria_client/models/art.dart';
import 'package:aria_client/models/artist_info.dart';
import 'package:aria_client/models/member.dart';
import 'package:get/get.dart';

class ArtistService extends GetxService {
  Future<ArtistInfo?> fetchArtist() async {
    if (Env.env == Environ.dev) {
      return ArtistInfo(
        id: 1,
        member_id: 1,
        profile_art_image_url: 'https://picsum.photos/200/300',
        intro: 'Artist Intro',
      );
    } else {
      // TODO: fetch from API
      return null;
    }
  }

  Future<List<ArtistInfo>?> fetchArtists() async {
    if (Env.env == Environ.dev) {
      return [
        ArtistInfo(
          id: 1,
          member_id: 1,
          profile_art_image_url: 'https://picsum.photos/200/300',
          intro: 'Artist Intro',
        ),
        ArtistInfo(
          id: 2,
          member_id: 1,
          profile_art_image_url: 'https://picsum.photos/200/300',
          intro: 'Artist Intro',
        ),
        ArtistInfo(
          id: 3,
          member_id: 1,
          profile_art_image_url: 'https://picsum.photos/200/300',
          intro: 'Artist Intro',
        ),
        ArtistInfo(
          id: 4,
          member_id: 1,
          profile_art_image_url: 'https://picsum.photos/200/300',
          intro: 'Artist Intro',
        ),
      ];
    } else {
      // TODO: fetch from API
      return null;
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
}
