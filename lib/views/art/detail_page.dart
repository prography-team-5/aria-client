import 'package:aria_client/constants/colormap.dart';
import 'package:aria_client/models/art.dart';
import 'package:aria_client/viewmodels/art/detail_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:expandable_page_view/expandable_page_view.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:url_launcher/url_launcher.dart';

class _TextStyles {
  static final Title = TextStyle(
      color: ColorMap.gray_600,
      fontSize: 16,
      fontWeight: FontWeight.w700,
      height: 1.5,
      letterSpacing: -0.25);

  static final ArtTitle = TextStyle(
      color: ColorMap.gray_700,
      fontSize: 24,
      fontWeight: FontWeight.w700,
      height: 1.3,
      letterSpacing: -0.25);

  static final ArtDescription = TextStyle(
      color: ColorMap.gray_600,
      fontSize: 16,
      fontWeight: FontWeight.w400,
      height: 1.5,
      letterSpacing: -0.25);

  static final ArtDetailTitle = TextStyle(
      color: ColorMap.gray_700,
      fontSize: 20,
      fontWeight: FontWeight.w800,
      height: 1.5,
      letterSpacing: -0.25);

  static final ArtDetailDescription = TextStyle(
      color: ColorMap.gray_400,
      fontWeight: FontWeight.w400,
      height: 1.5,
      letterSpacing: -0.25);

  static final ArtShareMessage = TextStyle(
      color: ColorMap.gray_700,
      fontSize: 20,
      fontWeight: FontWeight.w800,
      height: 1.5,
      letterSpacing: -0.25);
}

final GlobalKey _artDetailsAreaKey = GlobalKey();

_getPosition(GlobalKey key) {
  if (key.currentContext != null) {
    final RenderBox renderBox =
        key.currentContext!.findRenderObject() as RenderBox;
    final position = renderBox.localToGlobal(Offset.zero);
    return position;
  }
}

class _DetailPageController extends GetxController {
  final currentPageNotifier = ValueNotifier<int>(0);
}

class DetailPage extends StatelessWidget {
  final int artId;

  DetailPage({super.key, required this.artId});

