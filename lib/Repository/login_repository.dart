import 'package:clientserver/Model/education_degree.dart';
import 'package:clientserver/Model/field_model.dart';
import 'package:clientserver/Model/login_model.dart';

import '../Services/api_helper.dart';

class LoginRepository {
  ApiHandler _helper = ApiHandler();

  Future<LoginModel> login(String username, String password) async {
    final response = await _helper.get("Jobseeker/Login/$username/$password");
    print(response);
    var loginModel = LoginModel.fromJson(response);
    return loginModel;
  }

  Future<List<EducationModel>> fetchDegrees() async {
    final response = await _helper.get("Jobseeker/getEducation");
    var items = response["model"] as List;
    List<EducationModel> degrees = [];
    for (var element in items) {
      degrees.add(EducationModel.fromJson(element));
    }
    return degrees;
  }

  Future<List<Field>> fetchFields(int id) async {
    final response = await _helper.get("Jobseeker/getSpecialization/$id");
    var items = response["model"] as List;
    List<Field> fields = [];
    for (var element in items) {
      fields.add(Field.fromJson(element));
    }
    return fields;
  }
}
