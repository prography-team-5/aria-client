import 'package:aria_client/constants/colormap.dart';
import 'package:aria_client/models/art.dart';
import 'package:aria_client/viewmodels/art/detail_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

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

class DetailPage extends StatelessWidget {
  final int artId;
  DetailPage({super.key, required this.artId});

  final detailViewModel = DetailViewModel();
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
        future: detailViewModel.fetchArtDetails(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            Rxn<Art> art = snapshot.data!;
            print(art);
            return SingleChildScrollView(
              child: Column(
                children: [
                  Image.network(
                    art.value!.imagesUrl![0],
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),
                  _artDetailsArea(art),
                  Container(
                    color: ColorMap.gray_100,
                    width: double.infinity,
                    height: 8,
                  ),
                  _artShareArea(),
                ],
              ),
            );
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }
          // 기본적으로 로딩 Spinner
          return CircularProgressIndicator();
        }
      ),
    );
  }

  Widget _artDetailsArea(Rxn<Art> art) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 16, 24, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
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
          Text(art.value!.title,
              style: _TextStyles.ArtTitle),
          SizedBox(height: 16),
          Text(
            art.value!.description,
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
                        art.value!.size.width.toString() + ' x ' + art.value!.size.height.toString(),
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

  Widget _artShareArea() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(height: 40),
        Text(
          '작품이 마음에 드셨나요?\n작가에게 응원의 메시지를 보내보세요.',
          style: _TextStyles.ArtShareMessage,
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 24),
        Container(
          width: 262,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              OutlinedButton(
                onPressed: () {
                  // Get.toNamed('/test_page');
                },
                style: OutlinedButton.styleFrom(
                    side: BorderSide(width: 1, color: ColorMap.gray_200),
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
              ),
              OutlinedButton(
                onPressed: () {
                  // Get.toNamed('/test_page');
                },
                style: OutlinedButton.styleFrom(
                    side: BorderSide(width: 1, color: ColorMap.gray_200),
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
              ),
              OutlinedButton(
                onPressed: () {
                  // Get.toNamed('/test_page');
                },
                style: OutlinedButton.styleFrom(
                    side: BorderSide(width: 1, color: ColorMap.gray_200),
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
              ),
              OutlinedButton(
                onPressed: () {
                  // Get.toNamed('/test_page');
                },
                style: OutlinedButton.styleFrom(
                    side: BorderSide(width: 1, color: ColorMap.gray_200),
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
              ),
            ],
          ),
        ),
        SizedBox(height: 40),
      ],
    );
  }
}
