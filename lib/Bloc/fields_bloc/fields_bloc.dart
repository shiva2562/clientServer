import 'package:bloc/bloc.dart';
import 'package:clientserver/Model/field_model.dart';
import 'package:meta/meta.dart';

import '../../Repository/login_repository.dart';
import '../../Services/exceptions.dart';

part 'fields_event.dart';
part 'fields_state.dart';

class FieldsBloc extends Bloc<FieldsEvent, FieldsState> {
  final LoginRepository _loginRepository = LoginRepository();
  FieldsBloc() : super(FieldsInitial()) {
    on<GetFields>((event, emit) async {
      try {
        emit(FieldsLoading());
        List<Field> fields = await _loginRepository.fetchFields(event.id);
        // List<String> originalDegrees = [];
        // for (int i = 0; i < degrees.length; i++) {
        //   if (!originalDegrees.contains(degrees[i].degree)) {
        //     originalDegrees.add(degrees[i].degree);
        //   }
        // }
        emit(FieldsSuccess(fields, fields.first.type));
      } catch (error) {
        emit(error is AppException
            ? FieldsFailure(error.toString())
            : FieldsFailure('something went wrong'));
      }
    });
  }
}
