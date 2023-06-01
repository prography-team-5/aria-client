import 'dart:ui';

import 'package:aria_client/constants/colormap.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.fill, // TODO: 아니면 fill?,
          image: AssetImage('assets/images/example_image.png'),
        ),
      ),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16), // 배경 블러
        child: Container(
          color: Color(0xffD9D9D9).withOpacity(0.1),
          child: Scaffold(
            backgroundColor: Colors.transparent,
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
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 12, 0),
                    child: GestureDetector(
                      onTap: () => Get.toNamed('/search'),
                      child: SvgPicture.asset(
                        'assets/images/search_button.svg',
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 12, 0),
                    child: GestureDetector(
                      onTap: () => Get.toNamed('/my'),
                      child: SvgPicture.asset(
                        'assets/images/my_button.svg',
                      ),
                    ),
                  ),
                ],
                centerTitle: true,
                backgroundColor: Colors.transparent,
                elevation: 0.0, // appBar 그림자 제거
              ),
            ),
            body: Container(
              margin: const EdgeInsets.fromLTRB(24, 0, 24, 0),
              child: Column(
                children: [
                  Spacer(),
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: ClipPath(
                      clipper: ShapeBorderClipper(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16)),
                      ),
                      child: Container(
                        width: 342,
                        height: 592,
                        // decoration: BoxDecoration(
                        //   border: Border(
                        //       left: BorderSide(color: Colors.red, width: 15)),
                        //   color: Colors.yellowAccent.shade100,
                        // ),
                        // padding: EdgeInsets.all(20.0),
                        alignment: Alignment.centerLeft,
                        child: Column(
                          children: [
                            Image.asset(
                              'assets/images/example_image.png',
                              fit: BoxFit.fitWidth,
                            ),
                            Container(
                              height: 136,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('제목'),
                                  Row(
                                    children: [
                                      Text('2023'),
                                      Text(' | '),
                                      Text('아크릴 캔버스'),
                                      Text(' | '),
                                      Text('35.8 * 42.6'),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      TextButton(onPressed: () {}, child: Text('현대')),
                                      TextButton(onPressed: () {}, child: Text('아크릴')),
                                      TextButton(onPressed: () {}, child: Text('공예 캔버스')),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Spacer(),
                  Row(
                    children: [
                      TextButton(
                        onPressed: () {},
                        child: SvgPicture.asset(
                          'assets/images/share_button.svg',
                        ),
                        style: TextButton.styleFrom(
                          backgroundColor: ColorMap.subColor,
                          shape: const CircleBorder(),
                          fixedSize: Size(64, 64),
                        ),
                      ),
                      SizedBox(width: 9),
                      SizedBox(
                        width: 256, // TODO: flexible하게 바꿀 것
                        height: 64,
                        child: TextButton(
                          onPressed: () {},
                          child: FittedBox(
                            child: Text('전시회 방문하기',
                                style: TextStyle(color: Colors.white)),
                          ),
                          style: TextButton.styleFrom(
                            backgroundColor: ColorMap.mainColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(100),
                            ),
                            // fixedSize: Size(double.infinity, 64),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 40)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
