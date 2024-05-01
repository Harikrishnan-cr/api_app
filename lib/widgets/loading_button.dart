import 'package:flutter/material.dart';

class LoadingButton extends StatelessWidget {
  const LoadingButton({
    super.key,
    required this.isLoading,
    required this.text,
    required this.onPressed,
  });

  final bool isLoading;
  final String text;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
              onPressed: isLoading ? null : onPressed,
              child:
                  isLoading ? const CircularProgressIndicator() : Text(text)),
        ),
      ],
    );
  }
}
