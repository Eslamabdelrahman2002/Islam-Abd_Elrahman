import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_api/screens/user_info_screen.dart';
import '../cubit/famous_persons_cubit.dart';

import '../cubit/famous_persons_state.dart';
import '../model/person_model.dart';

class FavoritePersonsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favorite Persons'),
      ),
      body: BlocBuilder<FamousPersonsCubit, FamousPersonsState>(
        builder: (context, state) {
          if (state is FamousPersonsLoaded) {
            List<Person> favoritePersons = state.persons
                .where((person) => state.favorites.contains(person.id.toString())).cast<Person>()
                .toList();

            if (favoritePersons.isEmpty) {
              return Center(child: Text('No favorites added.'));
            }

            return ListView.builder(
              itemCount: favoritePersons.length,
              itemBuilder: (context, index) {
                Person person = favoritePersons[index];

                return ListTile(
                  leading: person.profilePath!.isNotEmpty
                      ? Image.network('https://image.tmdb.org/t/p/w500${person.profilePath}')
                      : Container(width: 50, height: 50, color: Colors.grey),
                  title: Text(person.name),

                );
              },
            );
          }  else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}

