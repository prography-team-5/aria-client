import 'package:aria_client/models/art.dart';
import 'package:aria_client/services/art_service.dart';
import 'package:get/get.dart';

class DetailViewModel extends GetxController {
  final artService = ArtService();

  final Rxn<Art> _art = Rxn<Art>();
  Art? get art => _art.value;

  Future<Rxn<Art>> fetchArtDetails() async {
    _art.value = await artService.fetchArtDetails();
    return _art;
  }
}