import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../constants/colormap.dart';

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
}

class SearchPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.transparent,
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
          title: Container(
            width: double.infinity,
            height: 48,
            // color: Colors.white,
            child: Center(
              child: SearchField(),
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 12, 0),
              child: GestureDetector(
                onTap: () => {},
                child: TextButton(
                  onPressed: () {},
                  child: Text(
                    '검색',
                    style: _TextStyles.Search,
                  ),
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.transparent,
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
      body: Container(),
    );
  }
}

class SearchField extends StatefulWidget {
  const SearchField({Key? key}) : super(key: key);

  @override
  State<SearchField> createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> {
  final FocusNode _focusNode = FocusNode();
  late OverlayEntry _overlayEntry;

  @override
  void initState() {
    _focusNode.addListener(
          () {
        if (_focusNode.hasFocus) {
          _overlayEntry = _createOverlayEntry();
          Overlay.of(context).insert(_overlayEntry);
        } else {
          _overlayEntry.remove();
        }
      },
    );
  }

  OverlayEntry _createOverlayEntry() {
    RenderBox? renderBox = context.findRenderObject() as RenderBox;
    var size = renderBox.size;
    var offset = renderBox.localToGlobal(Offset.zero);

    return OverlayEntry(
      builder: (context) => Positioned(
        left: offset.dx,
        top: offset.dy + size.height + 5,
        width: size.width,
        child: Material(
          elevation: 4,
          child: ListView(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            children: [
              ListTile(
                title: Text('애니메이션'),
              ),
              ListTile(
                title: Text('일러스트'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      focusNode: _focusNode,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.all(10),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: ColorMap.gray_200, width: 1),
          borderRadius: BorderRadius.circular(8),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: ColorMap.gray_200, width: 1),
          borderRadius: BorderRadius.circular(8),
        ),
        hintText: '검색어를 입력하세요.',
        hintStyle: _TextStyles.Hint,
        prefixIcon: Icon(
          Icons.search,
          size: 20,
          color: ColorMap.gray_400,
        ),
      ),
    );
  }
}

