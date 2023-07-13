import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../constants/colormap.dart';

class ArtistMyPage extends StatefulWidget {
  @override
  _ArtistMyPageState createState() => _ArtistMyPageState();
}

class _ArtistMyPageState extends State<ArtistMyPage> {
  ScrollController scrollController = ScrollController();
  PageController pageController = PageController(initialPage: 0);

  final double sliverMinHeight = 0.0;
  int pageIndex = 0;

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

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    scrollController.dispose();
    pageController.dispose();
    super.dispose();
  }

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
                child: OutlinedButton(onPressed: () {}, child: Text('작가 신청')),
              ),
            ],
            centerTitle: true,
            backgroundColor: Colors.transparent,
            elevation: 0.0, // appBar 그림자 제거
          ),
        ),
        body:
            // topChild()
            NestedScrollView(
          controller: scrollController,
          headerSliverBuilder: headerSliverBuilder,
          body: Container(
            margin: EdgeInsets.only(top: sliverMinHeight),
            child: mainPageView(),
          ),
        ),
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
            minChild: minTopChild(),
            maxChild: topChild(),
          ),
        ),
      ),
    ];
  }

  Widget minTopChild() {
    // return Container();
    return pageButtonLayout();
  }

  Widget topChild() {
    return Stack(
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
                padding: const EdgeInsets.only(top: 50 + 5),
                child: Column(
                  children: [
                    Text('작가 아리아'),
                    Text('현대 아크릴 공예'),
                    Text('32 Followers'),
                    Container(
                      width: 350,
                      height: 40,
                      decoration: BoxDecoration(
                        color: ColorMap.gray_200,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Center(child: Text('1000자')),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(onPressed: () {}, child: Text('프로필 수정')),
                        TextButton(onPressed: () {}, child: Text('프로필 수정'))
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          height: 56,
                          width: 56,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: ColorMap.gray_200),
                          ),
                        ),
                        Container(),
                        Container(),
                        Container(),
                      ],
                    ),
                    pageButtonLayout(),
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
    );
  }

  Widget pageButtonLayout() {
    return SizedBox(
      height: 50,
      child: Row(
        children: <Widget>[
          Expanded(child: pageButton("page 1", 0)),
          Expanded(child: pageButton("page 2", 1)),
        ],
      ),
    );
  }

  Widget pageButton(String title, int page) {
    final fontColor = pageIndex == page ? Color(0xFF2C313C) : Color(0xFF9E9E9E);
    final lineColor = pageIndex == page ? Color(0xFF014F90) : Color(0xFFF1F1F1);

    return InkWell(
      splashColor: Color(0xFF204D7E),
      onTap: () => pageBtnOnTap(page),
      child: Column(
        children: <Widget>[
          Expanded(
            child: Center(
              child: Text(
                title,
                style: TextStyle(
                  color: fontColor,
                ),
              ),
            ),
          ),
          Container(
            height: 1,
            color: lineColor,
          ),
        ],
      ),
    );
  }

  pageBtnOnTap(int page) {
    setState(() {
      pageIndex = page;
      pageController.animateToPage(pageIndex,
          duration: Duration(milliseconds: 700), curve: Curves.easeOutCirc);
    });
  }

  Widget mainPageView() {
    return PageView(
      controller: pageController,
      children: <Widget>[
        pageItem(Center(
          child: Text(
            "page 2\n\n두번째\n\n페이지\n\n스크롤이\n\n되도록\n\n내용을\n\n길게\n\n길게",
            style: TextStyle(fontSize: 100),
          ),
        )),
        pageListView(),
      ],
      onPageChanged: (index) => setState(() => pageIndex = index),
    );
  }

  Widget pageItem(Widget child) {
    double statusHeight = MediaQuery.of(context).padding.top;
    double height = MediaQuery.of(context).size.height;
    double minHeight = height - statusHeight - sliverMinHeight;

    return SingleChildScrollView(
      child: Container(
        color: Colors.white,
        constraints: BoxConstraints(minHeight: 600),
        child: child,
      ),
    );
  }

  Widget pageListView() {
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
