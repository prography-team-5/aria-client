import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../constants/colormap.dart';

class WhiteTextStyles {
  static final Heading1 = TextStyle(
      color: Colors.white,
      fontSize: 24,
      fontWeight: FontWeight.w800,
      height: 1.3,
      letterSpacing: -0.25);
}

class SplashPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorMap.mainColor,
      body: Center(
        child: Column(
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * 0.3),
            SvgPicture.asset(
              'assets/logo_white.svg',
              width: 97,
              height: 69,
            ),
            SizedBox(height: 24),
            Text(
              '내 손 안의 신인작가,',
              style: WhiteTextStyles.Heading1,
            ),
            Text(
              '지금 아리아에서 만나보세요',
              style: WhiteTextStyles.Heading1,
            ),
          ],
        ),
      ),
    );
  }
}
