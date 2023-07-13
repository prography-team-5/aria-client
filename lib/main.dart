import 'package:aria_client/bindings/initial_bindings.dart';
import 'package:aria_client/helpers/env.dart';
import 'package:aria_client/views/my/artist_add_art_page.dart';
import 'package:aria_client/views/my/user_edit_profile_page.dart';
import 'package:aria_client/views/my/user_my_page.dart';
import 'package:aria_client/views/test/test_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';

import 'views/art/detail_page.dart';
import 'views/artist/add_art_page.dart';
import 'views/artist/artist_home_page.dart';
import 'views/auth/signin_page.dart';
import 'views/auth/signup_page.dart';
import 'views/auth/splash_page.dart';
import 'views/main/home_page.dart';
import 'views/my/artist_edit_profile_page.dart';
import 'views/my/artist_my_page.dart';
import 'views/search/search_page.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
    statusBarIconBrightness: Brightness.light,
    statusBarColor: Colors.transparent,
  ));
  KakaoSdk.init(nativeAppKey: Env.kakaoNativeKey);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'test',
      theme: ThemeData(primarySwatch: Colors.blue, fontFamily: 'Pretendard'),
      debugShowCheckedModeBanner: false,
      home: TestPage(),
      initialRoute: '/signin',
      initialBinding: InitialBinding(),
      getPages: [
        // TODO: BindingBuilder 사용여부에 따라 Routing 수정 필요
        GetPage(name: "/", page: () => TestPage()),
        GetPage(name: "/splash", page: () => SplashPage()),
        GetPage(name: "/home", page: () => HomePage()),
        GetPage(name: "/signin", page: () => SigninPage()),
        GetPage(name: "/signup", page: () => SignupPage()),
        GetPage(name: "/artist_my", page: () => ArtistMyPage()),
        GetPage(
            name: "/artist_edit_profile", page: () => ArtistEditProfilePage()),
        GetPage(name: "/artist_add_art", page: () => ArtistAddArtPage()),
        GetPage(name: "/user_my", page: () => UserMyPage()),
        GetPage(name: "/user_edit_profile", page: () => UserEditProfilePage()),
        GetPage(name: "/search", page: () => SearchPage()),
        GetPage(name: "/artist_home", page: () => ArtistHomePage()),
        GetPage(name: "/add_art", page: () => AddArtPage()),
        GetPage(name: "/detail", page: () => DetailPage()),
      ],
    );
  }
}
