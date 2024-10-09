import '../model/person_model.dart';

abstract class FamousPersonsState {}

class FamousPersonsInitial extends FamousPersonsState {}

class FamousPersonsLoading extends FamousPersonsState {}

class FamousPersonsLoaded extends FamousPersonsState {
  final List<Person> persons;
  final List<String> favorites;

  FamousPersonsLoaded(this.persons, this.favorites);
}

class FamousPersonsError extends FamousPersonsState {
  final String message;

  FamousPersonsError(this.message);
}
