import 'package:aria_client/services/auth_service.dart';
import 'package:get/get.dart';

class SignupViewModel extends GetxController {
  final AuthService authService = Get.find<AuthService>();
  RxBool isProcessing = false.obs;
}
