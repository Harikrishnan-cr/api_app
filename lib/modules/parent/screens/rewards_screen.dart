import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:samastha/gen/assets.gen.dart';
import 'package:samastha/modules/cart/screen/cart_screen.dart';
import 'package:samastha/modules/parent/bloc/rewards_provider.dart';
import 'package:samastha/modules/parent/repository/reward_repository.dart';
import 'package:samastha/theme/color_resources.dart';
import 'package:samastha/theme/dimensions.dart';
import 'package:samastha/theme/t_style.dart';
import 'package:samastha/widgets/app_bars_custom.dart';

class RewardsScreen extends StatefulWidget {
  const RewardsScreen({super.key});

  static const String path = '/rewards-screen';

  @override
  State<RewardsScreen> createState() => _RewardsScreenState();
}

class _RewardsScreenState extends State<RewardsScreen> {
  @override
  void initState() {
    Provider.of<RewardProvider>(context, listen: false).onRewardModelAdded();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SimpleAppBar(title: 'Rewards'),
      body: SafeArea(
          child: SingleChildScrollView(
        padding: pagePadding,
        child: Consumer<RewardProvider>(builder: (context, controller, _) {
          return controller.isLoading
              ? const Center(child: CircularProgressIndicator())
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      alignment: Alignment.centerLeft,
                      children: [
                        Assets.image.rewardCouponBg
                            .image(width: double.infinity),
                        Positioned(
                          left: 24,
                          child: Column(
                            children: [
                              Text('Earned Points',
                                  style: f16w400.copyWith(
                                      color: ColorResources.WHITE,
                                      shadows: [
                                        const BoxShadow(
                                            blurRadius: 30,
                                            spreadRadius: 0,
                                            offset: Offset(0, 10),
                                            color: Color(0xfff0f0f0))
                                      ])),
                              Text(
                                  '${controller.rewardData?.data?.earnedPoints} Pts',
                                  style: f16w400.copyWith(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 40,
                                      color: ColorResources.WHITE,
                                      shadows: [
                                        const BoxShadow(
                                            blurRadius: 30,
                                            spreadRadius: 0,
                                            offset: Offset(0, 10),
                                            color: Color(0xfff0f0f0))
                                      ])),
                            ],
                          ),
                        )
                      ],
                    ),
                    const Gap(19),
                    Container(
                      padding: const EdgeInsets.all(16).copyWith(right: 4),
                      decoration: defaultDecoration,
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Earn reward points',
                            style: titleSmall.darkBG,
                          ),
                          Text(
                            'Complete tasks to earn rewards',
                            style: labelSmall.darkBG,
                          ),
                          const Gap(12),
                          SizedBox(
                            height: 100,
                            child: ListView(
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(16),
                                  width: 191,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: const Color(0xff3BA8CA),
                                  ),
                                  child: Row(
                                    children: [
                                      Flexible(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Complete mega quiz',
                                              style: titleMedium.white,
                                            ),
                                            Text(
                                              'Earn 20 Pts',
                                              style: labelSmall.white,
                                            ),
                                          ],
                                        ),
                                      ),
                                      Assets.image.rewardQuiz.image(height: 48)
                                    ],
                                  ),
                                ),
                                const Gap(12),
                                Container(
                                  padding: const EdgeInsets.all(16),
                                  width: 191,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: const Color(0xff10A089),
                                  ),
                                  child: Row(
                                    children: [
                                      Flexible(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Complete mega quiz',
                                              style: titleMedium.white,
                                            ),
                                            Text(
                                              'Earn 20 Pts',
                                              style: labelSmall.white,
                                            ),
                                          ],
                                        ),
                                      ),
                                      Assets.image.rewardQuiz.image(height: 48)
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Gap(16),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: defaultDecoration,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Redemption History',
                            style: titleSmall.darkBG,
                          ),
                          const Gap(21),
                          ListView(
                            padding: EdgeInsets.zero,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            children: List.generate(
                                controller.rewardData?.data?.rewardHistory
                                        ?.length ??
                                    0, (index) {
                              final rewardHistory = controller
                                  .rewardData?.data?.rewardHistory?[index];
                              return MainItem(
                                title: rewardHistory?.pointType ?? '',
                                //'Redeemed for one to one class',
                                amount:
                                    (rewardHistory?.points.toString() ?? '0.0'),
                                titleStyle: bodyMedium.darkBG,
                                amountStyle: bodyMedium.red,
                              );
                            }),
                          )
                          // MainItem(
                          //   title: 'Redeemed for one to one class',
                          //   amount: '-10',
                          //   titleStyle: bodyMedium.darkBG,
                          //   amountStyle: bodyMedium.red,
                          // ),
                          // MainItem(
                          //   title: 'Redeemed for one to one class',
                          //   amount: '-10',
                          //   titleStyle: bodyMedium.darkBG,
                          //   amountStyle: bodyMedium.red,
                          // ),
                          // MainItem(
                          //   title: 'Earned from quiz',
                          //   amount: '+10',
                          //   titleStyle: bodyMedium.darkBG,
                          //   amountStyle: bodyMedium.green,
                          // ),
                          // MainItem(
                          //   title: 'Redeemed for one to one class',
                          //   amount: '-10',
                          //   titleStyle: bodyMedium.darkBG,
                          //   amountStyle: bodyMedium.red,
                          // ),
                        ],
                      ),
                    )
                  ],
                );
        }),
      )),
    );
  }
}
