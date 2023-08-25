import 'package:aria_client/models/art.dart';
import 'package:aria_client/services/art_service.dart';
import 'package:get/get.dart';

class SearchViewModel extends GetxController {
  final artService = ArtService();

  final RxList<Art> _arts = RxList<Art>([]);
  List<Art>? get arts => _arts.value;

  Future<RxList<Art>> fetchArts(String query, int page, int count) async {
    //TODO: 파라미터 변수로 변경
    Map<String, dynamic> data = await artService.fetchSearchedArts('photo', 0, 5);
    _arts.value = data['artsList'];
    print('!!!!!!search page get api 실행!!!!!!');
    return _arts;
  }
}
