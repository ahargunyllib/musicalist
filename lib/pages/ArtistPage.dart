import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:musicalist/model/Artist.dart';
import 'package:musicalist/model/Album.dart';

Future<List<Album>> getAlbum(String query, token) async {
  var url =
      'https://api.spotify.com/v1/artists/$query/albums?include_groups=album&limit=3';
  print(url);
  final response = await http
      .get(Uri.parse(url), headers: {'Authorization': 'Bearer $token'});
  if (response.statusCode == 200) {
    List body = json.decode(response.body)['items'];
    return body.map((item) => Album.fromJson(item)).toList();
  } else {
    throw Exception('Unexpected error occured!');
  }
}

class ArtistPage extends StatefulWidget {
  final Artist artist;
  final String token;

  const ArtistPage({Key? key, required this.artist, required this.token})
      : super(key: key);

  @override
  State<ArtistPage> createState() => _ArtistPageState();
}

class _ArtistPageState extends State<ArtistPage> {
  late Future<List<Album>> albumFuture;

  @override
  void initState() {
    super.initState();
    albumFuture = getAlbum(widget.artist.id, widget.token);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFF191414),
        body: Stack(children: [
          ShaderMask(
            shaderCallback: (rect) {
              return const LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.black, Colors.transparent],
              ).createShader(Rect.fromLTRB(0, 0, rect.width, rect.height));
            },
            blendMode: BlendMode.dstIn,
            child: Image.network(
              widget.artist.imageUrl,
            ),
          ),
          SafeArea(
            child: Center(
                child: Column(
              children: [
                Padding(
                    padding:
                        const EdgeInsets.only(top: 16, left: 24, right: 24),
                    child: Container(
                        constraints: const BoxConstraints.expand(height: 44),
                        // color: Colors.blue,
                        child: Row(
                          children: [
                            CircleAvatar(
                                backgroundColor: Colors.transparent,
                                child: IconButton(
                                  icon: const Icon(
                                    Icons.arrow_back,
                                    color: Colors.white,
                                    opticalSize: 25,
                                  ),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                )),
                            const SizedBox(width: 16),
                            Text(
                              widget.artist.name,
                              style: const TextStyle(
                                fontFamily: 'Montserrat',
                                color: Colors.white,
                                fontSize: 36,
                                fontWeight: FontWeight.w700,
                              ),
                              textAlign: TextAlign.center,
                            )
                          ],
                        ))),
                SizedBox(height: 64),
                Padding(
                    padding:
                        const EdgeInsets.only(top: 16, left: 24, right: 24),
                    child: Container(
                        constraints: const BoxConstraints.expand(height: 24),
                        child: const Text(
                          'Albums',
                          style: TextStyle(
                            fontFamily: 'Montserrat',
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ))),
                Padding(
                    padding:
                        const EdgeInsets.only(top: 16, left: 24, right: 24),
                    child: FutureBuilder<List<Album>>(
                      future: albumFuture,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          final albums = snapshot.data!;
                          return ListView.separated(
                            scrollDirection: Axis.horizontal,
                            itemCount: snapshot.data!.length < 3
                                ? snapshot.data!.length
                                : 3,
                            separatorBuilder:
                                (BuildContext context, int index) {
                              return const Divider();
                            },
                            itemBuilder: (context, index) {
                              final album = albums[index];
                              return InkWell(
                                  onTap: () {},
                                  child: Container(
                                      child: Row(children: [
                                    ClipRRect(
                                      borderRadius:
                                          BorderRadius.circular(100.0),
                                      child: Image.network(album.imageUrl,
                                          width: 50,
                                          height: 50,
                                          fit: BoxFit.cover),
                                    ),
                                    const SizedBox(width: 16),
                                    Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            album.name,
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 16,
                                              fontFamily: 'Inter',
                                              fontWeight: FontWeight.w600,
                                            ),
                                            textAlign: TextAlign.start,
                                          ),
                                          const SizedBox(height: 8),
                                          Row(
                                            children: [
                                              Text(
                                                album.releaseDate,
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 12,
                                                  fontFamily: 'Inter',
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ])
                                  ])));
                            },
                          );
                        } else if (snapshot.hasError) {
                          return Text('${snapshot.error}');
                        }
                        return const CircularProgressIndicator();
                      },
                    ))
              ],
            )),
          )
        ]));
  }
}
