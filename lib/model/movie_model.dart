class MovieModel {
  final String id;
  final String name;
  final String description;
  final String saleSakht;
  final String price;
  final String image_url;
  final String keshvar;
  final String zaman;

  MovieModel({
    required this.id,
    required this.name,
    required this.description,
    required this.saleSakht,
    required this.price,
    required this.image_url,
    required this.keshvar,
    required this.zaman,
  });
  factory MovieModel.fromJson(Map<String, dynamic> json) {
    return MovieModel(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      saleSakht: json['saleSakht'],
      price: json['price'],
      image_url: json['image_url'],
      keshvar: json['image_url'],
      zaman: json['zaman'],
    );
  }
}
