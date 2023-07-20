import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../constants/colormap.dart';
import '../../constants/text_styles.dart';
import '../../viewmodels/auth/signin_viewmodel.dart';

class UserMyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final signinViewModel = Get.find<SigninViewModel>();
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(56),
          child: AppBar(
            automaticallyImplyLeading: false,
            title: Text(
              '프로필',
              style: TextStyle(
                  color: ColorMap.gray_700,
                  fontSize: 16,
                  fontWeight: FontWeight.w500),
            ),
            leading: Padding(
              padding: EdgeInsets.fromLTRB(12, 16, 0, 16),
              child: InkWell(
                onTap: () {
                  Get.back();
                },
                child: SvgPicture.asset(
                  'assets/images/leading_button.svg',
                ),
              ),
            ),
            actions: [
              Padding(
                padding: EdgeInsets.fromLTRB(0, 16, 12, 16),
                child: TextButton(
                  onPressed: () {},
                  child: Text(
                    '작가 신청',
                    style: TextStyle(
                      color: ColorMap.white,
                      fontFamily: 'Prentendard',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    backgroundColor: ColorMap.mainColor,
                    shape: RoundedRectangleBorder(
                      side: BorderSide.none,
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
              ),
            ],
            centerTitle: true,
            backgroundColor: Colors.transparent,
            elevation: 0.0, // appBar 그림자 제거
          ),
        ),
        body: Stack(
          alignment: Alignment.center,
          children: [
            Column(
              children: [
                Container(
                  height: 400,
                  child: Image.asset(
                    'assets/images/profile_background.png',
                    fit: BoxFit.fill,
                  ),
                ),
                Expanded(
                  // height: 200,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 30 + 5),
                    child: Column(
                      children: [
                        Text(
                          signinViewModel.member!.nickname,
                          style: TextStyles.Heading2,
                        ),
                        TextButton(
                          onPressed: () {},
                          child: Text(
                            '프로필 수정',
                            style: TextStyle(color: ColorMap.gray_700),
                          ),
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.symmetric(
                                horizontal: 130, vertical: 13),
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                  color: ColorMap.gray_200, width: 1),
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Positioned(
              top: 400 - 50,
              child: Container(
                height: 100.0,
                width: 100.0,
                child: Image.asset('assets/images/profile_avatar.png'),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
