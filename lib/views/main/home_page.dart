import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
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
      body: Container(),
    );
  }
}
