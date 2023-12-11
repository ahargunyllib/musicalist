// ignore: file_names
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:musicalist/model/Artist.dart';

// flutter run --dart-define=CLIENT_SECRET=6879f9d57d1f4789b34ada3135a28b9a --dart-define=CLIENT_ID=1d640bc8e1e545bc987275ca91f8bf40
// ignore: constant_identifier_names
const CLIENT_SECRET = String.fromEnvironment('CLIENT_SECRET');
const CLIENT_ID = String.fromEnvironment('CLIENT_ID');

Future<String> getToken(String clientId, String clientSecret) async {
  var url = 'https://accounts.spotify.com/api/token';
  var encoded = base64.encode(
      utf8.encode(CLIENT_ID.toString() + ':' + CLIENT_SECRET.toString()));
  final response = await http.post(
    Uri.parse(url),
    headers: {
      'Content-Type': 'application/x-www-form-urlencoded',
      'Authorization': 'Basic $encoded'
    },
    body: {'grant_type': 'client_credentials'},
  );
  return jsonDecode(response.body)['access_token'];
}

Future<List<Artist>> getArtist(String query) async {
  var url = 'https://api.spotify.com/v1/search?q=${query}&type=artist&limit=10';
  print('get: ' + url);
  var token = await getToken(CLIENT_ID, CLIENT_SECRET);
  final response = await http
      .get(Uri.parse(url), headers: {'Authorization': 'Bearer $token'});
  final List body = jsonDecode(response.body)['artists']['items'];
  print('body');
  print(body.length);
  print(body.map((item) => item['name']));
  // print(body.map((item) => Artist.fromJson(item).name));
  print(body.map((item) => Artist.fromJson(item)).toList().length);
  return body.map((item) => Artist.fromJson(item)).toList();
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late TextEditingController _queryController;
  Future<List<Artist>> artistFuture = getArtist('rea');

  @override
  void initState() {
    super.initState();
    _queryController = TextEditingController();
  }

  @override
  void dispose() {
    _queryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF191414), // Set the background color here
      body: SafeArea(
        child: Center(
            child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Padding(
                padding: const EdgeInsets.only(top: 16, left: 24, right: 24),
                child: Container(
                    constraints: const BoxConstraints.expand(height: 44),
                    // color: Colors.blue,
                    child: const Text(
                      'Musicalist',
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        color: Colors.white,
                        fontSize: 36,
                        fontWeight: FontWeight.w700,
                      ),
                      textAlign: TextAlign.center,
                    ))),
            Padding(
                padding: const EdgeInsets.only(top: 16, left: 24, right: 24),
                child: Container(
                    constraints: const BoxConstraints.expand(height: 50),
                    // color: Colors.red,
                    child: TextField(
                      controller: _queryController,
                      onSubmitted: (String query) async {
                        setState(() {
                          artistFuture = getArtist(query);
                        });
                      },
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          hintText: 'Search your favorite artist',
                          fillColor: Colors.white,
                          contentPadding: const EdgeInsets.only(left: 16),
                          filled: true,
                          hintStyle: const TextStyle(
                              color: Color(0xFFBDBDBD),
                              fontSize: 16,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w500)),
                    ))),
            Padding(
                padding: const EdgeInsets.only(top: 16, left: 24, right: 24),
                child: Container(
                    constraints: const BoxConstraints.expand(height: 24),
                    // color: Colors.blue,
                    child: const Text(
                      'Top Artist',
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ))),
            Padding(
                padding: const EdgeInsets.only(top: 16, left: 24, right: 24),
                child: FutureBuilder<List<Artist>>(
                    future: artistFuture,
                    builder: (context, snapshot) {
                      print('snapshot');
                      print(snapshot.data);
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator();
                      } else if (snapshot.hasData) {
                        final artists = snapshot.data!;
                        return ListView.separated(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: 1,
                          separatorBuilder: (BuildContext context, int index) {
                            return const Divider();
                          },
                          itemBuilder: (BuildContext context, int index) {
                            final artist = artists[index];
                            return InkWell(
                                onTap: () {},
                                child: Container(
                                    child: Row(children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(100.0),
                                    child: Image.network(artist.imageUrl!,
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
                                          artist.name!,
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
                                              '${artist.followers} Followers',
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 12,
                                                fontFamily: 'Inter',
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                            const SizedBox(width: 16),
                                            Text(
                                              artist.genre!,
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 12,
                                                fontFamily: 'Inter',
                                                fontWeight: FontWeight.w400,
                                              ),
                                            )
                                          ],
                                        ),
                                      ])
                                ])));
                          },
                        );
                      } else {
                        return const Text('No data available!');
                      }
                    })),
          ],
        )),
      ),
    );
  }
}
