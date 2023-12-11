// ignore: file_names
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key : key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF191414), // Set the background color here
      body: SafeArea(
        child: Center(
          child: Column (
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
                  )
                )
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16, left: 24, right: 24),
                child: Container(
                  constraints: const BoxConstraints.expand(height: 50),
                  // color: Colors.red,
                  child: TextField(
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
                        fontWeight: FontWeight.w500
                      )
                    ),
                  )
                )
              ),
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
                  )
                )
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16, left: 24, right: 24),
                child: InkWell(
                  onTap: () {},
                  child: Container(
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(100.0),
                          child: Image.network(
                            'https://i.scdn.co/image/ab6761610000e5ebcb925d1cd51e4604cc97304d',
                            width: 50,
                            height: 50,
                            fit: BoxFit.cover
                          ),
                        ),
                        const SizedBox(width: 16),
                        const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Reality Club',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w600,
                              ),
                              textAlign: TextAlign.start,
                            ),
                            SizedBox(height: 8),
                            Row(
                              children: [
                                Text(
                                  '1000 Followers',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                SizedBox(width: 16),
                                Text(
                                  'Indonesian Indie',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w400,
                                  ),
                                )
                              ],
                            ),
                          ]
                        )
                      ]
                    )
                  )
                ) 
              )
            ],
          )
        ),
      ),
    );
  }
}
