part of 'fields_bloc.dart';

@immutable
abstract class FieldsState {}

class FieldsInitial extends FieldsState {}

class FieldsLoading extends FieldsState {}

class FieldsSuccess extends FieldsState {
  final List<Field> fields;
  String currentValue;

  FieldsSuccess(this.fields, this.currentValue);
  set setCurrentValue(String val) {
    currentValue = val;
  }
}

class FieldsFailure extends FieldsState {
  final String error;
  FieldsFailure(this.error);
}
