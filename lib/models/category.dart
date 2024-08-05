class Categoryes {
  /* {
        "id": 8,
        "name": "nuevo nombre jeje",
        "image": "https://placeimg.com/640/480/any",
        "creationAt": "2024-07-17T03:50:39.000Z",
        "updatedAt": "2024-07-17T04:02:39.000Z"
    },*/
  int id;
  String name;
  String image;
  String creationAt;
  String updatedAt;
  Categoryes({
    required this.id,
    required this.name,
    required this.image,
    required this.creationAt,
    required this.updatedAt,
  });
  factory Categoryes.fromJson(Map<String, dynamic> json) {
    return Categoryes(
      id: json['id'],
      name: json['name'],
      image: json['image'],
      creationAt: json['creationAt'],
      updatedAt: json['updatedAt'],
    );
  }
}
