class Track {
  final String id;
  final String name;
  final List<String> artists;
  final int duration;

  Track(
      {required this.id,
      required this.name,
      required this.artists,
      required this.duration});

  factory Track.fromJson(Map<String, dynamic> json) {
    return Track(
      id: json['id'],
      name: json['name'],
      artists: List<String>.from(json['artists'].map((artist) => artist['name'])),
      duration: json['duration_ms'],
    );
  }
}
