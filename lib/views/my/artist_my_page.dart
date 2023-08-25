import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../constants/colormap.dart';
import '../../constants/text_styles.dart';

// TODO: ArtistMyPage 작품 등록, 프로필 설정, 프로필 공유, 팔로워, 내 작품, 팔로워 페이지 구현
class ArtistMyController extends GetxController {}

class ArtistMyScrollController extends GetxController {
  var scrollController = ScrollController().obs;
}

class ArtistMyPageController extends GetxController {
  var pageController = PageController(initialPage: 0).obs;
  RxInt pageIndex = 0.obs;

  bool isCurrentPage(int page) {
    return page == pageIndex.value;
  }

  void pageBtnOnTap(int page) {
    pageIndex.value = page;
    pageController.value.animateToPage(pageIndex.value,
        duration: Duration(milliseconds: 700), curve: Curves.easeOutCirc);
    update();
  }

  void onPageChanged(int page) {
    pageIndex.value = page;
    update();
  }
}

class ArtistMyPage extends StatelessWidget {
  final double sliverMinHeight = 0.0;

  @override
  Widget build(BuildContext context) {
    final scrollController = Get.put(ArtistMyScrollController());

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
                  onPressed: () {
                    Get.toNamed('/artist_add_art');
                  },
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
        body: Obx(() => (NestedScrollView(
              controller: scrollController.scrollController.value,
              headerSliverBuilder: headerSliverBuilder,
              body: Container(
                margin: EdgeInsets.only(top: sliverMinHeight),
                child: CustomPageView(),
              ),
            ))),
        // topChild()
      ),
    );
  }

  List<Widget> headerSliverBuilder(
      BuildContext context, bool innerBoxIsScrolled) {
    return <Widget>[
      SliverOverlapAbsorber(
        handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
        sliver: SliverPersistentHeader(
          pinned: true,
          delegate: SliverHeaderDelegateCS(
            minHeight: 40,
            maxHeight: MediaQuery.of(context).size.height,
            minChild: SizedBox(
              height: 50,
              child: Row(
                children: <Widget>[
                  Expanded(child: CustomPageButton(title: "내 작품", page: 0)),
                  Expanded(child: CustomPageButton(title: "팔로워", page: 1)),
                ],
              ),
            ),
            maxChild: Stack(
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
                              '작가 아리아',
                              style: TextStyles.Heading2,
                            ),
                            Text('현대 아크릴 공예'),
                            Text('32 Followers'),
                            Container(
                              width: 300,
                              height: 40,
                              decoration: BoxDecoration(
                                color: ColorMap.gray_200,
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Center(child: Text('1000자')),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Container(
                                    height: 45,
                                    width: 140,
                                    child: Center(
                                        child: Text(
                                      '프로필 수정',
                                      style:
                                          TextStyle(color: ColorMap.gray_700),
                                    )),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      border:
                                          Border.all(color: ColorMap.gray_200),
                                    ),
                                  ),
                                  Container(
                                    height: 45,
                                    width: 140,
                                    child: Center(
                                        child: Text(
                                      '프로필 공유',
                                      style:
                                          TextStyle(color: ColorMap.gray_700),
                                    )),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      border:
                                          Border.all(color: ColorMap.gray_200),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 30),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Container(
                                    child: Padding(
                                      padding: const EdgeInsets.all(15.0),
                                      child: SvgPicture.asset(
                                          'assets/images/instagram_button.svg'),
                                    ),
                                    height: 56,
                                    width: 56,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border:
                                          Border.all(color: ColorMap.gray_200),
                                    ),
                                  ),
                                  Container(
                                    child: Padding(
                                      padding: const EdgeInsets.all(15.0),
                                      child: SvgPicture.asset(
                                          'assets/images/youtube_button.svg'),
                                    ),
                                    height: 56,
                                    width: 56,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border:
                                          Border.all(color: ColorMap.gray_200),
                                    ),
                                  ),
                                  Container(
                                    child: Padding(
                                      padding: const EdgeInsets.all(15.0),
                                      child: SvgPicture.asset(
                                          'assets/images/kakaotalk_button.svg'),
                                    ),
                                    height: 56,
                                    width: 56,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border:
                                          Border.all(color: ColorMap.gray_200),
                                    ),
                                  ),
                                  Container(
                                    child: Padding(
                                      padding: const EdgeInsets.all(15.0),
                                      child: SvgPicture.asset(
                                          'assets/images/email_button.svg'),
                                    ),
                                    height: 56,
                                    width: 56,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border:
                                          Border.all(color: ColorMap.gray_200),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 50,
                              child: Row(
                                children: <Widget>[
                                  Expanded(
                                      child: CustomPageButton(
                                          title: "내 작품", page: 0)),
                                  Expanded(
                                      child: CustomPageButton(
                                          title: "팔로워", page: 1)),
                                ],
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
        ),
      ),
    ];
  }
}

