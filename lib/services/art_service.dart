// fetchArt()
// fetchArts()
// ...

import 'package:aria_client/helpers/env.dart';
import 'package:aria_client/models/art.dart';
import 'package:get/get.dart';

class ArtService extends GetxService {
  Future<Art?> fetchArt() async {
    if (Env.env == Environ.dev) {}
  }

  Future<List<Art>?> fetchArts() async {}
}
