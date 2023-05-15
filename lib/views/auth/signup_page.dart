import 'package:aria_client/constants/colormap.dart';
import 'package:aria_client/constants/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class GrayTextStyles {
  static final Body2 = TextStyle(
      color: ColorMap.gray_300,
      fontSize: 16,
      fontWeight: FontWeight.w400,
      height: 1.5,
      letterSpacing: -0.25);
}

class SignupPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(56),
        child: AppBar(
          automaticallyImplyLeading: false,
          title: Text(
            '회원가입',
            style: TextStyle(
                color: ColorMap.gray_700,
                fontSize: 16,
                fontWeight: FontWeight.w500),
          ),
          leading: Padding(
            padding: EdgeInsets.fromLTRB(12, 16, 0, 16),
            child: GestureDetector(
              onTap: () => Get.back(),
              child: SvgPicture.asset(
                'assets/images/leading_button.svg',
              ),
            ),
          ),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0.0, // appBar 그림자 제거
        ),
      ),
      body: Container(
        margin: EdgeInsets.fromLTRB(24, 24, 24, 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '닉네임',
              style: TextStyles.Heading3,
              textAlign: TextAlign.left,
            ),
            SizedBox(
              height: 8,
            ),
            TextField(
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                  borderSide: BorderSide(color: ColorMap.gray_200),
                ),
                hintText: '아리아에서 사용할 닉네임을 입력해주세요.',
                hintStyle: GrayTextStyles.Body2,
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                  borderSide: BorderSide(color: Colors.black),
                ),
              ),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              height: 64,
              child: TextButton(
                onPressed: () {},
                child: Text(
                  '회원가입',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    height: 1.375,
                  ),
                ),
                style: TextButton.styleFrom(
                  // TODO : controller 추가, 비활성 버튼 색 변경
                  backgroundColor: ColorMap.mainColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
