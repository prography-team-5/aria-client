import 'package:aria_client/constants/text_styles.dart';
import 'package:flutter/material.dart';

class TestPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Test Page'),
      ),
      body: Center(
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
          ],
        ),
      ),
    );
  }
}
