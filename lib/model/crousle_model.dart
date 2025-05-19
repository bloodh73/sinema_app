class CrousleModel {
  final String id;
  final String img_slide;
  final String name;

  CrousleModel({required this.id, required this.img_slide, required this.name});
  factory CrousleModel.fromJson(Map<String, dynamic> json) {
    return CrousleModel(
      id: json['id'],
      img_slide: json['img_slide'],
      name: json['name'],
    );
  }
}
