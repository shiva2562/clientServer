class Field {
  String type;
  Field.fromJson(Map<String, dynamic> json) : type = json["educationTypeName"];
}
