import 'package:flutter/material.dart';

import '../../theme/icons.dart';

class FavoriteBtnWidget extends StatefulWidget {
  const FavoriteBtnWidget({super.key, this.iconSize = 20});

  final double iconSize;

  @override
  State<FavoriteBtnWidget> createState() => _FavoriteBtnWidgetState();
}

class _FavoriteBtnWidgetState extends State<FavoriteBtnWidget> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {},
      icon: const Icon(MyAppIcons.favoriteRoundedOutline),
      //color: Colors.red,
      iconSize: widget.iconSize,
    );
  }
}
