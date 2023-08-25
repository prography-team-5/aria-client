import 'package:aria_client/models/art.dart';
import 'package:aria_client/models/artist_info.dart';
import 'package:aria_client/services/artist_service.dart';
import 'package:aria_client/views/art/detail_page.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../constants/colormap.dart';
import '../../constants/text_styles.dart';
import '../../viewmodels/auth/signin_viewmodel.dart';

class ArtistHomeViewModel extends GetxController {
  final SigninViewModel signinViewModel = Get.find<SigninViewModel>();
  Rx<ArtistInfo> artistInfo = ArtistInfo(
    profile_art_image_url: '',
    artist_profile: ArtistProfile(
      member_id: 0,
      profile_image_url: '',
      nickname: '',
    ),
    intro: '',
    artist_tags: [],
    social_links: [],
    isFollowee: false,
    follower_count: 0,
  ).obs;

  RxList<Art> artList = <Art>[].obs;
  RxBool isLoading = false.obs;
  RxBool isArtsLoading = false.obs;
  RxBool isFollowee = false.obs;

  Future<void> getArts() async {
    isArtsLoading.value = true;
    artList.value = await Get.find<ArtistService>()
        .fetchArtistArts(Get.arguments) as List<Art>;
    isArtsLoading.value = false;
    update();
  }

  Future<void> getArtistInfo() async {
    isLoading.value = true;
    artistInfo.value = await Get.find<ArtistService>()
        .fetchArtist(Get.arguments) as ArtistInfo;
    isFollowee.value = artistInfo.value.isFollowee;
    isLoading.value = false;
    update();
  }

  Future<void> follow() async {
    await Get.find<ArtistService>().follow(Get.arguments);
    isFollowee.value = true;
    update();
    refresh();
  }

  Future<void> unfollow() async {
    await Get.find<ArtistService>().unfollow(Get.arguments);
    isFollowee.value = false;
    update();
    refresh();
  }

