part of 'fields_bloc.dart';

@immutable
abstract class FieldsEvent {}

class GetFields extends FieldsEvent {
  int id;
  GetFields(this.id);
}
