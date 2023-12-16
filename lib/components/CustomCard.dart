import 'package:flutter/material.dart';
import 'package:musicalist/model/Track.dart';
import 'package:musicalist/model/Artist.dart';
import 'package:musicalist/model/Album.dart';
import 'package:musicalist/components/HeaderText.dart';

class CustomCardArtist extends StatelessWidget {
  final Artist artist;
  const CustomCardArtist({Key? key, required this.artist}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(left: 24, right: 24),
        child: Flexible(child: Container(
            decoration: const BoxDecoration(
              color: Color.fromARGB(100, 0, 0, 0),
              backgroundBlendMode: BlendMode.overlay,
              borderRadius: BorderRadius.all(Radius.circular(50)),
            ),
            child: Padding(
                padding: const EdgeInsets.only(
                    top: 8, left: 24, right: 24, bottom: 8),
                child: Row(children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(100.0),
                    child: Image.network(artist.imageUrl,
                        width: 50, height: 50, fit: BoxFit.cover),
                  ),
                  const SizedBox(width: 16),
                  Expanded(child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Header3Text(text: artist.name),
                        const SizedBox(height: 8),
                        Header4Text(text: '${artist.followers} Followers')
                      ]))
                ])))));
  }
}

class CustomCardAlbum extends StatelessWidget {
  final Album album;
  const CustomCardAlbum({Key? key, required this.album}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
            decoration: const BoxDecoration(
              color: Color.fromARGB(100, 0, 0, 0),
              backgroundBlendMode: BlendMode.overlay,
              borderRadius: BorderRadius.all(Radius.circular(50)),
            ),
            child: Padding(
                padding: const EdgeInsets.only(
                    top: 8, left: 24, right: 24, bottom: 8),
                child: Row(children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(100.0),
                    child: Image.network(album.imageUrl,
                        width: 50, height: 50, fit: BoxFit.cover),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                        Header3Text(text: album.name),
                        const SizedBox(height: 8),
                        Header4Text(text: album.releaseDate)
                      ]))
                ])));
  }
}

class CustomCardTrack extends StatelessWidget {
  final Track track;
  const CustomCardTrack({Key? key, required this.track}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(left: 24, right: 24),
        child: Container(
            decoration: const BoxDecoration(
              color: Color.fromARGB(100, 0, 0, 0),
              backgroundBlendMode: BlendMode.overlay,
              borderRadius: BorderRadius.all(Radius.circular(50)),
            ),
            child: Padding(
                padding: const EdgeInsets.only(
                    top: 8, left: 24, right: 24, bottom: 8),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Header3Text(text: track.name),
                      const SizedBox(height: 8),
                      Header4Text(text: track.artists.join(', '))
                    ]))));
  }
}
