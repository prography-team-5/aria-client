import 'dart:math';
import 'dart:ui';

import 'package:aria_client/constants/colormap.dart';
import 'package:aria_client/helpers/text_layout_helper.dart';
import 'package:aria_client/models/art.dart';
import 'package:aria_client/viewmodels/auth/signin_viewmodel.dart';
import 'package:aria_client/viewmodels/main/home_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
// import 'package:lottie/lottie.dart';

class _TextStyles {
  static final Title = TextStyle(
    color: ColorMap.gray_600,
    fontSize: 20,
    fontWeight: FontWeight.w800,
    height: 1.5,
    letterSpacing: -0.25,
  );

  static final Feature = TextStyle(
    color: ColorMap.gray_400,
    fontSize: 14,
    fontWeight: FontWeight.w400,
    height: 1.5,
    letterSpacing: -0.25,
  );

  static final Description = TextStyle(
    fontFamily: 'NanumMyeongjo',
    color: ColorMap.gray_700,
    fontSize: 16,
    fontWeight: FontWeight.w400,
    height: 2,
    letterSpacing: -0.25,
  );
}

class _HomePageController extends GetxController {
  final homeViewModel = HomeViewModel();
  final cardScrollController = ScrollController();
  final pageController = PageController(initialPage: 0);
  final currentCardNotifier = ValueNotifier<RxInt>(0.obs);

  Key key = ValueKey(false);
  RxBool displayFront = true.obs;
  RxBool doNotFlip = false.obs;
  RxDouble cardScrollOffset = 0.0.obs;
  RxDouble cardScrollBottomOffset = 0.0.obs;

  @override
  void onClose() {
    cardScrollController.dispose();
    pageController.dispose();
    super.onClose();
  }

  @override
  void onInit() {
    super.onInit();
    // displayFront = List.generate(artsList.length, (index) => true.obs);
    // print(displayFront);

    cardScrollController.addListener(() {
      cardScrollOffset.value = cardScrollController.offset;
      cardScrollBottomOffset.value =
          cardScrollController.position.maxScrollExtent;
      update();
    });
  }

  void flipping() {
    displayFront.value = !displayFront.value;
    doNotFlip.value = false;
    update();
  }

