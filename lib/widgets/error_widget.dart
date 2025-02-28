import 'package:flutter/material.dart';

import '../theme/colors.dart';
import '../theme/icons.dart';

class MyErrorWidget extends StatelessWidget {
  const MyErrorWidget(
      {super.key, required this.errorText, required this.retryFunction});

  final String errorText;
  final Function retryFunction;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            MyAppIcons.error,
            size: 60,
            color: MyColors.redColor,
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            errorText,
            style: TextStyle(
              color: MyColors.redColor,
              fontSize: 16,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          ElevatedButton(
            style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all<Color>(
                    Theme.of(context).colorScheme.surface)),
            onPressed: () {
              retryFunction();
            },
            child: Text(
              "Retry",
              style: TextStyle(color: MyColors.textBlackColor),
            ),
          )
        ],
      ),
    );
  }
}
