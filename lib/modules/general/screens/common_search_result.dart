// import 'package:flutter/material.dart';
// import 'package:samastha/theme/color_resources.dart';
// import 'package:samastha/theme/t_style.dart';
// import 'package:samastha/widgets/app_bars_custom.dart';
// import 'package:samastha/widgets/common_reload.dart';
// import 'dart:async';
// import 'package:samastha/widgets/custom_form_elements.dart';

// class CommonSearchResult<T> extends StatefulWidget {
//   const CommonSearchResult(
//       {super.key, required this.title, required this.search});
//   final String title;

//   final Future search;

//   @override
//   State<CommonSearchResult<T>> createState() => _CommonSearchResultState<T>();
// }

// class _CommonSearchResultState<T> extends State<CommonSearchResult<T>> {
//   late Future future;

//   @override
//   void initState() {
//     future = widget.search;
//     super.initState();
//   }

//   Timer? _debounce;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: SimpleAppBar(title: widget.title),
//       body: FutureBuilder(
//         future: future,
//         builder: (context, snapshot) {
//           if (snapshot.hasError) {
//             return CommonReload(
//                 message: snapshot.error.toString(),
//                 callback: () {
//                   setState(() {
//                     future = widget.search;
//                   });
//                 });
//           }

//           switch (snapshot.connectionState) {
//             case ConnectionState.active:
//             case ConnectionState.done:
//               return Column(
//                 children: [
//                   Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: TextFieldCustom(
//                       onChanged: (text) {
//                         if (_debounce?.isActive ?? false) _debounce!.cancel();
//                         _debounce =
//                             Timer(const Duration(milliseconds: 500), () {
//                           setState(() {
//                             future = widget.search;
//                           });
//                         });
//                       },
//                       labelText: 'Search',
//                       suffixWidget: const Icon(
//                         Icons.search,
//                         color: ColorResources.primary,
//                       ),
//                     ),
//                   ),
//                   Expanded(
//                     child: ListView.builder(
//                       padding: pagePadding.copyWith(top: 0),
//                       itemCount: snapshot.data!.length,
//                       itemBuilder: (context, index) {
//                         return ListTile(
//                           contentPadding: EdgeInsets.zero,
//                           onTap: () {
//                             Navigator.pop(context, snapshot.data[index]);
//                           },
//                           title: Text(snapshot.data[index].toString()),
//                         );
//                       },
//                     ),
//                   ),
//                 ],
//               );
//             case ConnectionState.waiting:
//               return Center(
//                   child:
//                       stoppedAnimationProgress(color: ColorResources.primary));
//             default:
//               return Container();
//           }
//         },
//       ),
//     );
//   }
// }

// CustomSearchResult is a modified version of your CommonSearchResult
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:samastha/theme/color_resources.dart';
import 'package:samastha/theme/t_style.dart';
import 'package:samastha/widgets/app_bars_custom.dart';
import 'package:samastha/widgets/common_reload.dart';
import 'package:samastha/widgets/custom_form_elements.dart';

class CustomSearchResult<T> extends StatefulWidget {
  const CustomSearchResult(
      {super.key, required this.title, required this.search});
  final String title;
  final Future<List<T>> Function(String) search;

  @override
  State<CustomSearchResult<T>> createState() => _CustomSearchResultState<T>();
}

class _CustomSearchResultState<T> extends State<CustomSearchResult<T>> {
  late Future<List<T>> future;
  String searchText = "";

  var searchTC = TextEditingController();

  @override
  void initState() {
    future = widget.search("");
    super.initState();
  }

  Timer? _debounce;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SimpleAppBar(title: widget.title),
      body: FutureBuilder(
        future: future,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return CommonReload(
                message: snapshot.error.toString(),
                callback: () {
                  setState(() {
                    future = widget.search(searchText);
                  });
                });
          }

          switch (snapshot.connectionState) {
            case ConnectionState.active:
            case ConnectionState.done:
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFieldCustom(
                      controller: searchTC,
                      textInputAction: TextInputAction.search,
                      onFieldSubmitted: (value) {
                        print('onFieldSubmitted');
                        searchText = value;

                        if (_debounce?.isActive ?? false) _debounce!.cancel();
                        _debounce =
                            Timer(const Duration(milliseconds: 500), () {
                          setState(() {
                            future = widget.search(searchText);
                          });
                        });
                      },
                      onChanged: (text) {
                        // searchText = text;

                        // if (_debounce?.isActive ?? false) _debounce!.cancel();
                        // _debounce =
                        //     Timer(const Duration(milliseconds: 500), () {
                        //   setState(() {
                        //     future = widget.search(searchText);
                        //   });
                        // });
                      },
                      labelText: 'Search',
                      suffixWidget: const Icon(
                        Icons.search,
                        color: ColorResources.primary,
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      padding: pagePadding.copyWith(top: 0),
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          contentPadding: EdgeInsets.zero,
                          onTap: () {
                            Navigator.pop(context, snapshot.data![index]);
                          },
                          title: Text(snapshot.data![index].toString()),
                        );
                      },
                    ),
                  ),
                ],
              );
            case ConnectionState.waiting:
              return Center(
                  child:
                      stoppedAnimationProgress(color: ColorResources.primary));
            default:
              return Container();
          }
        },
      ),
    );
  }
}
