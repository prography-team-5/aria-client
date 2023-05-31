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
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk_talk.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk_template.dart';

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

  Future<Member?> signUpWithNaver() async {
    // TODO: Naver SDK 절차에 따라서 aos, ios 플랫폼 등록, 키 세팅
  }
  Future<Member?> signUpWithKaKao() async {
    // TODO: Kakao SDK 절차에 따라서 aos, ios 플랫폼 등록, 키 세팅
    Member? member;
    if (await isKakaoTalkInstalled()) {
      try {
        await UserApi.instance.loginWithKakaoTalk();
        print('[+] KakaoTalk Login Success');
        // TODO: Pass tokens to the server
        // TODO: Get user info from the server
        member = await Member(
          id: 1,
          email: 'test@test.com',
          password: 'test',
          role: 'artist',
          nickname: 'test',
          profile_image_url: 'https://picsum.photos/200/300',
          sign_type: 'kakao',
        );
        return member;
      } catch (error) {
        print('[-] KakaoTalk Login Failed');
        print(error);
        if (error is PlatformException && error.code == "CANCELED") {
          print('[-] KakaoTalk Login Canceled');
          return null;
        }
        try {
          await UserApi.instance.loginWithKakaoAccount();
          print('[+] Kakao Account Login Success');
          // TODO: Pass tokens to the server
          // TODO: Get user info from the server
          member = await Member(
            id: 1,
            email: 'test@test.com',
            password: 'test',
            role: 'artist',
            nickname: 'test',
            profile_image_url: 'https://picsum.photos/200/300',
            sign_type: 'kakao',
          );
          return member;
        } catch (error) {
          print('[-] Kakao Account Login Failed');
          print(error);
          return null;
        }
      }
    } else {
      try {
        await UserApi.instance.loginWithKakaoAccount();
        print('[+] Kakao Account Login Success');
        // TODO: Pass tokens to the server
        // TODO: Get user info from the server
        member = await Member(
          id: 1,
          email: 'test@test.com',
          password: 'test',
          role: 'artist',
          nickname: 'test',
          profile_image_url: 'https://picsum.photos/200/300',
          sign_type: 'kakao',
        );
        return member;
      } catch (error) {
        print('[-] Kakao Account Login Failed');
        print(error);
        return null;
      }
    }
  }

  Future<Member?> signUpWithApple() async {
    // TODO: Apple SDK 절차에 따라서 aos, ios 플랫폼 등록, 키 세팅
  }
}
