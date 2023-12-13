import 'package:flutter/material.dart';

class CostumBackButton extends StatelessWidget {
  const CostumBackButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
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
        ));
  }
}