  void makeFront() {
    displayFront.value = true;
    doNotFlip.value = true;
    update();
  }

// void fetchMoreData() async {
//   RxList<Art> moreArtsList = await homeViewModel.fetchArtsApi();
//   print('갖고오나?');
//   // artsList.add(moreArtsList);
//   print('더 많은 데이터를 가져와라!!!');
// }
}

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final homePageController = Get.put(_HomePageController());

  @override
  Widget build(BuildContext context) {
    final signinViewModel = Get.put(SigninViewModel());
    return FutureBuilder(
      future: homePageController.homeViewModel.fetchArtsApi(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          RxList<Art> artsList = snapshot.data!;
          // RxList<Art> artsList = snapshot.data! as RxList<Art>;
          return Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.fill,
                image: NetworkImage(artsList[
                        homePageController.currentCardNotifier.value.toInt()]
                    .mainImageUrl!),
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
                        signinViewModel.member?.role != null
                            ? Padding(
                                padding: const EdgeInsets.fromLTRB(0, 0, 12, 0),
                                child: GestureDetector(
                                  onTap: () => Get.toNamed('/my'),
                                  child: SvgPicture.asset(
                                    'assets/images/my_button.svg',
                                  ),
                                ),
                              )
                            : Container(),
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
                          height: MediaQuery.of(context).size.height -
                              208, // H56 T24 SB24 BT64 B40
                          child: _cardsPageView(artsList),
                        ),
                        SizedBox(height: 24),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextButton(
                              //TODO: 시스템 공유 옵션 사용
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
                                //TODO: artist 페이지로 이동
                                onPressed: () {
                                  Get.toNamed('/artist_home',
                                      arguments: artsList[homePageController
                                              .currentCardNotifier.value
                                              .toInt()]
                                          .memberId);
                                },
                                child: FittedBox(
                                  child: Text(
                                    '전시회 방문하기',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                                style: TextButton.styleFrom(
                                  backgroundColor: ColorMap.mainColor,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(100),
                                  ),
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
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }
        // 기본적으로 로딩 Spinner
        // return Container(
        //   color: Colors.white,
        //   child: Lottie.asset(
        //     'assets/images/loading.json',
        //     width: 68,
        //     height: 48,
        //     frameRate: FrameRate.max,
        //     repeat: true,
        //     animate: true,
        //   ),
        // );
        return CircularProgressIndicator();
      },
    );
  }

  Widget __transitionBuilder(Widget widget, Animation<double> animation) {
    final rotateAnim = Tween(begin: pi, end: 0.0).animate(animation);
    return AnimatedBuilder(
      animation: rotateAnim,
      child: widget,
      builder: (context, widget) {
        final isUnder =
            (ValueKey(homePageController.displayFront) != widget?.key);
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

  Widget _cardsPageView(RxList<Art> artsList) {
    return PageView.builder(
      itemCount: artsList.length,
      controller: homePageController.pageController,
      itemBuilder: (BuildContext context, int index) {
        return _cardFlipAnimation(index, artsList);
      },
      onPageChanged: (int index) {
        homePageController.currentCardNotifier.value = index.obs;
        homePageController.makeFront();
        //TODO: 여기에 artsList 더 가져오는 함수 추가
        if (index == artsList.length - 1) {
          // homePageController.fetchMoreData();
        }
      },
    );
  }

  Widget _emptyAnimation(Widget widget, Animation<double> animation) {
    return widget;
  }

  Widget _cardFlipAnimation(int index, RxList<Art> artsList) {
    return GetBuilder<_HomePageController>(
      builder: (context) {
        return GestureDetector(
            onTap: () => {
                  homePageController.flipping(),
                },
            child: homePageController.doNotFlip.value
                ? AnimatedSwitcher(
                    duration: Duration(milliseconds: 0),
                    child: homePageController.displayFront.value
                        ? _cardFrontWidget(index, artsList)
                        : RearWidget(index: index, artsList: artsList),
                  )
                : AnimatedSwitcher(
                    duration: Duration(milliseconds: 1000),
                    transitionBuilder: __transitionBuilder,
                    switchInCurve: Curves.easeInBack,
                    switchOutCurve: Curves.easeInBack.flipped,
                    child: homePageController.displayFront.value
                        ? _cardFrontWidget(index, artsList)
                        : RearWidget(index: index, artsList: artsList),
                  ));
      },
    );
  }

  Widget _cardFrontWidget(int index, RxList<Art> artsList) {
    final art = artsList[index];
    return Card(
      key: homePageController.key,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: ClipPath(
        clipper: ShapeBorderClipper(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        ),
        child: LayoutBuilder(
          builder: (context, constraints) => Container(
            alignment: Alignment.centerLeft,
            child: Column(
              children: [
                Image.network(
                  art.mainImageUrl!,
                  fit: BoxFit.cover,
                  height: constraints.maxHeight - 136,
                  width: double.infinity,
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
                          art.title,
                          style: _TextStyles.Title,
                        ),
                      ),
                      SizedBox(height: 4),
                      Row(
                        children: [
                          Text(
                            art.year.toString() +
                                '  |  ' +
                                art.style +
                                '  |  ' +
                                art.size.width.toString() +
                                ' X ' +
                                art.size.height.toString(),
                            style: _TextStyles.Feature,
                          ),
                        ],
                      ),
                      SizedBox(height: 16),
                      _tagsWidget(art.artTags!),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _tagsWidget(List<dynamic> artTags) {
    final _tagStyle = TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      letterSpacing: -0.25,
    );
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: artTags
            .map(
              (item) => Container(
                margin: EdgeInsets.fromLTRB(0, 0, 8, 0),
                child: SizedBox(
                  width:
                      TextLayoutHelper.getTextSize(text: item, style: _tagStyle)
                              .width +
                          18,
                  height: 24,
                  child: TextButton(
                    onPressed: null,
                    child: FittedBox(
                      fit: BoxFit.fitHeight,
                      child: Text(item,
                          style: TextStyle(color: Color(0xFF595959))),
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
              ),
            )
            .toList(),
      ),
    );
  }
}

class RearWidget extends StatelessWidget {
  final int index;
  final RxList<Art> artsList;

  RearWidget({required this.index, required this.artsList});

  @override
  Widget build(BuildContext context) {
    final art = artsList[index];
    return GetBuilder<_HomePageController>(
      init: _HomePageController(),
      builder: (context) {
        final homePageController = Get.put(_HomePageController());
        // homePageController.displayFront.value = true;
        return Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: ClipPath(
            clipper: ShapeBorderClipper(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)),
            ),
            child: Container(
              width: double.infinity,
              alignment: Alignment.centerLeft,
              child: ShaderMask(
                shaderCallback: (Rect bounds) {
                  return homePageController.cardScrollOffset == 0.0
                      ? LinearGradient(
                              begin: Alignment.center,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.white,
                                Colors.white.withOpacity(0.04)
                              ],
                              stops: [0.8, 0.9],
                              tileMode: TileMode.clamp)
                          .createShader(bounds)
                      : homePageController.cardScrollOffset ==
                              homePageController.cardScrollBottomOffset
                          ? LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.center,
                                  colors: [
                                    Colors.white.withOpacity(0.04),
                                    Colors.white,
                                  ],
                                  stops: [0.1, 0.2],
                                  tileMode: TileMode.clamp)
                              .createShader(bounds)
                          : LinearGradient(
                              begin: Alignment.center,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.white,
                                Colors.white.withOpacity(0.04)
                              ],
                              stops: [0.8, 0.9],
                              tileMode: TileMode.mirror,
                            ).createShader(bounds);
                },
                child: Container(
                  margin: const EdgeInsets.all(24),
                  child: SingleChildScrollView(
                    controller: homePageController.cardScrollController,
                    child: Center(
                      child: Text(
                          style: _TextStyles.Description, art.description!),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
