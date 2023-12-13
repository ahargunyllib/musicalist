import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:musicalist/model/Album.dart';
import 'package:musicalist/model/Track.dart';
import 'package:musicalist/components/HeaderText.dart';
import 'package:musicalist/components/BackButton.dart';
import 'package:musicalist/components/CustomCard.dart';

Future<List<Track>> getTrack(String query, token) async {
  var url = 'https://api.spotify.com/v1/albums/$query/tracks';
  final response = await http
      .get(Uri.parse(url), headers: {'Authorization': 'Bearer $token'});
  if (response.statusCode == 200) {
    List body = json.decode(response.body)['items'];
    return body.map((item) => Track.fromJson(item)).toList();
  } else {
    throw Exception('Unexpected error occured!');
  }
}

class AlbumPage extends StatefulWidget {
  final Album album;
  final String token;

  const AlbumPage({Key? key, required this.album, required this.token})
      : super(key: key);

  @override
  State<AlbumPage> createState() => _AlbumPageState();
}

class _AlbumPageState extends State<AlbumPage> {
  late Future<List<Track>> trackFuture;

  @override
  void initState() {
    super.initState();
    trackFuture = getTrack(widget.album.id, widget.token);
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
              widget.album.imageUrl,
            ),
          ),
          SafeArea(
            child: Center(
                child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 16, left: 24, right: 24, bottom: 16),
                  child: Expanded(
                    child: Row(
                      children: [
                        const CostumBackButton(),
                        const SizedBox(width: 16),
                        Flexible(
                          flex: 1,
                          child: HeaderText(text: widget.album.name),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                FutureBuilder<List<Track>>(
                  future: trackFuture,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      final tracks = snapshot.data!;
                      return Expanded(
                          child: ListView.separated(
                        itemCount: snapshot.data!.length,
                        separatorBuilder: (BuildContext context, int index) {
                          return const Divider();
                        },
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          final track = tracks[index];
                          return CustomCardTrack(track: track);
                        },
                      ));
                    } else if (snapshot.hasError) {
                      return Text('${snapshot.error}',
                          style: const TextStyle(color: Colors.white));
                    }
                    return const CircularProgressIndicator();
                  },
                ),
              ],
            )),
          )
        ]));
  }
}
