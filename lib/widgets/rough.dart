import 'package:flutter/material.dart';

import '../service/api_adress.dart';

class rough extends StatelessWidget {
  final String image;

  const rough({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 500,width:180,color: Colors.grey,
      child: Column(children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Image.network(
            "$baseUrl:8000$image",
            fit: BoxFit.fill,
          ),
        ),
        Text("dhajdbkbk")
      ],),
    );
  }
}
