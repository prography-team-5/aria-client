import 'package:get/get.dart';

import '../services/art_service.dart';
import '../services/artist_service.dart';
import '../services/auth_service.dart';
import '../services/profile_service.dart';
import '../viewmodels/my/edit_profile_viewmodel.dart';
import '../viewmodels/my/my_viewmodel.dart';
import '../viewmodels/search/search_viewmodel.dart';

import '../viewmodels/art/detail_viewmodel.dart';
import '../viewmodels/artist/add_art_viewmodel.dart';
import '../viewmodels/artist/artist_home_viewmodel.dart';
import '../viewmodels/auth/signin_viewmodel.dart';
import '../viewmodels/auth/signup_viewmodel.dart';
import '../viewmodels/auth/splash_viewmodel.dart';
import '../viewmodels/error/error_viewmodel.dart';
import '../viewmodels/main/home_viewmodel.dart';

class InitialBinding implements Bindings {
  @override
  void dependencies() {
    // Bindings for Service
    Get.lazyPut<ArtService>(() => ArtService());
    Get.lazyPut<ArtistService>(() => ArtistService());
    Get.lazyPut<AuthService>(() => AuthService());
    Get.lazyPut<ProfileService>(() => ProfileService());

    // TODO: 여러개 생성되는 View와 같은 경우(ex. Detail) main.dart의 Route에서 BindingBuilder로 처리해야 함
    // Bindings for ViewModel
    Get.lazyPut<HomeViewModel>(() => HomeViewModel());
    Get.lazyPut<MyViewModel>(() => MyViewModel());
    Get.lazyPut<EditProfileViewModel>(() => EditProfileViewModel());
    Get.lazyPut<SigninViewModel>(() => SigninViewModel());
    Get.lazyPut<SignupViewModel>(() => SignupViewModel());
    Get.lazyPut<SplashViewModel>(() => SplashViewModel());
    Get.lazyPut<SearchViewModel>(() => SearchViewModel());
    Get.lazyPut<ArtistHomeViewModel>(() => ArtistHomeViewModel());
    Get.lazyPut<AddArtViewModel>(() => AddArtViewModel());
    Get.lazyPut<DetailViewModel>(() => DetailViewModel());
    Get.lazyPut<ErrorViewModel>(() => ErrorViewModel());
  }
}
