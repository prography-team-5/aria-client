import 'package:aria_client/helpers/sp_helper.dart';
import 'package:aria_client/models/art.dart';
import 'package:aria_client/viewmodels/search/search_viewmodel.dart';
import 'package:aria_client/views/art/detail_page.dart';
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

enum Status { before, after }

class _SearchPageController extends GetxController {
  final helper = SPHelper();
  final textFieldController = TextEditingController();

  Status status = Status.before;
  final searchViewModel = SearchViewModel();
  RxList<Art> artsList = RxList<Art>([]);
  // RxString keyword = ''.obs;

  @override
  void dispose() {
    textFieldController.dispose();
    super.dispose();
  }

  // @override
  // void onInit() {
  //   super.onInit();
  //   textFieldController.addListener(() {
  //     textFieldController.text = keyword.value;
  //     update();
  //   });
  // }

  //TODO: 필요없는 update() 삭제하기
  void changeMode(String mode) async {
    if (mode == 'before') {
      status = Status.before;
    } else {
      status = Status.after;
    }
    update();
  }

  void saveSearchHistory(String keyword) async {
    await helper.saveSearchHistory(keyword);
    update();
  }

  void removeSearchHistory(int idx) async {
    await helper.removeSearchHistory(idx);
    update();
  }

  void fillTextField(String keyword) {
    textFieldController.text = keyword;
    update();
  }

  void fetchData(String keyword) async {
    artsList = await searchViewModel.fetchArts(keyword);
  }
}

class SearchPage extends StatefulWidget {
  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final helper = SPHelper();
  final searchPageController = Get.put(_SearchPageController());

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
              child: _searchField(),
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 12, 0),
              child: TextButton(
                onPressed: () async {
                  FocusManager.instance.primaryFocus?.unfocus();
                  final keyword = searchPageController.textFieldController.text;
                  if (keyword.isNotEmpty) {
                    searchPageController.saveSearchHistory(keyword);
                    searchPageController.fetchData(keyword);
                    searchPageController.changeMode('after');
                  }
                },
                child: Text(
                  '검색',
                  style: _TextStyles.Search,
                ),
                style: TextButton.styleFrom(
                  backgroundColor: Colors.transparent,
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
        child: GetBuilder<_SearchPageController>(
          builder: (controller) {
            return searchPageController.status == Status.before
                ? FutureBuilder(
                    future: helper.getSearchHistory(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        List<String> historyList = snapshot.data!;
                        if (historyList.isNotEmpty) {
                          return _searchHistory(historyList);
                        } else
                          return Container();
                      } else if (snapshot.hasError) {
                        return Text("${snapshot.error}");
                      }
                      // 기본적으로 로딩 Spinner
                      return CircularProgressIndicator();
                    },
                  )
                : _searchResult(searchPageController.artsList);
          },
        ),
      ),
    );
  }

  Widget _searchField() {
    return TextField(
      controller: searchPageController.textFieldController,
      onTap: () {
        searchPageController.changeMode('before');
      },
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

  Widget _searchHistory(List<String> historyList) {
    final reversedList = historyList.reversed.toList();
    return ListView.builder(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      itemCount: historyList.length,
      itemBuilder: (BuildContext context, int index) {
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(24, 0, 24, 0),
            child: ListTile(
              onTap: () {
                searchPageController.fillTextField(reversedList[index]);
                FocusManager.instance.primaryFocus?.unfocus();
                searchPageController.fetchData(reversedList[index]);
                searchPageController.changeMode('after');
              },
              contentPadding: EdgeInsets.fromLTRB(0, 4, 0, 4),
              title:
                  Text(reversedList[index], style: _TextStyles.SearchHistory),
              trailing: GestureDetector(
                onTap: () async {
                  searchPageController.removeSearchHistory(index);
                },
                child: SvgPicture.asset(
                  'assets/images/cancel_button.svg',
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _searchResult(RxList<Art> artsList) {
    return ListView.builder(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      itemCount: artsList.length,
      itemBuilder: (BuildContext context, int index) {
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // SizedBox(height: 24),
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
                        artsList[index].mainImageUrl!,
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
                          child: Text(artsList[index].title,
                              style: _TextStyles.ArtTitle)),
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
                        artsList[index].year.toString() +
                            '  |  ' +
                            artsList[index].style +
                            '  |  ' +
                            artsList[index].size.width.toString() +
                            ' X ' +
                            artsList[index].size.height.toString(),
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
      },
    );
  }
}
