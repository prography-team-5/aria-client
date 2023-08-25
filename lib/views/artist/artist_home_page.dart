import 'package:aria_client/models/art.dart';
import 'package:aria_client/models/artist_info.dart';
import 'package:aria_client/services/artist_service.dart';
import 'package:aria_client/views/my/artist_my_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../constants/colormap.dart';
import '../../constants/text_styles.dart';
import '../../viewmodels/auth/signin_viewmodel.dart';

class ArtistHomeViewModel extends GetxController {
  final SigninViewModel signinViewModel = Get.find<SigninViewModel>();
  Rx<ArtistInfo>? artistInfo;
  RxList<Art> artList = <Art>[].obs;
  RxBool isLoading = false.obs;
  Future<void> getArtList() async {
    isLoading.value = true;
    artList.value = await Get.find<ArtistService>().fetchArtistArts();
    isLoading.value = false;
    update();
  }

  @override
  void onInit() async {
    super.onInit();
    await getArtList();
  }
}

class ArtistHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print('[+] Parameter: ${Get.arguments}');
    final controller = Get.put(ArtistHomeViewModel());
    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          leading: Padding(
            padding: EdgeInsets.fromLTRB(12, 16, 0, 16),
            child: InkWell(
              onTap: () {
                Get.back();
              },
              child: SvgPicture.asset(
                'assets/images/leading_button.svg',
                color: Colors.white,
              ),
            ),
          ),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0.0, // appBar 그림자 제거
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Column(
                    children: [
                      Container(
                        height: 147,
                        color: Color(0xff2D2942), // TODO: 이미지 가져오기
                      ),
                      Container(
                        // height: 200,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 30 + 5),
                          child: Column(
                            children: [
                              Text(
                                controller.signinViewModel.member!.nickname,
                                style: TextStyles.Heading2,
                              ),
                              Padding(padding: EdgeInsets.all(5)),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(0, 4, 0, 0),
                                child: Text('현대 아크릴 공예'),
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(0, 6, 0, 8),
                                child: Text('32 Followers'),
                              ),
                              Container(
                                width: 340,
                                height: 40,
                                decoration: BoxDecoration(
                                  color: ColorMap.gray_200,
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Center(child: Text('1000자')),
                              ),
                              TextButton(
                                onPressed: () {},
                                child: Text(
                                  '팔로우', // TODO: 팔로우 기능 구현
                                  style: TextStyle(color: ColorMap.gray_700),
                                ),
                                style: TextButton.styleFrom(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 150, vertical: 13),
                                  shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                        color: ColorMap.gray_200, width: 1),
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    // const EdgeInsets.symmetric(horizontal: 30),
                                    const EdgeInsets.all(10),
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
                                        border: Border.all(
                                            color: ColorMap.gray_200),
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
                                        border: Border.all(
                                            color: ColorMap.gray_200),
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
                                        border: Border.all(
                                            color: ColorMap.gray_200),
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
                                        border: Border.all(
                                            color: ColorMap.gray_200),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        height: 8,
                        color: ColorMap.gray_100,
                      ),
                    ],
                  ),
                  Positioned(
                    top: 147 - 50,
                    child: Container(
                      height: 80,
                      width: 80,
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(
                          controller.signinViewModel.member!
                              .profileImageUrl, // TODO: 이미지 가져오기(작가꺼)
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Flexible(
              child: Container(
                padding: EdgeInsets.all(15),
                child: GetBuilder<ArtistHomeViewModel>(
                  builder: (controller) {
                    return controller.isLoading.value
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : controller.artList.isEmpty
                            ? const Center(
                                child: Text('작품이 없습니다!'),
                              )
                            : ListView.builder(
                                itemBuilder: (context, index) {
                                  return Obx(() => Container());
                                },
                                itemCount: controller.artList.length,
                              );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ArtListTile extends StatelessWidget {
  final Art art;
  const ArtListTile({required this.art});
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
