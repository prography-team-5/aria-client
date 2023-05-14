import 'package:aria_client/constants/colormap.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class SignupPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(56),
        child: AppBar(
          title: Text(
            '회원가입',
            style: TextStyle(
                color: ColorMap.gray_700,
                fontSize: 16,
                fontWeight: FontWeight.w500),
          ),
          // leading: SvgPicture.asset(
          //   'assets/images/leading_button.svg',
          //   fit: BoxFit.cover,
          // ),
          leading: Padding(
            padding: EdgeInsets.fromLTRB(24, 16, 0, 16),
            child: GestureDetector(
              onTap: () => Get.back(),
              child: SvgPicture.asset(
                'assets/images/leading_button.svg',
              ),
            ),
          ),
          centerTitle: true, // 가운데 정렬
          backgroundColor: Colors.transparent,
          elevation: 0.0, // appBar 그림자 제거
        ),
      ),
      extendBodyBehindAppBar: true, // body 위에 appbar
      body: Container(),
    );
  }
}
