part of 'degrees_bloc.dart';

@immutable
abstract class DegreesState {}

class DegreesInitial extends DegreesState {}

class DegreesLoading extends DegreesState {}

class DegreesSuccess extends DegreesState {
  final List<EducationModel> degrees;
  int currentValue;
  DegreesSuccess(this.degrees, this.currentValue);
  set setCurrentValue(int val) {
    currentValue = val;
  }
}

class DegreesFailure extends DegreesState {
  final String error;
  DegreesFailure(this.error);
}
