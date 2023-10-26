import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    required this.onPress,
    required this.text,
    this.backColor,
    this.textColor,
    this.isLoading = false,
  });

  final VoidCallback onPress;
  final String text;
  final Color? backColor;
  final Color? textColor;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const FittedBox(
            fit: BoxFit.scaleDown,
            child: CircularProgressIndicator(),
          )
        : FilledButton(
            onPressed: onPress,
            child: Text(
              text,
            ),
          );
  }
}