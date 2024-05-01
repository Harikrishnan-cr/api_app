import 'package:flutter/material.dart';
import 'package:flutter_tawkto/flutter_tawk.dart';

import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:samastha/core/app_constants.dart';
import 'package:samastha/gen/assets.gen.dart';
import 'package:samastha/theme/color_resources.dart';
import 'package:samastha/theme/t_style.dart';

class ChatWithUsthad extends StatefulWidget {
  const ChatWithUsthad({super.key});
  static const String path = '/chat-with-usthad';

  @override
  State<ChatWithUsthad> createState() => _ChatWithUsthadState();
}

class _ChatWithUsthadState extends State<ChatWithUsthad> {
  List<String> messages = [];

  var scrollController = ScrollController();

  bool isReceivedMessage(String e) => messages.indexOf(e).isOdd;

  var messageTC = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Tawk(
          directChatLink:
              'https://tawk.to/chat/655f13aeda19b362178ff334/1hftm9phb',
          visitor: TawkVisitor(
            name: AppConstants.loggedUser?.name ?? "Student",
            email: AppConstants.loggedUser?.email ?? "email of student",
          ),
        ),
      ),
    );

    // return Scaffold(
    //   appBar: messages.isEmpty
    //       ? const SimpleAppBar(title: 'Chat with Usthad')
    //       : null,
    //   body: SafeArea(
    //       child: Container(
    //     margin: const EdgeInsets.all(16),
    //     padding: messages.isEmpty ? const EdgeInsets.all(16) : null,
    //     decoration: BoxDecoration(
    //         border: messages.isEmpty
    //             ? null
    //             : Border.all(
    //                 width: 1,
    //                 color: const Color(0xffEBEBEB),
    //               ),
    //         borderRadius: messages.isEmpty ? null : BorderRadius.circular(8),
    //         color: Colors.white,
    //         boxShadow: const [
    //           BoxShadow(
    //             offset: Offset(0, 10),
    //             blurRadius: 30,
    //             spreadRadius: 0,
    //             color: Color(0xfff0f0f0),
    //           ),
    //         ]),
    //     width: double.infinity,
    //     child: messages.isEmpty
    //         ? NoChatWidget(addMessage: () {
    //             messages.add('Assalamu alaikkum');
    //             setState(() {});
    //           })
    //         : Column(
    //             children: [
    //               Padding(
    //                 padding: const EdgeInsets.symmetric(
    //                     horizontal: 20, vertical: 25),
    //                 child: Row(
    //                   children: [
    //                     InkWell(
    //                         onTap: () {
    //                           Navigator.pop(context);
    //                         },
    //                         child: Assets.svgs.arrrowBack.svg()),
    //                     const Gap(8),
    //                     CircleAvatar(
    //                       radius: 42 / 2,
    //                       backgroundColor: ColorResources.PLACEHOLDER,
    //                       child: Assets.image.ustadDetails.image(),
    //                     ),
    //                     const Gap(16),
    //                     Flexible(
    //                       child: Column(
    //                         crossAxisAlignment: CrossAxisAlignment.start,
    //                         children: [
    //                           Text(
    //                             'Ramadan Malik',
    //                             style: titleLarge.darkBG,
    //                           ),
    //                           Text(
    //                             'Batch : UKSIP12',
    //                             style: bodyMedium.darkBG,
    //                           )
    //                         ],
    //                       ),
    //                     ),
    //                   ],
    //                 ),
    //               ),
    //               const Divider(),
    //               Expanded(
    //                 child: SingleChildScrollView(
    //                   controller: scrollController,
    //                   child: PaddedColumn(
    //                     padding: const EdgeInsets.all(
    //                       16,
    //                     ),
    //                     children: messages
    //                         .map(
    //                           (e) => Container(
    //                             margin: const EdgeInsets.only(bottom: 10),
    //                             alignment: isReceivedMessage(e)
    //                                 ? Alignment.centerLeft
    //                                 : Alignment.centerRight,
    //                             child: Column(
    //                               crossAxisAlignment: isReceivedMessage(e)
    //                                   ? CrossAxisAlignment.start
    //                                   : CrossAxisAlignment.end,
    //                               children: [
    //                                 Container(
    //                                   decoration: BoxDecoration(
    //                                       borderRadius: BorderRadius.only(
    //                                         bottomLeft: isReceivedMessage(e)
    //                                             ? Radius.zero
    //                                             : const Radius.circular(9),
    //                                         bottomRight: isReceivedMessage(e)
    //                                             ? const Radius.circular(8)
    //                                             : Radius.zero,
    //                                         topLeft: isReceivedMessage(e)
    //                                             ? const Radius.circular(8.0)
    //                                             : const Radius.circular(8.0),
    //                                         topRight: isReceivedMessage(e)
    //                                             ? const Radius.circular(8.0)
    //                                             : const Radius.circular(8.0),
    //                                       ),
    //                                       color: isReceivedMessage(e)
    //                                           ? ColorResources.secondary
    //                                               .withOpacity(.1)
    //                                           : ColorResources.primary
    //                                               .withOpacity(.1)),
    //                                   padding: const EdgeInsets.all(16),
    //                                   child: Text(e),
    //                                 ),
    //                                 const Gap(8),
    //                                 Text(
    //                                   ' ${timeago.format(
    //                                     DateTime.now(),
    //                                   )}',
    //                                 )
    //                               ],
    //                             ),
    //                           ),
    //                         )
    //                         .toList(),
    //                   ),
    //                 ),
    //               ),
    //               const Divider(),
    //               Padding(
    //                 padding: const EdgeInsets.symmetric(
    //                     horizontal: 20, vertical: 10),
    //                 child: Row(
    //                   children: [
    //                     Expanded(
    //                         child: TextField(
    //                       controller: messageTC,
    //                       maxLines: 1,
    //                       onSubmitted: (value) {
    //                         setState(() {
    //                           messages.add(value);
    //                         });
    //                         messageTC.clear();
    //                         if(scrollController.positions.isNotEmpty) {scrollController.jumpTo(
    //                             scrollController.position.maxScrollExtent);}
    //                       },
    //                       decoration:
    //                           const InputDecoration(hintText: 'Type here'),
    //                     )),
    //                     Row(
    //                       children: [
    //                         Assets.svgs.attachment.svg(),
    //                         const Gap(10),
    //                         Assets.svgs.mic.svg(),
    //                         const Gap(10),
    //                         GestureDetector(
    //                           onTap: () {
    //                             if (messageTC.text.trim().isNotEmpty) {
    //                               setState(() {
    //                                 messages.add(messageTC.text.trim());
    //                               });
    //                               messageTC.clear();
    //                              if(scrollController.positions.isNotEmpty) { scrollController.jumpTo(scrollController
    //                                   .position.maxScrollExtent);}
    //                             }
    //                           },
    //                           child: Assets.svgs.sendMessage.svg(),
    //                         ),
    //                       ],
    //                     )
    //                   ],
    //                 ),
    //               )
    //             ],
    //           ),
    //   )),
    // );
  }
}

