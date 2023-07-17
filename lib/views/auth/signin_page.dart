import 'package:aria_client/constants/colormap.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../constants/text_styles.dart';
import '../../viewmodels/auth/signin_viewmodel.dart';

class SigninPage extends StatelessWidget {
  final SigninViewModel controller = Get.find<SigninViewModel>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * 0.3),
            SvgPicture.asset(
              'assets/images/logo.svg',
              width: 97,
              height: 69,
            ),
            SizedBox(height: 24),
            Text(
              '내 손 안의 신인작가,',
              style: TextStyles.Heading1,
            ),
            Text(
              '지금 아리아에서 만나보세요',
              style: TextStyles.Heading1,
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  child: SvgPicture.asset(
                    'assets/images/kakao_login_button.svg',
                    width: 64,
                    height: 64,
                  ),
                  onTap: () async {
                    await controller.signInWithKaKao();
                  },
                ),
                SizedBox(width: 16),
                InkWell(
                  child: SvgPicture.asset(
                    'assets/images/naver_login_button.svg',
                    width: 64,
                    height: 64,
                  ),
                  onTap: () async {
                    controller.signInWithNaver();
                  },
                ),
                SizedBox(width: 16),
                InkWell(
                  child: SvgPicture.asset(
                    'assets/images/apple_login_button.svg',
                    width: 64,
                    height: 64,
                  ),
                  onTap: () async {
                    controller.signInWithApple();
                  },
                ),
              ],
            ),
            SizedBox(height: 24),
            SizedBox(
              width: 225,
              height: 54,
              child: OutlinedButton(
                onPressed: () {
                  Get.toNamed('/test_page');
                },
                child: FittedBox(
                  fit: BoxFit.fitHeight,
                  child: Text(
                    '둘러보기',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                style: OutlinedButton.styleFrom(
                  side: BorderSide(width: 1, color: ColorMap.gray_200),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100),
                  ),
                  textStyle: TextStyles.Heading4,
                ),
              ),
            ),
            SizedBox(
              height: 62,
            )
          ],
        ),
      ),
    );
  }
}
