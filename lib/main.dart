import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_api/screens/add_favorite_screen.dart';
import 'cubit/famous_persons_cubit.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => FamousPersonsCubit()..fetchFamousPersons()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomeScreen(),
        routes: {
          '/favorites': (context) => FavoritePersonsScreen(),
        },
      ),
    );
  }
}
