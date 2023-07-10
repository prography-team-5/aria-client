import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../viewmodels/main/home_viewmodel.dart';

class HomePage extends GetView<HomeViewModel> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(56),
        child: AppBar(
          automaticallyImplyLeading: false,
          leading: Padding(
            padding: EdgeInsets.fromLTRB(12, 16, 0, 16),
            child: SvgPicture.asset(
              'assets/images/logo.svg',
            ),
          ),
          actions: [
            GestureDetector(
              onTap: () => Get.toNamed('/search'),
              child: SvgPicture.asset(
                'assets/images/search_button.svg',
              ),
            ),
            GestureDetector(
              onTap: () => Get.toNamed('/my'),
              child: SvgPicture.asset(
                'assets/images/my_button.svg',
              ),
            ),
          ],
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0.0, // appBar 그림자 제거
        ),
      ),
      body: Column(children: [
        Padding(padding: EdgeInsets.all(20)),
        Text(
          controller.signinViewModel.member!.nickname,
          style: TextStyle(color: Colors.black),
        ),
        Padding(padding: EdgeInsets.all(20)),
        Row(
          children: [
            Flexible(
              child: Text(
                'AccessToken : ' + controller.signinViewModel.accessToken,
                style: TextStyle(color: Colors.black),
                softWrap: true,
              ),
            ),
            TextButton(
                onPressed: () {
                  Clipboard.setData(ClipboardData(
                      text: controller.signinViewModel.accessToken));
                },
                child: Text('Copy'))
          ],
        ),
        Padding(padding: EdgeInsets.all(20)),
        Row(
          children: [
            Flexible(
              child: Text(
                'RefreshToken : ' + controller.signinViewModel.refreshToken,
                style: TextStyle(color: Colors.black),
                softWrap: true,
              ),
            ),
            TextButton(
                onPressed: () {
                  Clipboard.setData(ClipboardData(
                      text: controller.signinViewModel.refreshToken));
                },
                child: Text('Copy'))
          ],
        ),
      ]),
    );
  }
}