  final detailViewModel = DetailViewModel();
  final detailPageController = _DetailPageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(56),
        child: AppBar(
          automaticallyImplyLeading: false,
          titleSpacing: 0,
          leadingWidth: 64,
          leading: Padding(
            padding: EdgeInsets.fromLTRB(12, 16, 0, 16),
            child: GestureDetector(
              onTap: () => Get.back(),
              child: SvgPicture.asset(
                'assets/images/leading_button.svg',
              ),
            ),
          ),
          title: Text('작품 상세', style: _TextStyles.Title),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0.0, // appBar 그림자 제거
        ),
      ),
      body: FutureBuilder(
          future: detailViewModel.fetchArtDetails(artId),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              Rxn<Art> art = snapshot.data!;
              print(art);
              return SingleChildScrollView(
                child: Column(
                  children: [
                    _artsPageView(art.value!.imagesUrl!),
                    _artDetailsArea(art),
                    Container(
                      color: ColorMap.gray_100,
                      width: double.infinity,
                      height: 8,
                    ),
                    _artShareArea(art.value!.artistSocialLinks!),
                  ],
                ),
              );
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }
            // 기본적으로 로딩 Spinner
            return CircularProgressIndicator();
          }),
    );
  }

  Widget _artsPageView(List<String> imagesUrl) {
    return ExpandablePageView.builder(
      itemCount: imagesUrl.length,
      itemBuilder: (BuildContext context, int index) {
        // var dotPosition = _getPosition(_artDetailsAreaKey);
        // print(dotPosition.dx);
        // print(dotPosition.dy);
        return Stack(
          children: [
            Image.network(
              imagesUrl[index],
              width: double.infinity,
            ),
            //TODO: width 값이 정확하지 않음...
            Transform.translate(
              offset: Offset(MediaQuery.of(context).size.width / 2 * 0.845, 12),
              child: DotsIndicator(
                dotsCount: imagesUrl.length,
                position: detailPageController.currentPageNotifier.value,
                decorator: DotsDecorator(
                  color: ColorMap.gray_700.withOpacity(0.3), // Inactive color
                  activeColor: ColorMap.mainColor,
                ),
              ),
            ),
          ],
        );
      },
      onPageChanged: (int index) {
        detailPageController.currentPageNotifier.value = index;
      },
    );
  }

  Widget _artDetailsArea(Rxn<Art> art) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 16, 24, 0),
      child: Column(
        key: _artDetailsAreaKey,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              //TODO: 작가프로필이미지 이슈 해결되면 주석 해제, 지우지 말 것!!!
              ClipPath(
                clipper: ShapeBorderClipper(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100)),
                ),
                child: Image.network(
                  art.value!.artistProfileImageUrl!,
                  fit: BoxFit.cover,
                  width: 48,
                  height: 48,
                ),
              ),
              SizedBox(width: 8),
              Text(art.value!.artistNickname!, style: _TextStyles.Title)
            ],
          ),
          SizedBox(height: 16),
          Text(art.value!.title, style: _TextStyles.ArtTitle),
          SizedBox(height: 16),
          Text(
            art.value!.description!,
            style: _TextStyles.ArtDescription,
          ),
          SizedBox(height: 40),
          Text(
            '작품 상세 정보',
            style: _TextStyles.ArtDetailTitle,
          ),
          SizedBox(height: 8),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Color(0xFFF4F2F2),
            ),
            width: double.infinity,
            height: 122,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text(
                        '제작 년도',
                        style: _TextStyles.ArtDetailDescription,
                      ),
                      Spacer(),
                      Text(
                        art.value!.year.toString(),
                        style: _TextStyles.ArtDetailDescription,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        '작품 크기',
                        style: _TextStyles.ArtDetailDescription,
                      ),
                      Spacer(),
                      Text(
                        art.value!.size.width.toString() +
                            ' x ' +
                            art.value!.size.height.toString(),
                        style: _TextStyles.ArtDetailDescription,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        '제작 기법',
                        style: _TextStyles.ArtDetailDescription,
                      ),
                      Spacer(),
                      Text(
                        art.value!.style,
                        style: _TextStyles.ArtDetailDescription,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 40),
        ],
      ),
    );
  }

  Widget _artShareArea(List<Sns> artistSocialLinks) {
    print(artistSocialLinks);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        artistSocialLinks.length != 0
            ? Column(
                children: [
                  SizedBox(height: 40),
                  Text(
                    '작품이 마음에 드셨나요?\n작가에게 응원의 메시지를 보내보세요.',
                    style: _TextStyles.ArtShareMessage,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 24),
                  Container(
                    // width: 262,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        artistSocialLinks.length,
                        (index) {
                          if (artistSocialLinks[index].socialType ==
                              'INSTAGRAM') {
                            return OutlinedButton(
                              onPressed: () {
                                launchUrl(
                                  Uri.parse(artistSocialLinks[index].url),
                                );
                              },
                              style: OutlinedButton.styleFrom(
                                  side: BorderSide(
                                      width: 1, color: ColorMap.gray_200),
                                  fixedSize: Size(56, 56),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(100),
                                  ),
                                  minimumSize: Size.zero,
                                  padding: EdgeInsets.all(16)),
                              child: SvgPicture.asset(
                                'assets/images/instagram_button.svg',
                                fit: BoxFit.cover,
                              ),
                            );
                          }
                          if (artistSocialLinks.length > 1) {
                            SizedBox(width: 12.67);
                          }
                          if (artistSocialLinks[index].socialType ==
                              'YOUTUBE') {
                            return OutlinedButton(
                              onPressed: () {
                                launchUrl(
                                  Uri.parse(artistSocialLinks[index].url),
                                );
                              },
                              style: OutlinedButton.styleFrom(
                                  side: BorderSide(
                                      width: 1, color: ColorMap.gray_200),
                                  fixedSize: Size(56, 56),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(100),
                                  ),
                                  minimumSize: Size.zero,
                                  padding: EdgeInsets.all(16)),
                              child: SvgPicture.asset(
                                'assets/images/youtube_button.svg',
                                fit: BoxFit.cover,
                              ),
                            );
                          }
                          if (artistSocialLinks.length > 2) {
                            SizedBox(width: 12.67);
                          }
                          if (artistSocialLinks[index].socialType == 'KAKAO') {
                            return OutlinedButton(
                              onPressed: () {
                                launchUrl(
                                  Uri.parse(artistSocialLinks[index].url),
                                );
                              },
                              style: OutlinedButton.styleFrom(
                                  side: BorderSide(
                                      width: 1, color: ColorMap.gray_200),
                                  fixedSize: Size(56, 56),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(100),
                                  ),
                                  minimumSize: Size.zero,
                                  padding: EdgeInsets.all(16)),
                              child: SvgPicture.asset(
                                'assets/images/kakaotalk_button.svg',
                                fit: BoxFit.cover,
                              ),
                            );
                          }
                          if (artistSocialLinks.length > 3) {
                            SizedBox(width: 12.67);
                          }
                          if (artistSocialLinks[index].socialType == 'EMAIL') {
                            return OutlinedButton(
                              onPressed: () {
                                launchUrl(
                                  Uri.parse('mailto:' + artistSocialLinks[index].url),
                                );
                              },
                              style: OutlinedButton.styleFrom(
                                  side: BorderSide(
                                      width: 1, color: ColorMap.gray_200),
                                  fixedSize: Size(56, 56),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(100),
                                  ),
                                  minimumSize: Size.zero,
                                  padding: EdgeInsets.all(16)),
                              child: SvgPicture.asset(
                                'assets/images/email_button.svg',
                                fit: BoxFit.cover,
                              ),
                            );
                          }
                          return Container();
                        },
                      ),
                    ),
                  ),
                  SizedBox(height: 40),
                ],
              )
            : Container()
      ],
    );
  }
}
