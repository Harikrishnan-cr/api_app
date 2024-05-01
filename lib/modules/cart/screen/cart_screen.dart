import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:samastha/core/app_constants.dart';
import 'package:samastha/gen/assets.gen.dart';
import 'package:samastha/theme/dimensions.dart';
import 'package:samastha/theme/t_style.dart';
import 'package:samastha/widgets/app_bars_custom.dart';
import 'package:samastha/widgets/custom_form_elements.dart';
import 'package:samastha/widgets/dashed_lines.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});
  static const String path = '/cart-screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SimpleAppBar(title: 'Cart Page'),
      body: SafeArea(
          child: SingleChildScrollView(
        padding: pagePadding,
        child: Column(
          children: [
            Container(
              decoration: defaultDecoration,
              padding: const EdgeInsets.all(8),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(9),
                    child: Assets.image.makka
                        .image(height: 96, width: 128, fit: BoxFit.cover),
                    // child: Container(
                    //   height: 96,
                    //   width: 128,
                    //   color: ColorResources.PLACEHOLDER,
                    // ),
                  ),
                  const Gap(12),
                  Expanded(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Quraan',
                        style: titleMedium.secondary,
                      ),
                      const Gap(2),
                      Text(
                        AppConstants.lorem,
                        style: bodyMedium.darkBG,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      )
                    ],
                  ))
                ],
              ),
            ),
            const Gap(6),
            CupertinoButton(
                padding: EdgeInsets.zero,
                child: Text(
                  '+ Add Item',
                  style: titleMedium.primary,
                ),
                onPressed: () {}),
            const Gap(6),
            GestureDetector(
              onTap: () {},
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: defaultDecoration,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Apply Coupon',
                      style: titleMedium.copyWith(
                        color: const Color(0xff1B3D66),
                      ),
                    ),
                    Assets.image.coupon.image(height: 20)
                  ],
                ),
              ),
            ),
            const Gap(16),
            GestureDetector(
              onTap: () {},
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: defaultDecoration,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Assets.svgs.boxChecked.svg(),
                    const Gap(16),
                    Expanded(
                      child: Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                                text: 'Use ',
                                style:
                                    titleMedium.copyWith(fontSize: 14,color: const Color(0xff1B3D66))),
                            TextSpan(
                              text: '20',
                              style: titleLarge.secondary,
                            ),
                            TextSpan(
                              text:
                                  ' Reward Points to complete this transaction',
                              style: titleMedium.darkBG.copyWith(fontSize: 14),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const Gap(16),
            Container(
              width: double.infinity,
              decoration: defaultDecoration,
              // padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Bill Details',
                          style: titleSmall.copyWith(
                              color: const Color(0xff1B3D66)),
                        ),
                        const MainItem(
                          amount: '${AppConstants.rupeeSign}19',
                          title: 'Quraan Learning',
                        ),
                        const MainItem(
                          amount: '${AppConstants.rupeeSign}19',
                          title: 'Fiqh Learning',
                        ),
                        const MainItem(
                          amount: '${AppConstants.rupeeSign}19',
                          title: 'Salah Learning',
                        ),
                      ],
                    ),
                  ),
                  const DashedLine(
                    color: Color(0xffE0E1E2),
                    height: 0.4,
                    heightContainer: 10,
                  ),
                  // Gap(16),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        MainItem(
                            title: 'Total',
                            amount: '${AppConstants.rupeeSign}34',
                            titleStyle: titleMedium.darkBG,
                            amountStyle: titleMedium.darkBG),
                        const MainItem(
                          title: '+ Applicable Tax',
                          amount: '${AppConstants.rupeeSign}1',
                        ),
                        MainItem(
                          title: '- Coupon Applied',
                          amount: '${AppConstants.rupeeSign}1',
                          titleStyle: bodyMedium.red,
                          amountStyle: bodyMedium.red,
                        ),
                      ],
                    ),
                  ),
                  const DashedLine(
                    color: Color(0xffE0E1E2),
                    height: 0.4,
                    heightContainer: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: MainItem(
                        title: 'Amount To Pay',
                        amount: '${AppConstants.rupeeSign}26',
                        titleStyle: titleMedium.darkBG,
                        amountStyle: titleMedium.darkBG),
                  ),
                ],
              ),
            ),
            const Gap(16),
            const SubmitButton('Pay Now')
          ],
        ),
      )),
    );
  }
}

class MainItem extends StatelessWidget {
  const MainItem({
    super.key,
    required this.title,
    required this.amount,
    this.titleStyle,
    this.amountStyle,
  });
  final String title;
  final String amount;
  final TextStyle? titleStyle;
  final TextStyle? amountStyle;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 8),
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: titleStyle ?? bodyMedium.darkBG,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Text(
            amount.toString(),
            style: amountStyle ?? titleSmall.darkBG,
          )
        ],
      ),
    );
  }
}
