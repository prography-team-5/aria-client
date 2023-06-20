import 'package:get/get.dart';

import '../../models/member.dart';
import '../../services/auth_service.dart';

class SigninViewModel extends GetxController {
  final AuthService authService = Get.find<AuthService>();
  RxBool isProcessing = false.obs;
  Member? member;
  String accessToken = '';
  String refreshToken = '';
  String nickname = '';
  String jwt = '';

  Future<void> signInWithKaKao() async {
    Map<String, dynamic> res = await authService.signIn(LoginPlatform.kakao);
    if (res['statusCode'] == 200) {
      // TEST
      // member = res['member'];
      accessToken = res['accessToken'];
      refreshToken = res['refreshToken'];
      print(accessToken);
      // jwt = res['jwt'];
      update();
      Get.offAllNamed('/home');
    } else {
      // navigate to signup page
      Get.offAllNamed('/signup');
    }
  }

  Future<void> signInWithNaver() async {
    // TEST
    Get.offAllNamed('/home');
    Map<String, dynamic> res = await authService.signIn(LoginPlatform.naver);
    if (res['statusCode'] == 200) {
      member = res['member'];
      accessToken = res['accessToken'];
      refreshToken = res['refreshToken'];
      jwt = res['jwt'];
      update();
      Get.offAllNamed('/home');
    } else {
      // navigate to signup page
    }
  }

  Future<void> signInWithApple() async {
    Map<String, dynamic> res = await authService.signIn(LoginPlatform.apple);
    if (res['statusCode'] == 200) {
      member = res['member'];
      accessToken = res['accessToken'];
      refreshToken = res['refreshToken'];
      jwt = res['jwt'];
      update();
      Get.offAllNamed('/home');
    } else {
      // navigate to signup page
    }
  }

  void signUpDone(
      {required String accessToken,
      required String refreshToken,
      required String jwt,
      required Member member}) {
    this.accessToken = accessToken;
    this.refreshToken = refreshToken;
    this.jwt = jwt;
    this.member = member;
  }
}
