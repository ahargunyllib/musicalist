import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:musicalist/model/Artist.dart';
import 'package:musicalist/model/Album.dart';
import 'package:musicalist/pages/AlbumPage.dart';
import 'package:musicalist/components/HeaderText.dart';
import 'package:musicalist/components/BackButton.dart';
import 'package:musicalist/components/CustomCard.dart';

Future<List<Album>> getAlbum(String query, token) async {
  var url =
      'https://api.spotify.com/v1/artists/$query/albums?include_groups=album';
  final response = await http
      .get(Uri.parse(url), headers: {'Authorization': 'Bearer $token'});
  if (response.statusCode == 200) {
    List body = json.decode(response.body)['items'];
    return body.map((item) => Album.fromJson(item)).toList();
  } else {
    throw Exception('Unexpected error occured!');
  }
}

Future<List<Album>> getSingle(String query, token) async {
  var url =
      'https://api.spotify.com/v1/artists/$query/albums?include_groups=single';
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
  late Future<List<Album>> singleFuture;

  @override
  void initState() {
    super.initState();
    albumFuture = getAlbum(widget.artist.id, widget.token);
    singleFuture = getSingle(widget.artist.id, widget.token);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFF191414),
        resizeToAvoidBottomInset: false,
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
            child: SingleChildScrollView(
            child: Center(
                child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 16, left: 24, right: 24),
                  child: Expanded(
                    child: Row(
                      children: [
                        const CostumBackButton(),
                        const SizedBox(width: 16),
                        Flexible(
                          flex: 1,
                          child: HeaderText(text: widget.artist.name),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                    padding:
                        const EdgeInsets.only(top: 16, left: 24, right: 24),
                    child: Container(
                        constraints: const BoxConstraints.expand(height: 24),
                        child: const Header2Text(text: 'Albums'))),
                Padding(
                    padding:
                        const EdgeInsets.only(top: 16, left: 24, right: 24),
                    child: FutureBuilder<List<Album>>(
                      future: albumFuture,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          final albums = snapshot.data!;
                          return ListView.separated(
                            itemCount: snapshot.data!.length < 3
                                ? snapshot.data!.length
                                : 3,
                            separatorBuilder:
                                (BuildContext context, int index) {
                              return const Divider();
                            },
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              final album = albums[index];
                              return InkWell(
                                  onTap: () {
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (context) {
                                      return AlbumPage(
                                          album: album, token: widget.token);
                                    }));
                                  },
                                  child: CustomCardAlbum(album: album,));
                            },
                          );
                        } else if (snapshot.hasError) {
                          return Text('${snapshot.error}');
                        }
                        return const CircularProgressIndicator();
                      },
                    )),
                const SizedBox(height: 16),
                Padding(
                    padding:
                        const EdgeInsets.only(top: 16, left: 24, right: 24),
                    child: Container(
                        constraints: const BoxConstraints.expand(height: 24),
                        child: const Header2Text(text: 'Singles'))),
                Padding(
                    padding:
                        const EdgeInsets.only(top: 16, left: 24, right: 24),
                    child: FutureBuilder<List<Album>>(
                      future: singleFuture,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          final singles = snapshot.data!;
                          return ListView.separated(
                            itemCount: snapshot.data!.length < 3
                                ? snapshot.data!.length
                                : 3,
                            separatorBuilder:
                                (BuildContext context, int index) {
                              return const Divider();
                            },
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              final single = singles[index];
                              return CustomCardAlbum(album: single);
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
          ))
        ]));
  }
}
