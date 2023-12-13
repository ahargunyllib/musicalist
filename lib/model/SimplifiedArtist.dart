// ignore: file_names
class SimplifiedArtist {
  final String id;
  final String name;

  SimplifiedArtist(
      {required this.id, required this.name});

  factory SimplifiedArtist.fromJson(Map<String, dynamic> json) {
    return SimplifiedArtist(
      id: json['id'],
      name: json['name'],
    );
  }
}
