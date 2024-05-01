import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:samastha/core/app_constants.dart';
import 'package:samastha/gen/assets.gen.dart';
import 'package:samastha/modules/student/bloc/admission_bloc.dart';
import 'package:samastha/modules/student/models/fee_payment_model.dart';
import 'package:samastha/theme/dimensions.dart';
import 'package:samastha/theme/t_style.dart';
import 'package:samastha/widgets/app_bars_custom.dart';
import 'package:samastha/widgets/custom_form_elements.dart';

class FeePaymentSummary extends StatelessWidget {
  const FeePaymentSummary({super.key, required this.title});
  static const String path = '/fee-payment-summary';
  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SimpleAppBar(
        title: title,
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            margin: const EdgeInsets.all(16),
            decoration: defaultDecoration,
            child: FutureBuilder(
                future: AdmissionBloc().feePayment(),
                builder: (context, snapshot) {
                  FeePaymentModel? model =
                      snapshot.hasData ? snapshot.data : null;
                      debugPrint('fee payment ${model?.coursePayments?.length}');
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Fee payment summary',
                        style: titleSmall.darkBG,
                      ),
                      const Gap(12),
                      Text(
                        AppConstants.lorem,
                        style: bodyMedium.darkBG,
                      ),
                      const Gap(22),
                      Text(
                        'Total Fee for the year',
                        style: titleSmall.darkBG,
                      ),
                      const Gap(16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Total Fee for the year',
                            style: bodyMedium.darkBG,
                          ),
                          Text(
                            '${AppConstants.rupeeSign}10,000',
                            style: titleSmall.darkBG,
                          )
                        ],
                      ),
                      const Gap(12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Admission fee',
                            style: bodyMedium.darkBG,
                          ),
                          Text(
                            '${AppConstants.rupeeSign}10,000',
                            style: titleSmall.darkBG,
                          )
                        ],
                      ),
                      const Gap(12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Tuition Fee Term1',
                                style: bodyMedium.darkBG,
                              ),
                              const Gap(4),
                              Row(
                                children: [
                                  Assets.image.blueCircleTick.image(height: 12),
                                  const Gap(5),
                                  Text(
                                    'Paid',
                                    style: labelSmall.secondary,
                                  )
                                ],
                              )
                            ],
                          ),
                          Text(
                            '${AppConstants.rupeeSign}3,000',
                            style: titleSmall.darkBG,
                          )
                        ],
                      ),
                      const Gap(12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Tuition Fee Term2',
                                style: bodyMedium.darkBG,
                              ),
                              const Gap(4),
                              Row(
                                children: [
                                  Assets.image.blueCircleTick.image(height: 12),
                                  const Gap(5),
                                  Text(
                                    'Paid',
                                    style: labelSmall.secondary,
                                  )
                                ],
                              )
                            ],
                          ),
                          Text(
                            '${AppConstants.rupeeSign}3,000',
                            style: titleSmall.darkBG,
                          )
                        ],
                      ),
                      const Gap(12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Exam Fee',
                                style: bodyMedium.darkBG,
                              ),
                              const Gap(4),
                              Row(
                                children: [
                                  // Assets.image.blueCircleTick.image(height: 12),
                                  // const Gap(5),
                                  Text(
                                    'Pay by 15th March 2023',
                                    style: labelSmall.secondary,
                                  )
                                ],
                              )
                            ],
                          ),
                          Text(
                            '${AppConstants.rupeeSign}4,000',
                            style: titleSmall.darkBG,
                          )
                        ],
                      ),
                      const Gap(29),
                      const SubmitButton('Pay Now')
                    ],
                  );
                }),
          ),
        ],
      ),
    );
  }
}
