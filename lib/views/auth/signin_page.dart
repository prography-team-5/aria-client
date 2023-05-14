import 'package:aria_client/constants/colormap.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../constants/text_styles.dart';

class SigninPage extends StatelessWidget {
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
            SizedBox(height: 236),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  'assets/images/kakao_login_button.svg',
                  width: 64,
                  height: 64,
                ),
                SizedBox(width: 16),
                SvgPicture.asset(
                  'assets/images/naver_login_button.svg',
                  width: 64,
                  height: 64,
                ),
                SizedBox(width: 16),
                SvgPicture.asset(
                  'assets/images/apple_login_button.svg',
                  width: 64,
                  height: 64,
                ),
              ],
            ),
            SizedBox(height: 24),
            OutlinedButton(
              onPressed: () {},
              // child: Text(
              //   '둘러보기',
              //   style: TextStyle(color: Colors.black),
              // ),
              child: FittedBox(
                fit: BoxFit.fitHeight,
                child: Text(
                  '둘러보기',
                  style: TextStyle(color: Colors.black),
                ),
              ),
              style: OutlinedButton.styleFrom(
                fixedSize: Size(225, 54), // TODO : 높이 54는 Hug 방식으로 변경해야 함
                side: BorderSide(width: 1, color: ColorMap.gray_200),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100),
                ),
                textStyle: TextStyles.Heading4,
              ),
            )
          ],
        ),
      ),
    );
  }
}
