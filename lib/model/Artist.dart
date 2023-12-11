// ignore: file_names
class Artist {
  final String id;
  final String name;
  final String imageUrl;
  final int followers;
  final String href;

  Artist(
      {required this.id,
      required this.name,
      required this.imageUrl,
      required this.followers,
      required this.href});

  factory Artist.fromJson(Map<String, dynamic> json) {
    return Artist(
      id: json['id'],
      name: json['name'],
      imageUrl: json['images'][0]['url'],
      followers: json['followers']['total'],
      href: json['href']
    );
  }
}
