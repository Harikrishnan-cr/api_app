import 'package:flutter/material.dart';
import 'package:samastha/theme/color_resources.dart';
import 'package:samastha/theme/t_style.dart';

Column errorReload(String message, {Function? onTap}) {
  return Column(
    mainAxisSize: MainAxisSize.max,
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      Text(
        message,
        textAlign: TextAlign.center,
        overflow: TextOverflow.ellipsis,
        maxLines: 4,
        style: bodyMedium.primary,
      ),
      IconButton(
          onPressed: () {
            if (onTap != null) {
              onTap();
            }
          },
          icon: const Icon(
            Icons.refresh_outlined,
            color: ColorResources.primary,
          ))
    ],
  );
}
