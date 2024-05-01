import 'package:flutter/material.dart';

class CommonReload extends StatelessWidget {
  const CommonReload({super.key, required this.message, required this.callback});
  final String message;
  final Function() callback;

  @override
  Widget build(BuildContext context) {
    return Center(
        child: InkWell(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: callback,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.refresh),
          Text(
            message.toString(),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    ));
  }
}
