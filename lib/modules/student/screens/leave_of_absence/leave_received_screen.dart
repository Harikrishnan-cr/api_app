import 'package:flutter/material.dart';
import 'package:samastha/theme/t_style.dart';
import 'package:samastha/widgets/custom_form_elements.dart';

class LeaveReceivedScreen extends StatelessWidget {
  const LeaveReceivedScreen({super.key});
  static const String path = '/leave-received';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: pagePadding.copyWith(bottom: 30),
        child: Column(
          children: [
            const Spacer(),
            Text(
              'Your Leave Application\nHas Been Received',
              style: titleLarge.primary,
              textAlign: TextAlign.center,
            ),
            Text(
              'Please check for the leave confirmation',
              style: labelMedium.darkBG,
            ),
            const Spacer(),
            SubmitButton(
              'Go Back',
              onTap: (value) {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