class CustomPageView extends GetView<ArtistMyPageController> {
  Widget build(BuildContext context) {
    Get.put(ArtistMyPageController());
    return PageView(
      controller: controller.pageController.value,
      children: [
        firstPage(),
        secondPage(),
      ],
      onPageChanged: (index) => controller.onPageChanged(index),
    );
  }

  Widget firstPage() {
    final colors = [
      Colors.red,
      Colors.purple,
      Colors.green,
      Colors.orange,
      Colors.yellow,
      Colors.pink,
      Colors.cyan,
      Colors.indigo,
      Colors.blue,
    ];
    return ListView.builder(
      itemCount: colors.length,
      itemBuilder: (BuildContext context, int index) {
        return Container(
          color: colors[index],
          height: 150,
        );
      },
    );
  }

  Widget secondPage() {
    final colors = [
      Colors.yellow,
      Colors.pink,
      Colors.red,
      Colors.purple,
      Colors.green,
      Colors.cyan,
      Colors.indigo,
      Colors.blue,
      Colors.orange,
    ];

    return ListView.builder(
      itemCount: colors.length,
      itemBuilder: (BuildContext context, int index) {
        return Container(
          color: colors[index],
          height: 150,
        );
      },
    );
  }
}

class CustomPageButton extends GetView<ArtistMyPageController> {
  final int page;
  final String title;

  CustomPageButton({required this.page, required this.title});

  Widget build(BuildContext context) {
    Get.put(ArtistMyPageController());
    return InkWell(
      splashColor: Color(0xFF204D7E),
      onTap: () => controller.pageBtnOnTap(page),
      child: Obx(
        () => Column(
          children: <Widget>[
            Expanded(
              child: Center(
                child: Text(
                  title,
                  style: TextStyle(
                      color: controller.isCurrentPage(page)
                          ? Color(0xFF2C313C)
                          : Color(0xFF9E9E9E)),
                ),
              ),
            ),
            Container(
              height: 1,
              color: controller.isCurrentPage(page)
                  ? ColorMap.mainColor
                  : Color(0xFFF1F1F1),
            ),
          ],
        ),
      ),
    );
  }
}

class SliverHeaderDelegateCS extends SliverPersistentHeaderDelegate {
  SliverHeaderDelegateCS({
    required this.minHeight,
    required this.maxHeight,
    required this.maxChild,
    required this.minChild,
  });
  double minHeight, maxHeight;
  final Widget maxChild, minChild;

  late double visibleMainHeight, animationVal, width;

  @override
  bool shouldRebuild(SliverHeaderDelegateCS oldDelegate) => true;
  @override
  double get minExtent => minHeight;
  @override
  double get maxExtent => max(maxHeight, minHeight);

  double scrollAnimationValue(double shrinkOffset) {
    double maxScrollAllowed = maxExtent - minExtent;

    return ((maxScrollAllowed - shrinkOffset) / maxScrollAllowed)
        .clamp(0, 1)
        .toDouble();
  }

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    width = MediaQuery.of(context).size.width;
    visibleMainHeight = max(maxExtent - shrinkOffset, minExtent);
    animationVal = scrollAnimationValue(shrinkOffset);

    return Container(
        height: visibleMainHeight,
        width: MediaQuery.of(context).size.width,
        color: Color(0xFFFFFFFF),
        child: Stack(
          children: <Widget>[
            getMinTop(),
            animationVal != 0 ? getMaxTop() : Container(),
          ],
        ));
  }

  Widget getMaxTop() {
    return Positioned(
      bottom: 0.0,
      child: Opacity(
        opacity: animationVal != 0 ? 1 : 0,
        child: SizedBox(
          height: maxHeight,
          width: width,
          child: maxChild,
        ),
      ),
    );
  }

  Widget getMinTop() {
    return Opacity(
      opacity: animationVal != 0 ? 0 : 1,
      child:
          Container(height: visibleMainHeight, width: width, child: minChild),
    );
  }
}
