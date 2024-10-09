import '../model/user_info_model.dart';
import '../model/user_images_model.dart';

abstract class UserInfoState {}

class UserInfoInitial extends UserInfoState {}

class UserInfoLoading extends UserInfoState {}

class UserInfoLoaded extends UserInfoState {
  final UserInfo userInfo;
  final List<UserImage> images;

  UserInfoLoaded({required this.userInfo, required this.images});

  @override
  List<Object> get props => [userInfo, images];
}

class UserInfoError extends UserInfoState {
  final String message;

  UserInfoError(this.message);

  @override
  List<Object> get props => [message];
}
