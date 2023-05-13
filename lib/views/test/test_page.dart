import 'package:aria_client/constants/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TestPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Test Page'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Text('안녕하세요.\nHello.', style: TextStyles.Heading1),
              Text('안녕하세요.\nHello.', style: TextStyles.Heading2),
              Text('안녕하세요.\nHello.', style: TextStyles.Heading3),
              Text('안녕하세요.\nHello.', style: TextStyles.Heading4),
              Text('안녕하세요.\nHello.', style: TextStyles.Heading5),
              Text('안녕하세요.\nHello.', style: TextStyles.Heading6),
              Text('안녕하세요.\nHello.', style: TextStyles.Body1),
              Text('안녕하세요.\nHello.', style: TextStyles.Body2),
              Text('안녕하세요.\nHello.', style: TextStyles.Caption),
              Text('안녕하세요.\nHello.', style: TextStyles.Badge),
              ButtonBar(
                // mainAxisSize: MainAxisSize.max,
                alignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () => Get.toNamed('/splash'),
                    child: Text("스플래시"),
                  ),
                  ElevatedButton(
                    onPressed: () => Get.toNamed('/signin'),
                    child: Text("로그인"),
                  ),
                  ElevatedButton(
                    onPressed: () => Get.toNamed('/signup'),
                    child: Text("회원가입"),
                  ),
                  ElevatedButton(
                    onPressed: () => Get.toNamed('/home'),
                    child: Text("홈페이지"),
                  ),
                  ElevatedButton(
                    onPressed: () => Get.toNamed('/my'),
                    child: Text("마이페이지"),
                  ),
                  ElevatedButton(
                    onPressed: () => Get.toNamed('/edit_profile'),
                    child: Text("프로필 수정"),
                  ),
                  ElevatedButton(
                    onPressed: () => Get.toNamed('/artist_home'),
                    child: Text("작가 홈페이지"),
                  ),
                  ElevatedButton(
                    onPressed: () => Get.toNamed('/add_art'),
                    child: Text("작품 추가하기"),
                  ),
                  ElevatedButton(
                    onPressed: () => Get.toNamed('/detail'),
                    child: Text("작품 상세페이지"),
                  ),
                  ElevatedButton(
                    onPressed: () => Get.toNamed('/search'),
                    child: Text("검색페이지"),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
