class StarModel {
  final String id;
  final String name;
  final String pic;

  StarModel({required this.id, required this.name, required this.pic});

  factory StarModel.fromJson(Map<String, dynamic> json) {
    return StarModel(id: json['id'], name: json['name'], pic: json['pic']);
  }
}
