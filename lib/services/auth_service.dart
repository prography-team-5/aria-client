import 'package:aria_client/helpers/env.dart';
import 'package:aria_client/helpers/network_adapter.dart';
import 'package:aria_client/models/member.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk_talk.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk_template.dart';

enum LoginPlatform { email, naver, kakao, apple }

class AuthService extends GetxService {
  // 1. (view) signIn 화면에서 로그인 방법 선택, 클릭
  // 2. (viewmodel-signin) signIn 함수(LoginPlatform) 호출
  // 3. (authService) signIn(LoginPlatform) 호출
  // 4. (authService) accessToken, refreshToken 가져옴
  // 5. (authService) 서버에 signIn 수행
  // 5-1. (authService) 200: 회원가입된 회원이므로 회원 정보 반환
  // 5-1-1. (authService) tokens, jwt, member를 반환
  // 5-1-2. (viewmodel-signin) tokens, jwt, member를 저장 후 화면 전환
  // 5-2. (authService) 401: 회원가입되지 않은 회원이므로 회원가입 수행
  // 5-2-1. (authService) 401이라는 결과를 viewmodel에 반환
  // 5-2-2. (viewmodel-signin) 401이라는 결과를 받아 회원가입 화면으로 전환
  // 5-2-3. (view) signUp 화면에서 닉네임 입력, 버튼 클릭
  // 5-2-4. (viewmodel-signup) signUp 함수 호출
  // 5-2-5. (authService) signUp 함수 호출
  // 5-2-6. (authService) 서버에 signUp 수행
  // 5-2-7. (authService) tokens, jwt, member를 반환
  // 5-2-8. (viewmodel-signup) tokens, jwt, member를 저장 후 화면 전환 => 이때 저장은 signin viewmodel에다가

  String accessToken = '';
  String refreshToken = '';
  String nickname = '';
  String jwt = '';
  Member? member;
  int statusCode = 200;

  Future<Map<String, dynamic>> signIn(LoginPlatform method) async {
    Map<String, dynamic> data = {};

    // TEST
    String keyhash = await KakaoSdk.origin;
    print(keyhash);

    // 1. 각 소셜 로그인 방법대로 signin, tokens 가져오기
    switch (method) {
      case LoginPlatform.naver:
        data = await signInWithNaver();
        break;
      case LoginPlatform.kakao:
        data = await signInWithKaKao();
        break;
      case LoginPlatform.apple:
        data = await signInWithApple();
        break;
      default: // LoginPlatform.email
        break;
    }

    // 2. 토큰 가져옴, 서버에 signIn 시도(jwt 가져오기)
    accessToken = data['accessToken'];
    refreshToken = data['refreshToken'];
    data = await signInWithServer(
        accessToken: accessToken, refreshToken: refreshToken);
    statusCode = data['statusCode'];

    // 2-1. 200이면 회원가입된 회원이므로 회원 정보 가져와서 반환
    if (statusCode == 200) {
      jwt = data['jwt'];
      // 3. 회원 정보 가져옴
      data = await fetchMember(jwt: jwt);
      member = data['member'];
      statusCode = 200;
      // 4. 최종 결과 Map으로 반환
      return {
        'accessToken': accessToken,
        'refreshToken': refreshToken,
        'jwt': jwt,
        'member': member,
        'statusCode': statusCode
      };
    }
    // 2-2. 401이면 회원가입 안된 회원이므로 회원가입 화면으로 돌아가기 위해 그대로 반환
    else if (statusCode == 401) {
      // !TEST CODE!
      return {
        'accessToken': accessToken,
        'refreshToken': refreshToken,
        'statusCode': 200
      };
      // return {'statusCode': statusCode};
    }
    return {};
  }

  Future<Map<String, dynamic>> signUp({required String nickname}) async {
    Map<String, dynamic> data = {};
    // 1. 서버에 signUp 수행, jwt 발급
    data = await signUpWithServer(
        accessToken: accessToken,
        refreshToken: refreshToken,
        nickname: nickname);
    jwt = data['jwt'];
    // 2. 회원 정보 가져옴
    data = await fetchMember(jwt: jwt);
    member = data['member'];
    statusCode = 200;
    // 3. 최종 결과 Map으로 반환
    return {
      'accessToken': accessToken,
      'refreshToken': refreshToken,
      'jwt': jwt,
      'member': member,
      'statusCode': statusCode
    };
  }

