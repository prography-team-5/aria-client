import 'dart:ui';

import 'package:aria_client/constants/colormap.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

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
    fontSize: 14,
    fontWeight: FontWeight.w400,
    height: 1.5,
    letterSpacing: -0.25,
  );
}

class _HomePageController extends GetxController {
  final cardScrollController = ScrollController();

  RxDouble cardScrollOffset = 0.0.obs;

  @override
  void onClose() {
    cardScrollController.dispose();
    super.onClose();
  }

  @override
  void onInit() {
    cardScrollController.addListener(() {
      cardScrollOffset.value = cardScrollController.offset;
      print('offset = ${cardScrollOffset.value}');
    });
    super.onInit();
  }
}

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @required
  Key key = ValueKey(false);
  bool _displayFront = true;
  Size size = Size.zero;

  final List<String> images = ['example_image.png', 'example_image_2.jpg'];
  final _currentCardNotifier = ValueNotifier<RxInt>(0.obs);
  final PageController _pageController = PageController(initialPage: 0);

  final GlobalKey _cadsPageKey = GlobalKey();

  Size? _getSize() {
    if (_cadsPageKey.currentContext != null) {
      final RenderBox renderBox =
          _cadsPageKey.currentContext!.findRenderObject() as RenderBox;
      Size size = renderBox.size;
      return size;
    }
  }

  @override
  void initState() {
    super.initState();
    // 위젯이 모두 그려진 다음 실행
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      setState(() {
        size = _getSize()!;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.fill,
          image: AssetImage(
              'assets/images/${images[_currentCardNotifier.value.toInt()]}'),
        ),
      ),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16), // 배경 블러
        child: Container(
          color: Color(0xffD9D9D9).withOpacity(0.7),
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
              margin: const EdgeInsets.fromLTRB(24, 24, 24, 0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    // height: 637,
                    key: _cadsPageKey,
                    height: MediaQuery.of(context).size.height -
                        208, // H56 T24 SB24 BT64 B40
                    child: _cardsPageView(),
                  ),
                  SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
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
                        width: MediaQuery.of(context).size.width -
                            121, // L24 R24 BT64 SB 9
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

  Widget _cardsPageView() {
    return PageView.builder(
      itemCount: images.length,
      controller: _pageController,
      itemBuilder: (BuildContext context, int index) {
        return _cardFlipAnimation(index);
      },
      onPageChanged: (int index) {
        setState(() {
          _currentCardNotifier.value = index.obs;
          _displayFront = true;
        });
      },
    );
  }

  Widget _cardFlipAnimation(int index) {
    return GestureDetector(
      onTap: () => {
        setState(() => _displayFront = !_displayFront),
      },
      child: AnimatedSwitcher(
        duration: Duration(milliseconds: 1000),
        transitionBuilder: __transitionBuilder,
        child: _displayFront ? _cardFrontWidget(index) : _cardRearWidget(index),
        switchInCurve: Curves.easeInBack,
        switchOutCurve: Curves.easeInBack.flipped,
      ),
    );
  }

  Widget _cardFrontWidget(int index) {
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
          width: double.infinity,
          alignment: Alignment.centerLeft,
          child: Column(
            children: [
              Image.asset(
                'assets/images/${images[index]}',
                fit: BoxFit.cover,
                height: size.height - 144, // TODO: 8px의 행방을 찾아서...
              ),
              Container(
                height: 96,
                margin: EdgeInsets.fromLTRB(24, 16, 24, 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 30,
                      child: Text(
                        '제목',
                        style: _TextStyles.Title,
                      ),
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

  Widget _cardRearWidget(int index) {
    final homePageController = Get.put(_HomePageController());
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
          width: double.infinity,
          alignment: Alignment.centerLeft,
          child: ShaderMask(
            shaderCallback: (Rect bounds) {
              return LinearGradient(
                begin: Alignment.center,
                end: Alignment.bottomCenter,
                colors: [Colors.white, Colors.white.withOpacity(0.04)],
                stops: [0.8, 0.9],
                tileMode: homePageController.cardScrollOffset.value == 0.0
                    ? TileMode.clamp
                    : TileMode.mirror,
              ).createShader(bounds);
            },
            child: Container(
              margin: const EdgeInsets.all(24),
              child: SingleChildScrollView(
                controller: homePageController.cardScrollController,
                child: Center(
                  child: index == 1
                      ? Text(
                          style: _TextStyles.Description,
                          '혼란한 공간의 구원자라는 존재를 기존의 상식과는 다르게 비틀어 반영웅적인 이미지를 만들고.'
                          '혼란한 공간의 구원자라는 존재를 기존의 상식과는 다르게 비틀어 반영웅적인 이미지를 만들고.'
                          '혼란한 공간의 구원자라는 존재를 기존의 상식과는 다르게 비틀어 반영웅적인 이미지를 만들고.')
                      : Text(
                          style: _TextStyles.Description,
                          '혼란한 공간의 구원자라는 존재를 기존의 상식과는 다르게 비틀어 반영웅적인 이미지를 만들고.\n\n'
                          '혼란한 공간의 구원자라는 존재를 기존의 상식과는 다르게 비틀어 반영웅적인 이미지를 만들고.'
                          '혼란한 공간의 구원자라는 존재를 기존의 상식과는 다르게 비틀어 반영웅적인 이미지를 만들고.\n\n'
                          '혼란한 공간의 구원자라는 존재를 기존의 상식과는 다르게 비틀어 반영웅적인 이미지를 만들고.'
                          '혼란한 공간의 구원자라는 존재를 기존의 상식과는 다르게 비틀어 반영웅적인 이미지를 만들고.\n\n'
                          '혼란한 공간의 구원자라는 존재를 기존의 상식과는 다르게 비틀어 반영웅적인 이미지를 만들고.'
                          '혼란한 공간의 구원자라는 존재를 기존의 상식과는 다르게 비틀어 반영웅적인 이미지를 만들고.\n\n'
                          '혼란한 공간의 구원자라는 존재를 기존의 상식과는 다르게 비틀어 반영웅적인 이미지를 만들고.'
                          '혼란한 공간의 구원자라는 존재를 기존의 상식과는 다르게 비틀어 반영웅적인 이미지를 만들고.\n\n'
                          '혼란한 공간의 구원자라는 존재를 기존의 상식과는 다르게 비틀어 반영웅적인 이미지를 만들고.'),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
