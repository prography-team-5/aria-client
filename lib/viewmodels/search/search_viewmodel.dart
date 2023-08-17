import 'package:aria_client/models/art.dart';
import 'package:aria_client/services/art_service.dart';
import 'package:get/get.dart';

class SearchViewModel extends GetxController {
  final artService = ArtService();

  final RxList<Art> _arts = RxList<Art>([]);
  List<Art>? get arts => _arts.value;

  Future<RxList<Art>> fetchArts(String keyword) async {
    Map<String, dynamic> data = await artService.fetchSearchedArts(keyword);
    _arts.value = data['artsList'];
    print('search page get api 실행!!!!!!');
    return _arts;
  }
}
