// ignore: file_names
class Artist {
  final String id;
  final String name;
  final String imageUrl;
  final int followers;

  Artist(
      {required this.id,
      required this.name,
      required this.imageUrl,
      required this.followers});

  factory Artist.fromJson(Map<String, dynamic> json) {
    return Artist(
      id: json['id'],
      name: json['name'],
      imageUrl: json['images'].isNotEmpty
          ? json['images'][0]['url']
          : 'https://upload.wikimedia.org/wikipedia/commons/d/d2/Solid_white.png?20060513000852',
      followers: json['followers']['total'],
    );
  }
}
