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
      member = res['member'];
      accessToken = res['accessToken'];
      refreshToken = res['refreshToken'];
      jwt = res['jwt'];
      update();
    } else {
      // navigate to signup page
    }
  }

  Future<void> signInWithNaver() async {
    Map<String, dynamic> res = await authService.signIn(LoginPlatform.naver);
    if (res['statusCode'] == 200) {
      member = res['member'];
      accessToken = res['accessToken'];
      refreshToken = res['refreshToken'];
      jwt = res['jwt'];
      update();
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
