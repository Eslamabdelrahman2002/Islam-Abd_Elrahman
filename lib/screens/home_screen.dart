import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/famous_persons_state.dart';
import '../cubit/user_info_cubit.dart';
import '../cubit/famous_persons_cubit.dart';
import '../model/person_model.dart';
import 'user_info_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Famous Persons'),
        actions: [
          IconButton(
            icon: Icon(Icons.favorite),
            onPressed: () {
              Navigator.pushNamed(context, '/favorites');
            },
          ),
        ],
      ),
      body: BlocBuilder<FamousPersonsCubit, FamousPersonsState>(
        builder: (context, state) {
          if (state is FamousPersonsLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is FamousPersonsError) {
            return Center(child: Text(state.message));
          } else if (state is FamousPersonsLoaded) {
            return ListView.builder(
              itemCount: state.persons.length,
              itemBuilder: (context, index) {
                final person = state.persons[index];
                final imageUrl = person.profilePath != null
                    ? 'https://image.tmdb.org/t/p/w500${person.profilePath}'
                    : 'https://via.placeholder.com/150';

                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(imageUrl),
                  ),
                  title: Text(person.name),
                  trailing: IconButton(
                    icon: Icon(
                      state.favorites.contains(person.id)
                          ? Icons.favorite
                          : Icons.favorite_border,
                      color: state.favorites.contains(person.id) ? Colors.red : null,
                    ),
                    onPressed: () {
                      // Toggle the favorite status
                      context.read<FamousPersonsCubit>().toggleFavorite(person.id); // Pass the int ID directly
                    },
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BlocProvider(
                          create: (context) => UserInfoCubit(),
                          child: UserInfoScreen(personId: person.id),
                        ),
                      ),
                    );
                  },
                );
              },
            );
          }
          return Center(child: Text('Unexpected state.'));
        },
      ),
    );
  }
}
