import 'package:aria_client/helpers/sp_helper.dart';
import 'package:aria_client/models/art.dart';
import 'package:aria_client/viewmodels/search/search_viewmodel.dart';
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
}

enum Status { before, after }

class _SearchPageController extends GetxController {
  final helper = SPHelper();
  final textFieldController = TextEditingController();

  Status status = Status.before;
  final searchViewModel = SearchViewModel();
  RxList<Art> artsList = RxList<Art>([]);

  @override
  void dispose() {
    textFieldController.dispose();
    super.dispose();
  }

  void changeMode() async {
    if (status == Status.before) {
      status = Status.after;
    } else {
      status = Status.before;
    }
    update();
  }

  void saveSearchHistory(String keyword) async {
    await helper.saveSearchHistory(keyword);
    update(); //위젯 빌드 다시
  }

  void removeSearchHistory(int idx) async {
    await helper.removeSearchHistory(idx);
    update(); //위젯 빌드 다시
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
                  final keyword = searchPageController.textFieldController.text;
                  if (keyword.isNotEmpty) {
                    searchPageController.saveSearchHistory(keyword);
                    searchPageController.status = Status.after;
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
        margin: EdgeInsets.fromLTRB(24, 4, 24, 12),
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
                : //TODO: 검색 결과 화면 UI 개발
                _searchResult(searchPageController.artsList);
          },
        ),
      ),
    );
  }

  Widget _searchField() {
    return TextField(
      controller: searchPageController.textFieldController,
      onTap: () {
        searchPageController.changeMode();
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
    return ListView.builder(
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        itemCount: historyList.length,
        itemBuilder: (BuildContext context, int index) {
          return SingleChildScrollView(
            child: ListTile(
              onTap: () {
                //TODO: historyList[index]로 search get api 호출
                searchPageController.fetchData(historyList[index]);
                searchPageController.changeMode();
              },
              contentPadding: EdgeInsets.fromLTRB(0, 4, 0, 4),
              title: Text(historyList[index], style: _TextStyles.SearchHistory),
              trailing: GestureDetector(
                onTap: () async {
                  searchPageController.removeSearchHistory(index);
                },
                child: SvgPicture.asset(
                  'assets/images/cancel_button.svg',
                ),
              ),
            ),
          );
        });
  }

  Widget _searchResult(RxList<Art> artsList) {
    return Text(artsList[0].title);
  }
}
