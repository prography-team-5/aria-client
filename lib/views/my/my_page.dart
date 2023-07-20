import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../viewmodels/auth/signin_viewmodel.dart';
import 'artist_my_page.dart';
import 'user_my_page.dart';

class MyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final signinViewModel = Get.find<SigninViewModel>();
    print(signinViewModel.member!.role);
    return signinViewModel.member!.role != "ROLE_MEMBER"
        ? UserMyPage()
        : ArtistMyPage();
  }
}
