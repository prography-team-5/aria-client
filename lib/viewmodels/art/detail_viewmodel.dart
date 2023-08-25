import 'package:aria_client/models/art.dart';
import 'package:aria_client/services/art_service.dart';
import 'package:get/get.dart';

class DetailViewModel extends GetxController {
  final artService = ArtService();

  final Rxn<Art> _art = Rxn<Art>();
  Art? get art => _art.value;

  Future<Rxn<Art>> fetchArtDetails(int artId) async {
    Map<String, dynamic> data = await artService.fetchArtDetails(artId);
    _art.value = data['artInfo'];
    return _art;
  }
}