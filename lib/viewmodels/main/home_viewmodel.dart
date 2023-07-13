import 'package:aria_client/models/art.dart';
import 'package:aria_client/services/art_service.dart';
import 'package:get/get.dart';

class HomeViewModel extends GetxController {
  final artService = ArtService();

  // final Rx<List<Art>?> _arts = Rx<List<Art>?>(null);
  final RxList<Art> _arts = RxList<Art>([]);
  List<Art>? get arts => _arts.value;

  Future<RxList<Art>> fetchArts() async {
    _arts.value = await artService.fetchArts();
    return _arts;
  }
}
