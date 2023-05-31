// signIn()
// signUp()
// 1. signUpMethod 확인
// 2. signUpMethod 별로 분기, signup실행
// 3. (social) 각 서비스에게 로그인 요청
// 4. (social) 각 서비스마다 토큰 발급받음
// 5. (server) 토큰을 서버에 전달
// 6. (server) 유저 정보를 전달받음
// 7. (client) 유저 정보를 가공, 저장
// 8. (client) 유저 정보를 반환

import 'package:aria_client/models/member.dart';
import 'package:get/get.dart';

enum LoginPlatform { email, naver, kakao, apple }

class AuthService extends GetxService {
  Future<void> signIn() async {}
  Future<Member?> signUp(LoginPlatform method) async {
    Member? member;
    // check signup method
    switch (method) {
      case LoginPlatform.naver:
        member = await signUpWithNaver();
        break;
      case LoginPlatform.kakao:
        member = await signUpWithKaKao();
        break;
      case LoginPlatform.apple:
        member = await signUpWithApple();
        break;
      default: // LoginPlatform.email
        break;
    }
    return member;
  }

  Future<Member?> signUpWithNaver() async {}
  Future<Member?> signUpWithKaKao() async {}
  Future<Member?> signUpWithApple() async {}
}
