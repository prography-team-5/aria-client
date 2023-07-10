import 'dart:ui';

import 'package:aria_client/constants/colormap.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../constants/text_styles.dart';

class _TextStyles {
  static final Title = TextStyle(
    color: ColorMap.gray_600,
    fontSize: 20,
    fontWeight: FontWeight.w800,
    height: 1.5,
    letterSpacing: -0.25,
  );

  static final Description = TextStyle(
    color: ColorMap.gray_400,
    fontSize: 16,
    fontWeight: FontWeight.w400,
    height: 1.5,
    letterSpacing: -0.25,
  );
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.fill,
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
                  _cardFlipAnimation(),
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

  Widget __transitionBuilder(Widget widget, Animation<double> animation) {
    final rotateAnim = Tween(begin: pi, end: 0.0).animate(animation);
    return AnimatedBuilder(
      animation: rotateAnim,
      child: widget,
      builder: (context, widget) {
        final isUnder = (ValueKey(_displayFront) != widget?.key);
        var tilt = ((animation.value - 0.5).abs() - 0.5) * 0.003;
        tilt *= isUnder ? -1.0 : 1.0;
        final value =
            isUnder ? min(rotateAnim.value, pi / 2) : rotateAnim.value;
        return Transform(
          transform: Matrix4.rotationY(value)..setEntry(3, 0, tilt),
          child: widget,
          alignment: Alignment.center,
        );
      },
    );
  }

  Widget _cardFlipAnimation() {
    return GestureDetector(
      onTap: () => {
        setState(() => _displayFront = !_displayFront),
      },
      child: AnimatedSwitcher(
        duration: Duration(milliseconds: 1000),
        transitionBuilder: __transitionBuilder,
        child: _displayFront ? _cardFrontWidget() : _cardRearWidget(),
        switchInCurve: Curves.easeInBack,
        switchOutCurve: Curves.easeInBack.flipped,
      ),
    );
  }

  Widget _cardFrontWidget() {
    return Card(
      key: key,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: ClipPath(
        clipper: ShapeBorderClipper(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        ),
        child: Container(
          width: 342,
          height: 592,
          alignment: Alignment.centerLeft,
          child: Column(
            children: [
              Image.asset(
                'assets/images/example_image.png',
                fit: BoxFit.cover,
                height: 456,
              ),
              Container(
                margin: EdgeInsets.fromLTRB(24, 16, 0, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '제목',
                      style: _TextStyles.Title,
                    ),
                    SizedBox(height: 4),
                    Row(
                      children: [
                        Text(
                          '2023' +
                              '  |  ' +
                              '아크릴 캔버스' +
                              '  |  ' +
                              '35.8 * 42.6',
                          style: _TextStyles.Feature,
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    Row(
                      children: [
                        SizedBox(
                          width: 42, // TODO: 글자수 길이에 따른 변수로 변경
                          height: 24,
                          child: TextButton(
                            onPressed: () {},
                            child: FittedBox(
                              fit: BoxFit.fitHeight,
                              child: Text('현대',
                                  style: TextStyle(color: Color(0xff595959))),
                            ),
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.fromLTRB(9, 1, 9, 1),
                              backgroundColor: ColorMap.gray_100,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(3),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 8),
                        SizedBox(
                          width: 54,
                          height: 24,
                          child: TextButton(
                            onPressed: () {},
                            child: FittedBox(
                              fit: BoxFit.fitHeight,
                              child: Text('아크릴',
                                  style: TextStyle(color: Color(0xff595959))),
                            ),
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.fromLTRB(9, 1, 9, 1),
                              backgroundColor: ColorMap.gray_100,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(3),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 8),
                        SizedBox(
                          width: 81,
                          height: 24,
                          child: TextButton(
                            onPressed: () {},
                            child: FittedBox(
                              fit: BoxFit.fitHeight,
                              child: Text('공예 캔버스',
                                  style: TextStyle(color: Color(0xff595959))),
                            ),
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.fromLTRB(9, 1, 9, 1),
                              backgroundColor: ColorMap.gray_100,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(3),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _cardRearWidget() {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: ClipPath(
        clipper: ShapeBorderClipper(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        ),
        child: Container(
          width: 342,
          height: 592,
          alignment: Alignment.centerLeft,
          child: Container(
            margin: const EdgeInsets.fromLTRB(24, 0, 24, 0),
            child: Center(
              child: Text(
                  style: _TextStyles.Description,
                  '혼란한 공간의 구원자라는 존재를 기존의 상식과는 다르게 비틀어 반영웅적인 이미지를 만들고.'
                  '혼란한 공간의 구원자라는 존재를 기존의 상식과는 다르게 비틀어 반영웅적인 이미지를 만들고.'
                  '혼란한 공간의 구원자라는 존재를 기존의 상식과는 다르게 비틀어 반영웅적인 이미지를 만들고.'),
            ),
          ),
        ),
      ),
    );
  }
}
