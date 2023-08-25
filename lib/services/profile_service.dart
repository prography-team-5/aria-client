// fetchProfile()
// updateProfile()

import 'package:aria_client/helpers/env.dart';
import 'package:aria_client/helpers/network_adapter.dart';
import 'package:aria_client/models/follow.dart';
import 'package:get/get.dart';

import '../viewmodels/auth/signin_viewmodel.dart';

class ProfileService extends GetxService {
  Future<List<Followee>> fetchFolloweeList() async {
    final signInViewModel = Get.find<SigninViewModel>();
    List<Followee> followeeList = [];
    Map<String, dynamic> response = await NetworkAdapter().get(
        path: '/follows/followees/me', params: {}, token: signInViewModel.jwt);
    if (response['statusCode'] == 200) {
      followeeList =
          (response['body'] as List).map((e) => Followee.fromJson(e)).toList();
    } else {
      followeeList = [];
    }
    // DEV
    if (Env.env == Environ.test) {
      return [];
    }
    return followeeList;
  }
}
