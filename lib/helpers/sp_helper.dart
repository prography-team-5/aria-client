import 'package:shared_preferences/shared_preferences.dart';

class SPHelper {
  static late SharedPreferences prefs;

  Future init() async {
    prefs = await SharedPreferences.getInstance();
  }

  // 검색어
  Future<List<String>> getSearchedKeywords() async {
    List<String> searchedKeywordList = prefs.getStringList('searchedKeywordList') ?? [];
    return searchedKeywordList;
  }

  Future saveSearchedKeyword(String searchedKeyword) async {
    List<String> searchedKeywordList = await getSearchedKeywords();
    searchedKeywordList.add(searchedKeyword);
    prefs.setStringList('searchedKeywordList', searchedKeywordList);
  }

  Future removeSearchedKeywords(idx) async {
    List<String> searchedKeywordList = await getSearchedKeywords();
    searchedKeywordList.removeAt(idx);
    prefs.setStringList('searchedKeywordList', searchedKeywordList);
  }
}
