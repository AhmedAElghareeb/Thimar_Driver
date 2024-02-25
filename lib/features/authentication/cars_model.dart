class CarsData {
  late final List<CarsModel> data;
  late final String status;
  late final Null message;

  CarsData.fromJson(Map<String, dynamic> json){
    data = List.from(json['data']).map((e)=>CarsModel.fromJson(e)).toList();
    status = json['status'];
    message = null;
  }
}

class CarsModel {
  late final int id;
  late final String name;

  CarsModel.fromJson(Map<String, dynamic> json){
    id = json['id'] ?? 1;
    name = json['name'] ?? "";
  }
}