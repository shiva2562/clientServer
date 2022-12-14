import 'package:bloc/bloc.dart';
import 'package:clientserver/Model/education_degree.dart';
import 'package:meta/meta.dart';

import '../../Repository/login_repository.dart';
import '../../Services/exceptions.dart';

part 'degrees_event.dart';
part 'degrees_state.dart';

class DegreesBloc extends Bloc<DegreesEvent, DegreesState> {
  final LoginRepository _loginRepository = LoginRepository();
  DegreesBloc() : super(DegreesInitial()) {
    on<GetDegrees>((event, emit) async {
      try {
        emit(DegreesLoading());
        List<EducationModel> degrees = await _loginRepository.fetchDegrees();
        // List<String> originalDegrees = [];
        // for (int i = 0; i < degrees.length; i++) {
        //   if (!originalDegrees.contains(degrees[i].degree)) {
        //     originalDegrees.add(degrees[i].degree);
        //   }
        // }
        emit(DegreesSuccess(degrees, degrees.first.id));
      } catch (error) {
        emit(error is AppException
            ? DegreesFailure(error.toString())
            : DegreesFailure('something went wrong'));
      }
    });
  }
}
