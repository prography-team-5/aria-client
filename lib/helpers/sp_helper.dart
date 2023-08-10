import 'package:shared_preferences/shared_preferences.dart';

class SPHelper {
  static late SharedPreferences prefs;

  Future init() async {
    prefs = await SharedPreferences.getInstance();
  }

  // 검색어
  Future<List<String>> getSearchHistory() async {
    List<String> searchedKeywordList = prefs.getStringList('searchedKeywordList') ?? [];
    return searchedKeywordList;
  }

  Future saveSearchHistory(String searchedKeyword) async {
    List<String> searchedKeywordList = await getSearchHistory();
    searchedKeywordList.add(searchedKeyword);
    prefs.setStringList('searchedKeywordList', searchedKeywordList);
  }

  Future removeSearchHistory(idx) async {
    List<String> searchedKeywordList = await getSearchHistory();
    searchedKeywordList.removeAt(idx);
    prefs.setStringList('searchedKeywordList', searchedKeywordList);
  }
}
