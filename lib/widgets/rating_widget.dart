import 'package:flutter/material.dart';

class RatingWidget extends StatelessWidget {
  const RatingWidget({super.key, required this.voteAverage});

  final int voteAverage;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(
          Icons.star,
          size: 20,
          color: Colors.amber,
        ),
        const SizedBox(width: 5),
        Text("$voteAverage/10")
      ],
    );
  }
}
