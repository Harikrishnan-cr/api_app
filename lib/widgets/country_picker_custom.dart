import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:samastha/gen/assets.gen.dart';
import 'package:samastha/theme/t_style.dart';

typedef NewCountryTap = Function(String? dialCode);

class CountryCodePickerView extends StatelessWidget {
  const CountryCodePickerView(
      {super.key,
      this.countryId,
      this.initialDialCode,
      required this.onNewCountryTap});
  final int? countryId;
  final String? initialDialCode;
  final NewCountryTap onNewCountryTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        showCountryPicker(
            context: context,
            favorite: ['IN', 'AE'],
            onSelect: (Country newCountry) {
              onNewCountryTap(newCountry.phoneCode);
            });
      },
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            initialDialCode ?? '',
            style: bodyMedium.text1,
          ),
          const Gap(4),
          RotatedBox(
              quarterTurns: 3, child: Assets.svgs.arrrowBack.svg(height: 12))
        ],
      ),
    );
  }
}
