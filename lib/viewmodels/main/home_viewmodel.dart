import 'package:aria_client/models/art.dart';
import 'package:aria_client/services/art_service.dart';
import 'package:get/get.dart';

class HomeViewModel extends GetxController {
  final artService = ArtService();

  final Rx<List<Art>?> _arts = Rx<List<Art>?>(null);
  List<Art>? get arts => _arts.value;

  Future<void> _fetchArts() async {
    _arts.value = await artService.fetchArts();
  }
}
