import 'package:bloc/bloc.dart';
import '../model/user_images_model.dart';
import '../model/user_info_model.dart';
import '../api_service/api_service.dart';
import 'user_info_state.dart';

class UserInfoCubit extends Cubit<UserInfoState> {
  UserInfoCubit() : super(UserInfoInitial());

  Future<void> fetchUserInfo(int personId) async {
    emit(UserInfoLoading());
    try {
      final userInfo = await ApiService.fetchUserInfoFromApi(personId);
      final images = await ApiService.fetchUserImagesFromApi(personId);
      emit(UserInfoLoaded(userInfo: userInfo, images: images));
    } catch (e) {
      emit(UserInfoError('Failed to load user info: ${e.toString()}'));
    }
  }
}