  Future<Map<String, dynamic>> signInWithNaver() async {
    // TODO: Naver SDK 절차에 따라서 aos, ios 플랫폼 등록, 키 세팅
    return {};
  }

  Future<Map<String, dynamic>> signInWithKaKao() async {
    NetworkAdapter networkAdapter = NetworkAdapter();
    String accessToken = 'testaccesskakao';
    String refreshToken = 'testrefreshkakao';

    if (Env.env != Environ.dev) {
      return {'accessToken': accessToken, 'refreshToken': refreshToken};
    }

    if (await isKakaoTalkInstalled()) {
      try {
        OAuthToken oAuthToken = await UserApi.instance.loginWithKakaoTalk();
        print('[+] KakaoTalk Login Success');
        accessToken = oAuthToken.accessToken;
        refreshToken = oAuthToken.refreshToken ?? '';
        return {'accessToken': accessToken, 'refreshToken': refreshToken};
      } catch (error) {
        print('[-] KakaoTalk Login Failed');
        print(error);
        if (error is PlatformException && error.code == "CANCELED") {
          print('[-] KakaoTalk Login Canceled');
          return {};
        }
        try {
          OAuthToken oAuthToken =
              await UserApi.instance.loginWithKakaoAccount();
          print('[+] KakaoTalk Login Success');
          accessToken = oAuthToken.accessToken;
          refreshToken = oAuthToken.refreshToken ?? '';
          return {'accessToken': accessToken, 'refreshToken': refreshToken};
        } catch (error) {
          print('[-] Kakao Account Login Failed');
          print(error);
          return {};
        }
      }
    } else {
      try {
        OAuthToken oAuthToken = await UserApi.instance.loginWithKakaoAccount();
        print('[+] Kakao Account Login Success');
        accessToken = oAuthToken.accessToken;
        refreshToken = oAuthToken.refreshToken ?? '';
        return {'accessToken': accessToken, 'refreshToken': refreshToken};
      } catch (error) {
        print('[-] Kakao Account Login Failed');
        print(error);
        return {};
      }
    }
  }

  Future<Map<String, dynamic>> signInWithApple() async {
    // TODO: Apple SDK 절차에 따라서 aos, ios 플랫폼 등록, 키 세팅
    return {};
  }

  Future<Map<String, dynamic>> signInWithServer(
      {required String accessToken, required String refreshToken}) async {
    String jwt = 'testjwtsignin';
    NetworkAdapter networkAdapter = NetworkAdapter();

    if (Env.env == Environ.dev) {
      return {'jwt': jwt, 'statusCode': 401};
    }

    Map<String, dynamic> data = await networkAdapter.post(
        path: '/login',
        params: {'accessToken': accessToken, 'refreshToken': refreshToken});

    return {'jwt': data['jwt'], 'statusCode': data['statusCode']};
  }

  Future<Map<String, dynamic>> signUpWithServer(
      {required String accessToken,
      required String refreshToken,
      required String nickname}) async {
    String jwt = 'testjwtsignup';
    NetworkAdapter networkAdapter = NetworkAdapter();

    if (Env.env == Environ.dev) {
      return {'jwt': jwt, 'statusCode': 200};
    }

    Map<String, dynamic> data = await networkAdapter.post(
        path: '/sign-up',
        params: {
          'accessToken': accessToken,
          'refreshToken': refreshToken,
          'nickname': nickname
        });
    return {'jwt': data['jwt'], 'statusCode': data['statusCode']};
  }

  Future<Map<String, dynamic>> fetchMember({required String jwt}) async {
    Member? member;
    NetworkAdapter networkAdapter = NetworkAdapter();

    if (Env.env == Environ.dev) {
      member = await Member(
        id: 1,
        email: 'test@test.com',
        password: 'test',
        role: 'artist',
        nickname: 'test',
        profile_image_url: 'https://picsum.photos/200/300',
        sign_type: 'kakao',
      );
      return {'member': member};
    }

    Map<String, dynamic> data =
        await networkAdapter.get(path: '/member', params: {'jwt': jwt});
    member = Member.fromJson(data['member']);
    return {'member': member};
  }
}