  @override
  void onInit() async {
    super.onInit();
    await getArts();
    await getArtistInfo();
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
              ),
            ),
          ),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0.0, // appBar 그림자 제거
        ),
        body: ListView(
          children: [
            GetBuilder<ArtistHomeViewModel>(
              builder: (controller) {
                return controller.isLoading.value
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : Obx(
                        () => Container(
                          height: MediaQuery.of(context).size.height,
                          child: ListView(
                            // crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    Column(
                                      children: [
                                        Container(
                                          height: 300,
                                          width:
                                              MediaQuery.of(context).size.width,
                                          child: controller.artistInfo.value
                                                      .profile_art_image_url ==
                                                  ""
                                              ? const Center(
                                                  child:
                                                      CircularProgressIndicator())
                                              : Image.network(
                                                  controller.artistInfo.value
                                                      .profile_art_image_url,
                                                  fit: BoxFit.fill,
                                                ),
                                        ),
                                        Container(
                                          // height: 200,
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                top: 30 + 5),
                                            child: Column(
                                              children: [
                                                Text(
                                                  controller.artistInfo.value
                                                      .artist_profile.nickname,
                                                  style: TextStyles.Heading2,
                                                ),
                                                Padding(
                                                    padding: EdgeInsets.all(5)),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.fromLTRB(
                                                          0, 4, 0, 0),
                                                  child: controller
                                                          .artistInfo
                                                          .value
                                                          .artist_tags
                                                          .isEmpty
                                                      ? Text('아티스트 태그가 없습니다.')
                                                      : Text(controller
                                                          .artistInfo
                                                          .value
                                                          .artist_tags
                                                          .map((e) => e.name)
                                                          .join(', ')),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.fromLTRB(
                                                          0, 6, 0, 8),
                                                  child: Text(
                                                    '${controller.artistInfo.value.follower_count} Followers',
                                                  ),
                                                ),
                                                Container(
                                                  width: 340,
                                                  height: 40,
                                                  decoration: BoxDecoration(
                                                    color: ColorMap.gray_200,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15),
                                                  ),
                                                  child: Center(
                                                    child: Text(
                                                      controller
                                                                  .artistInfo
                                                                  .value
                                                                  .intro ==
                                                              ''
                                                          ? '아티스트 소개가 없습니다.'
                                                          : controller
                                                              .artistInfo
                                                              .value
                                                              .intro,
                                                    ),
                                                  ),
                                                ),
                                                Obx(
                                                  () => TextButton(
                                                    onPressed: controller
                                                            .isFollowee.value
                                                        ? () {
                                                            // unfollow
                                                            controller
                                                                .unfollow();
                                                          }
                                                        : () {
                                                            // follow
                                                            controller.follow();
                                                          },
                                                    child: Text(
                                                      controller
                                                              .isFollowee.value
                                                          ? '팔로잉'
                                                          : '팔로우', // TODO: 팔로우 기능 구현
                                                      style: TextStyle(
                                                        color: controller
                                                                .isFollowee
                                                                .value
                                                            ? ColorMap.gray_700
                                                            : ColorMap.white,
                                                      ),
                                                    ),
                                                    style: TextButton.styleFrom(
                                                      backgroundColor:
                                                          controller.isFollowee
                                                                  .value
                                                              ? ColorMap.white
                                                              : ColorMap
                                                                  .subColor,
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 150,
                                                              vertical: 13),
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        side: BorderSide(
                                                          color:
                                                              ColorMap.gray_200,
                                                          width: controller
                                                                  .isFollowee
                                                                  .value
                                                              ? 1
                                                              : 0,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(15),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      // const EdgeInsets.symmetric(horizontal: 30),
                                                      const EdgeInsets.all(10),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                    children: [
                                                      Container(
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(15.0),
                                                          child: SvgPicture.asset(
                                                              'assets/images/instagram_button.svg'),
                                                        ),
                                                        height: 56,
                                                        width: 56,
                                                        decoration:
                                                            BoxDecoration(
                                                          shape:
                                                              BoxShape.circle,
                                                          border: Border.all(
                                                              color: ColorMap
                                                                  .gray_200),
                                                        ),
                                                      ),
                                                      Container(
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(15.0),
                                                          child: SvgPicture.asset(
                                                              'assets/images/youtube_button.svg'),
                                                        ),
                                                        height: 56,
                                                        width: 56,
                                                        decoration:
                                                            BoxDecoration(
                                                          shape:
                                                              BoxShape.circle,
                                                          border: Border.all(
                                                              color: ColorMap
                                                                  .gray_200),
                                                        ),
                                                      ),
                                                      Container(
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(15.0),
                                                          child: SvgPicture.asset(
                                                              'assets/images/kakaotalk_button.svg'),
                                                        ),
                                                        height: 56,
                                                        width: 56,
                                                        decoration:
                                                            BoxDecoration(
                                                          shape:
                                                              BoxShape.circle,
                                                          border: Border.all(
                                                              color: ColorMap
                                                                  .gray_200),
                                                        ),
                                                      ),
                                                      Container(
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(15.0),
                                                          child: SvgPicture.asset(
                                                              'assets/images/email_button.svg'),
                                                        ),
                                                        height: 56,
                                                        width: 56,
                                                        decoration:
                                                            BoxDecoration(
                                                          shape:
                                                              BoxShape.circle,
                                                          border: Border.all(
                                                              color: ColorMap
                                                                  .gray_200),
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
                                      top: 300 - 40,
                                      child: Container(
                                        height: 80,
                                        width: 80,
                                        child: CircleAvatar(
                                          backgroundImage: NetworkImage(
                                            controller
                                                .artistInfo
                                                .value
                                                .artist_profile
                                                .profile_image_url,
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.fromLTRB(15, 15, 15, 50),
                                child: controller.isArtsLoading.value
                                    ? const Center(
                                        child: CircularProgressIndicator(),
                                      )
                                    : controller.artList.isEmpty
                                        ? const Center(
                                            child: Text('작품이 없습니다!'),
                                          )
                                        : ListView.builder(
                                            shrinkWrap: true,
                                            physics:
                                                NeverScrollableScrollPhysics(),
                                            itemBuilder: (context, index) {
                                              return ArtListTile(
                                                  art: controller
                                                      .artList[index]);
                                            },
                                            itemCount:
                                                controller.artList.length,
                                          ),
                              ),
                            ],
                          ),
                        ),
                      );
              },
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
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  //TODO: arguments를 artId 변수로 수정
                  Get.to(() => DetailPage(artId: 3));
                },
                child: ClipPath(
                  clipper: ShapeBorderClipper(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                  child: Image.network(
                    art.mainImageUrl!,
                    fit: BoxFit.cover,
                    height: 407,
                    width: double.infinity,
                  ),
                ),
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  GestureDetector(
                      onTap: () {
                        Get.to(() => DetailPage(artId: 3));
                      },
                      child: Text(art.title, style: _TextStyles.ArtTitle)),
                  Spacer(),
                  GestureDetector(
                    onTap: () {
                      //TODO: 신고기능 추가
                    },
                    child: SvgPicture.asset(
                      'assets/images/more_button.svg',
                      fit: BoxFit.cover,
                      height: 24,
                      width: 24,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8),
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
                    style: _TextStyles.ArtFeature,
                  )
                ],
              ),
              SizedBox(height: 26),
            ],
          ),
        ),
        Container(
          color: ColorMap.gray_100,
          width: double.infinity,
          height: 8,
        ),
      ],
    );
  }
}

class _TextStyles {
  static const Search = TextStyle(
      color: ColorMap.gray_700,
      fontSize: 16,
      fontWeight: FontWeight.w800,
      height: 1.5,
      letterSpacing: -0.25);

  static const Hint = TextStyle(
      color: ColorMap.gray_400,
      fontSize: 16,
      fontWeight: FontWeight.w400,
      height: 1.5,
      letterSpacing: -0.25);

  static const SearchHistory = TextStyle(
      color: ColorMap.gray_500,
      fontSize: 16,
      fontWeight: FontWeight.w400,
      height: 1.5,
      letterSpacing: -0.25);

  static const ArtTitle = TextStyle(
      color: ColorMap.gray_600,
      fontSize: 20,
      fontWeight: FontWeight.w800,
      height: 1.5,
      letterSpacing: -0.25);

  static const ArtFeature = TextStyle(
      color: ColorMap.gray_400,
      fontSize: 14,
      fontWeight: FontWeight.w400,
      height: 1.5,
      letterSpacing: -0.25);
}
