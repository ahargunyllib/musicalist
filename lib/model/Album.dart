// ignore: file_names
class Album {
  final String id;
  final String name;
  final String imageUrl;
  final String releaseDate;

  Album(
      {required this.id,
      required this.name,
      required this.imageUrl,
      required this.releaseDate});

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
        id: json['id'],
        name: json['name'],
        imageUrl: json['images'][0]['url'],
        releaseDate: json['release_date']);
  }
}
