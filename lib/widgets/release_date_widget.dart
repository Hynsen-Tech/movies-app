import 'package:flutter/material.dart';

import '../theme/icons.dart';
import 'movies/favorite_btn_widget.dart';

class ReleaseDateWidget extends StatelessWidget {
  const ReleaseDateWidget({super.key, required this.releaseDate});

  final String releaseDate;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          MyAppIcons.watchLaterOutlined,
          size: 20,
          color: Theme.of(context).colorScheme.secondary,
        ),
        const SizedBox(width: 5),
        Text(
          releaseDate,
          style: const TextStyle(color: Colors.grey),
        ),
      ],
    );
  }
}
