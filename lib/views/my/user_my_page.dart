import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../constants/colormap.dart';

class UserMyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
                    '작품 등록',
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
        body: Container(),
      ),
    );
  }
}