class NoChatWidget extends StatelessWidget {
  const NoChatWidget({
    super.key,
    required this.addMessage,
  });

  final Function addMessage;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Gap(43 - 16),
        CircleAvatar(
          radius: 121 / 2,
          backgroundColor: ColorResources.PLACEHOLDER,
          child: Assets.image.ustadDetails.image(),
        ),
        const Gap(21),
        Text(
          'Ramadan Malik',
          style: titleLarge.darkBG,
        ),
        const Gap(4),
        Text(
          'Batch : UKSP12',
          style: bodyMedium.darkBG,
        ),
        const Spacer(),
        Assets.svgs.chatUsthad.svg(height: 116),
        const Gap(24),
        Text(
          'Start conversation by',
          style: bodyMedium.darkBG,
        ),
        const Gap(25),
        GestureDetector(
          onTap: () {
            addMessage();
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                gradient: const LinearGradient(
                    colors: [Color(0xff08aa4d), Color(0xff129c98)]),
                boxShadow: const [
                  BoxShadow(
                    blurRadius: 30,
                    offset: Offset(
                      0,
                      10,
                    ),
                    spreadRadius: 0,
                    color: Color(0xfff0f0f0),
                  )
                ]),
            child: Text(
              'Assalamu Alaikum',
              textAlign: TextAlign.center,
              style: GoogleFonts.orelegaOne(
                fontSize: 28,
                fontWeight: FontWeight.normal,
                color: Colors.white,
              ),
            ),
          ),
        ),
        const Gap(30)
      ],
    );
  }
}
