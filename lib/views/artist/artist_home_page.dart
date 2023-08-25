import 'package:aria_client/models/art.dart';
import 'package:aria_client/models/artist_info.dart';
import 'package:aria_client/services/artist_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../constants/colormap.dart';
import '../../constants/text_styles.dart';
import '../../viewmodels/auth/signin_viewmodel.dart';

class ArtistHomeViewModel extends GetxController {
  final SigninViewModel signinViewModel = Get.find<SigninViewModel>();
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
    final controller = Get.put(ArtistHomeViewModel());
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(56),
          child: AppBar(
            automaticallyImplyLeading: false,
            // title: Text(
            //   '프로필',
            //   style: TextStyle(
            //       color: ColorMap.gray_700,
            //       fontSize: 16,
            //       fontWeight: FontWeight.w500),
            // ),
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
                  onPressed: () async {
                    final uri =
                        Uri.parse('https://forms.gle/DkAtGJ6jdaFCi4ad7');
                    if (!await launchUrl(uri,
                        mode: LaunchMode.externalApplication))
                      throw Exception('Could not launch ${uri.toString()}');
                  },
                  child: Text(
                    '작가 신청',
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
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 147 + 140,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Column(
                    children: [
                      Container(
                        height: 147,
                        color: Color(0xff2D2942),
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
                              TextButton(
                                onPressed: () {
                                  Get.toNamed('/user_edit_profile');
                                },
                                child: Text(
                                  '프로필 수정',
                                  style: TextStyle(color: ColorMap.gray_700),
                                ),
                                style: TextButton.styleFrom(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 130, vertical: 13),
                                  shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                        color: ColorMap.gray_200, width: 1),
                                    borderRadius: BorderRadius.circular(15),
                                  ),
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
                      height: 100.0,
                      width: 100.0,
                      // TODO: s3 버켓 해결 후 수정
                      // child: Image.asset('assets/images/profile_avatar.png'),
                      child: Image.network(
                        controller.signinViewModel.member!.profileImageUrl,
                      ),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                    ),
                  )
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(15),
              child: Text('팔로우한 작가'),
            ),
            Flexible(
              child: Container(
                padding: EdgeInsets.all(15),
                // child: GetBuilder<UserMyPageViewModel>(
                //   builder: (controller) {
                //     return controller.isLoading.value
                //         ? const Center(
                //             child: CircularProgressIndicator(),
                //           )
                //         : controller.followeeList.isEmpty
                //             ? const Center(
                //                 child: Text('아직 팔로우한 작가가 없습니다.'),
                //               )
                //             : GridView.builder(
                //                 gridDelegate:
                //                     SliverGridDelegateWithFixedCrossAxisCount(
                //                   crossAxisCount: 3,
                //                   childAspectRatio: 1,
                //                   crossAxisSpacing: 10,
                //                   mainAxisSpacing: 20,
                //                   mainAxisExtent: 130,
                //                 ),
                //                 itemCount: controller.followeeList.length,
                //                 itemBuilder: (context, index) {
                //                   return Obx(
                //                     () => FollowAvatar(
                //                       follow: controller.followeeList[index],
                //                     ),
                //                   );
                //                 },
                //               );
                //   },
                // ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FollowAvatar extends StatelessWidget {
  final ArtistInfo follow;
  FollowAvatar({required this.follow});
  @override
  Widget build(BuildContext context) {
    return Container(
      // width: 150,
      // height: 150,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 100.0,
            width: 100.0,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: NetworkImage(follow.profile_art_image_url),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(5),
            child: Text(
              "nickname",
              // follow.nickname,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
