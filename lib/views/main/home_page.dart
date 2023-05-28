import 'package:aria_client/constants/colormap.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart' as svg_provider;

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          image: svg_provider.Svg('assets/image_example.svg'),
        ),
      ),
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
              SizedBox(
                width: 342,
                height: 592,
                child: Container(color: Colors.white),
              ),
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
    );
  }
}
