import 'package:flutter/material.dart';

class HeaderText extends StatelessWidget {
  final String text;
  const HeaderText({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 36,
        fontFamily: 'Montserrat',
        fontWeight: FontWeight.w700,
        color: Colors.white,
      ),
      softWrap: true,
    );
  }
}

class Header2Text extends StatelessWidget {
  final String text;
  const Header2Text({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 20,
        fontFamily: 'Montserrat',
        fontWeight: FontWeight.w600,
        color: Colors.white,
      ),
      softWrap: true,
    );
  }
}

class Header3Text extends StatelessWidget {
  final String text;
  const Header3Text({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 16,
        fontFamily: 'Montserrat',
        fontWeight: FontWeight.w600,
        color: Colors.white,
      ),
      softWrap: true,
    );
  }
}

class Header4Text extends StatelessWidget {
  final String text;
  const Header4Text({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 12,
        fontFamily: 'Montserrat',
        fontWeight: FontWeight.w400,
        color: Colors.white,
      ),
      softWrap: true,
    );
  }
}
