import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/user_info_cubit.dart';
import '../cubit/user_info_state.dart';
import '../model/user_images_model.dart';
import 'image_detail_screen.dart';

class UserInfoScreen extends StatelessWidget {
  final int personId;

  UserInfoScreen({required this.personId});

  @override
  Widget build(BuildContext context) {
    context.read<UserInfoCubit>().fetchUserInfo(personId);

    return Scaffold(
      appBar: AppBar(
        title: Text('User Info'),
      ),
      body: BlocBuilder<UserInfoCubit, UserInfoState>(
        builder: (context, state) {
          if (state is UserInfoLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is UserInfoError) {
            return Center(child: Text(state.message));
          } else if (state is UserInfoLoaded) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  Text(state.userInfo.biography),
                  Text('Birthday: ${state.userInfo.birthday}'),
                  Text('Deathday: ${state.userInfo.deathday ?? 'N/A'}'),
                  SizedBox(height: 20),
                  GridView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
                    itemCount: state.images.length,
                    itemBuilder: (context, index) {
                      UserImage image = state.images[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ImageDetailScreen(imageUrl: image.filePath),
                            ),
                          );
                        },
                        child: Image.network('https://image.tmdb.org/t/p/w500${image.filePath}'),
                      );
                    },
                  ),
                ],
              ),
            );
          }
          return Center(child: Text('Unexpected state.'));
        },
      ),
    );
  }
}
