class Car {
  String? car_name;
  String? country;
  String? price;
  String? color;
  int? year;
  String? photo;
  List <Model>? model;

  Car.fromJson(Map<String, dynamic> json){
    car_name = json['car_name'];
    country = json['country'];
    price = json['price'];
    color = json['color'];
    year = json['year'];
    photo = json['photo'];

    model = List<Model>.from(json["model"].map((i)=>Model.fromJsonMap(i)));
  }

}
class Model{
  String? model_nomi;
  bool? benzinmi;

  Model.fromJsonMap(Map<String, dynamic>map){
    model_nomi = map["model_nomi"];
    benzinmi = map["benzinmi"];
  }
}