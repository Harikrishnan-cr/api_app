import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:samastha/core/app_constants.dart';
import 'package:samastha/gen/assets.gen.dart';
import 'package:samastha/modules/courses/models/course_model.dart';
import 'package:samastha/modules/courses/screens/course_detail_screen.dart';
import 'package:samastha/utils/signed_image_viewer.dart';

class HomeSearchBar extends StatefulWidget {
  const HomeSearchBar({
    super.key,
    this.onPressed,
    this.courseList,
  });
  final void Function()? onPressed;
  final List<CourseModel>? courseList;

  @override
  State<HomeSearchBar> createState() => _HomeSearchBarState();
}

class _HomeSearchBarState extends State<HomeSearchBar> {
  final _searchController = SearchController();
  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
        onPressed: widget.onPressed,
        padding: EdgeInsets.zero,
        child: SearchAnchor.bar(
          searchController: _searchController,
          barTrailing: [
            CircleAvatar(
                backgroundColor: const Color(0xff0BAA56).withOpacity(.6),
                child: Assets.svgs.searchTiny.svg())
          ],
          barLeading: Container(),
          barBackgroundColor: MaterialStateProperty.all(
              const Color.fromARGB(175, 169, 241, 238)),
          barTextStyle:
              MaterialStateProperty.all(const TextStyle(color: Colors.white)),
          barHintText: 'Search any courses here',
          barHintStyle:
              MaterialStateProperty.all(const TextStyle(color: Colors.white)),

          constraints: const BoxConstraints(maxWidth: 380, minHeight: 56),
          // viewLeading: const Icon(Icons.search, color: Colors.white),
          viewTrailing: [Container()],
          viewLeading: const Padding(
            padding: EdgeInsets.all(8.0),
            child: Icon(Icons.search),
          ),
          // viewTrailing: [CircleAvatar(
          //       backgroundColor: const Color(0xff0BAA56).withOpacity(.6),
          //       child: Assets.svgs.searchTiny.svg())],
          // viewBackgroundColor: Colors.pink,
          viewHeaderTextStyle: const TextStyle(color: Colors.black),
          viewHintText: 'Enter keyword here',
          viewHeaderHintStyle: const TextStyle(color: Colors.black),
          viewConstraints: const BoxConstraints(
            maxWidth: 380,
            // maxHeight: 300,
          ),
          viewElevation: 100,
          dividerColor: Colors.teal,
          isFullScreen: false,
          suggestionsBuilder:
              (BuildContext context, SearchController controller) {
            if (1 != 1) {
              return [
                Assets.svgs.kids.comingsoonPoster2.svg(),
              ];
            }

            final keyword = controller.value.text;
            var newList = List.generate(widget.courseList?.length ?? 0,
                    (index) => widget.courseList?[index])
                .where((element) => element!.title!
                    .toLowerCase()
                    .startsWith(keyword.toLowerCase()))
                .map((item) => Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.black12,
                            borderRadius: BorderRadius.circular(10)),
                        child: ListTile(
                          leading: ImageViewer(
                              path: item?.photoUrl, height: 50, width: 50),
                          title: Text(item?.title ?? ''),
                          subtitle: Text(item?.description ?? ''),
                          trailing: Text(
                              '${AppConstants.rupeeSign} ${item?.price ?? 0}'),
                          onTap: 1 != 1
                              ? null
                              : () {
                                  Navigator.pushNamed(
                                      context, CourseDetailScreen.path,
                                      arguments: {
                                        'id': item?.id,
                                        'name': item?.title,
                                        'isPurchased': true
                                      });
                                },
                        ),
                      ),
                    ));

            //     GestureDetector(
            //   onTap: () {
            //     // setState(() {
            //       controller.closeView(item?.title);
            //     // });
            //   },
            //   child: ListTile(
            //     tileColor: Colors.amber,
            //     title: Text(item?.title ?? '', style: const TextStyle(color: Colors.white)),
            //     onTap: () {
            //       // setState(() {
            //         controller.closeView(item?.title);
            //         FocusScope.of(context).unfocus();
            //       // });
            //     },
            //   ),
            // ));
            print('search list $newList');
            return newList;
          },
        )

        // Container(
        //   height: 56,
        //   padding: const EdgeInsets.only(left: 24, right: 9),
        //   decoration: BoxDecoration(
        //     borderRadius: BorderRadius.circular(100),
        //     gradient: LinearGradient(colors: [
        //       // ColorResources.gradientNavEnd,
        //       // ColorResources.gradientNavStart,
        //       Colors.white.withOpacity(.5),
        //       Colors.white.withOpacity(.29),
        //     ]),
        //   ),
        //   child: Row(
        //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //     children: [
        //       Text(
        //         'Search any courses here',
        //         style: GoogleFonts.inter(
        //             fontSize: 16,
        //             fontWeight: FontWeight.normal,
        //             color: ColorResources.WHITE),
        //       ),
        //       CircleAvatar(
        //           backgroundColor: const Color(0xff0BAA56).withOpacity(.6),
        //           child: Assets.svgs.searchTiny.svg())
        //     ],
        //   ),
        // ),
        );
  }
}
