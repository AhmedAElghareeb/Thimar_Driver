class CityModel {
  late final int id;
  late final String name;

  CityModel.fromJson(Map<String, dynamic> json){
    id = int.parse(json['id'] ?? "0");
    name = json['name'] ?? "";
  }
}