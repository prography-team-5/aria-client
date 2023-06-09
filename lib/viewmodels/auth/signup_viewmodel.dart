import 'package:aria_client/services/auth_service.dart';
import 'package:aria_client/viewmodels/auth/signin_viewmodel.dart';
import 'package:get/get.dart';

import '../../models/member.dart';

// SignupViewModel은 SigninViewModel과 기능이 동일하여 생략
class SignupViewModel extends GetxController {
  final AuthService authService = Get.find<AuthService>();
  RxBool isProcessing = false.obs;
  Member? member;
  String accessToken = '';
  String refreshToken = '';
  String nickname = '';
  String jwt = '';

  Future<void> signUp({required String nickname}) async {
    Map<String, dynamic> res = await authService.signUp(nickname: nickname);
    final signinViewModel = Get.put(SigninViewModel());
    member = res['member'];
    accessToken = res['accessToken'];
    refreshToken = res['refreshToken'];
    jwt = res['jwt'];
    signinViewModel.signUpDone(
        accessToken: accessToken,
        refreshToken: refreshToken,
        jwt: jwt,
        member: member!);
    update();
    // navigate to main page
    Get.offAllNamed('/home');
  }
}
