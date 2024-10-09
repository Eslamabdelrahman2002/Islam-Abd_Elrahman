import 'package:bloc/bloc.dart';
import '../model/person_model.dart';
import '../api_service/api_service.dart';
import 'famous_persons_state.dart';

class FamousPersonsCubit extends Cubit<FamousPersonsState> {
  List<Person> persons = [];
  List<int> favorites = [];

  FamousPersonsCubit() : super(FamousPersonsInitial());

  Future<void> fetchFamousPersons() async {
    emit(FamousPersonsLoading());
    try {
      persons = await ApiService.fetchFamousPersons();
      emit(FamousPersonsLoaded(persons, favorites.map((id) => id.toString()).toList()));
    } catch (e) {
      emit(FamousPersonsError('Failed to load famous persons: ${e.toString()}'));
    }
  }

  void toggleFavorite(int personId) { // Change parameter type to int
    if (favorites.contains(personId)) {
      favorites.remove(personId);
    } else {
      favorites.add(personId);
    }
    emit(FamousPersonsLoaded(persons, favorites.map((id) => id.toString()).toList()));
  }
}
