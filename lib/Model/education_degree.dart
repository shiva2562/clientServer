class EducationModel {
  final String degree;
  final int id;
  EducationModel.fromJson(Map<String, dynamic> json)
      : degree = json["degree"],
        id = json["educationId"];
}
