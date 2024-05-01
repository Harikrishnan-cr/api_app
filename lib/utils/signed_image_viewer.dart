import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';

import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:samastha/modules/general/bloc/core_bloc.dart';
import 'package:samastha/theme/color_resources.dart';
import 'package:samastha/widgets/default_loading_widget.dart';
import 'package:video_player/video_player.dart';
import 'package:visibility_detector/visibility_detector.dart';


Future<String?> getUrl(String path) async => 
await CoreBloc().getImageUrl(path);

typedef SignedImageBuilder = Widget Function(
  ImageProvider? image,
  bool loading,
);

class SignedImageLoader extends StatefulWidget {
  SignedImageLoader({
    required this.path,
    required this.imageBuilder,
  }) : super(key: Key(path ?? ''));

  final String? path;

  final SignedImageBuilder imageBuilder;

  @override
  State<SignedImageLoader> createState() => _SignedImageLoaderState();
}

class _SignedImageLoaderState extends State<SignedImageLoader> {
  String? url;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) => _getUrl());
  }

  Future<void> _getUrl() async {
    if (widget.path == null) return;
    try {
      url = await getUrl(widget.path!);
      setState(() {});
    } catch (e) {
      //
    }
  }

  @override
  Widget build(BuildContext context) {
    if (url == null) {
      return widget.imageBuilder(
        null,
        true,
      );
    }

    return CachedNetworkImage(
      imageUrl: url!,
      fit: BoxFit.cover,
      errorWidget: (context, url, error) => widget.imageBuilder(
        null,
        false,
      ),
      imageBuilder: (context, imageProvider) => widget.imageBuilder(
        imageProvider,
        false,
      ),
      progressIndicatorBuilder: (context, url, progress) => widget.imageBuilder(
        null,
        true,
      ),
    );
  }
}

class UserAvatar extends StatefulWidget {
  UserAvatar({required this.path, this.size = 32.0, this.isExtended = false})
      : super(key: Key(path ?? ''));

  final String? path;
  final double size;
  final bool isExtended;

  UserAvatar.extended(
      {required this.path, this.size = 32.0, this.isExtended = true})
      : super(key: Key(path ?? ''));

  @override
  State<UserAvatar> createState() => _UserAvatarState();
}

class _UserAvatarState extends State<UserAvatar> {
  String? url;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) => _getUrl());
  }

  Future<void> _getUrl() async {
    if (widget.path?.isEmpty ?? false) return;
    try {
      url = await getUrl(widget.path!);
      log('imgUrl : $url');
      setState(() {});
    } catch (e) {
      //
    }
  }

  @override
  Widget build(BuildContext context) {
    if (url == null) {
      return userImageContainer(size: widget.size);
    }

    return CachedNetworkImage(
      key: Key(url!),
      height: widget.size,
      imageUrl: url!,
      width: widget.size,
      cacheKey: url,
      fit: BoxFit.cover,
      errorWidget: (context, url, error) {
        return userImageContainer(size: widget.size);
      },
      imageBuilder: (context, imageProvider) =>
          userImageContainer(image: imageProvider, size: widget.size),
      progressIndicatorBuilder: (context, url, progress) =>
          userImageContainer(size: widget.size),
    );
  }
}

Widget userImageContainer({ImageProvider? image, required double size}) =>
    Container(
      height: size,
      width: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: ColorResources.BORDER_SHADE,
        image: image == null
            ? null
            : DecorationImage(
                image: image,
                fit: BoxFit.cover,
              ),
      ),
      child: image == null
          ? Center(
              child: Icon(
              Icons.person,
              size: size,
              color: ColorResources.PLACEHOLDER,
            ))
          : null,
    );
Widget errorImageContainer({ImageProvider? image, required double size}) =>
    Container(
      height: size,
      width: size,
      // padding: const EdgeInsets.all(4).copyWith(
      //   bottom: 6.0,
      // ),
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        color: ColorResources.BORDER_SHADE.withOpacity(.3),
      ),
    );

class ImageViewer extends StatefulWidget {
  ImageViewer({
    required this.path,
    this.height = 32.0,
    this.width,
    this.fit = BoxFit.cover,
  }) : super(key: Key(path ?? ''));

  final String? path;
  final double height;
  final double? width;
  final BoxFit fit;

  @override
  State<ImageViewer> createState() => _ImageViewerState();
}

class _ImageViewerState extends State<ImageViewer> {
  String? url;

  @override
  void initState() {
    super.initState();
    if (url == null) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) => _getUrl());
    }
  }

  Future<void> _getUrl() async {
    if (widget.path == null) return;
    try {
      url = await getUrl(widget.path!);
      setState(() {});
    } catch (e) {
      //
    }
  }

  @override
  Widget build(BuildContext context) {
    if (url == null) {
      return SizedBox.square(
        dimension: widget.height,
        child: Container(),
      );
    }

    return CachedNetworkImage(
      key: Key(url!),
      height: widget.height,
      width: widget.width ?? double.infinity,
      imageUrl: url!,
      fit: widget.fit,
      placeholder: (context, url) {
        return const LoadingWidget();
      },
      errorWidget: (context, url, error) =>
          errorImageContainer(size: widget.height),
    );
  }
}

// class VideoViewer extends StatefulWidget {
//   const VideoViewer({
//     super.key,
//     required this.path,
//   });

//   final String? path;

//   @override
//   State<VideoViewer> createState() => _VideoViewerState();
// }

// class _VideoViewerState extends State<VideoViewer> {
//   String? url;
//   late FlickManager flickManager;

//   @override
//   void initState() {
//     super.initState();

//     if (url == null) {
//       WidgetsBinding.instance.addPostFrameCallback((timeStamp) => _getUrl());
//     }
//   }

//   Future<void> _getUrl() async {
//     if (widget.path == null) return;
//     try {
//       url = await getUrl(widget.path!);
//       setState(() {
//         flickManager = FlickManager(
//           autoPlay: false,
//           videoPlayerController: VideoPlayerController.network(url!,
//               videoPlayerOptions: VideoPlayerOptions(
//                 allowBackgroundPlayback: false,
//               )),
//         );
//       });
//     } catch (e) {
//       //
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     if (url == null) {
//       return SizedBox.square(
//         dimension: double.infinity,
//         child: Container(),
//       );
//     }

//     return Visibility(
//       maintainState: true,
//       child: VisibilityDetector(
//         key: Key(url ?? ''),
//         onVisibilityChanged: (VisibilityInfo visibility) {
//           if (visibility.visibleFraction == 0 && mounted) {
//             flickManager.flickControlManager?.pause();
//           }
//         },
//         child: FlickVideoPlayer(
//           flickManager: flickManager,
//           flickVideoWithControls: const FlickVideoWithControls(
//             controls: FlickPortraitControls(),
//             videoFit: BoxFit.fitWidth,
//           ),
//         ),
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     super.dispose();
//     flickManager.flickControlManager?.pause();
//     flickManager.dispose();
//   }
// }

class VideoViewer extends StatefulWidget {
  const VideoViewer({
    super.key,
    required this.path,
  });

  final String? path;

  @override
  State<VideoViewer> createState() => _VideoViewerState();
}

class _VideoViewerState extends State<VideoViewer> {
  String? url;
  late FlickManager flickManager;

  @override
  void initState() {
    super.initState();

    if (url == null) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) => _getUrl());
    }
  }

  Future<void> _getUrl() async {
    if (widget.path == null) return;
    try {
      url = await getUrl(widget.path!);
      setState(() {
        flickManager = FlickManager(
          autoPlay: false,
          videoPlayerController: VideoPlayerController.networkUrl(Uri.parse(url!),
              videoPlayerOptions: VideoPlayerOptions(
                allowBackgroundPlayback: false,
              )),
        );
      });
    } catch (e) {
      //
    }
  }

  @override
  Widget build(BuildContext context) {
    if (url == null) {
      return SizedBox.square(
        dimension: double.infinity,
        child: Container(),
      );
    }

    return Visibility(
      maintainState: true,
      child: VisibilityDetector(
        key: Key(url ?? ''),
        onVisibilityChanged: (VisibilityInfo visibility) {
          if (visibility.visibleFraction == 0 && mounted) {
            flickManager.flickControlManager?.pause();
          }
        },
        child: FlickVideoPlayer(
          flickManager: flickManager,
          flickVideoWithControls: const FlickVideoWithControls(
            controls: FlickPortraitControls(),
            videoFit: BoxFit.fitWidth,
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    flickManager.flickControlManager?.pause();
    flickManager.dispose();
  }
}

class ChatImageViewer extends StatefulWidget {
  const ChatImageViewer({
    super.key,
    required this.path,
    this.height = 32.0,
    this.width,
    this.fit = BoxFit.cover,
  });

  final String? path;
  final double height;
  final double? width;
  final BoxFit fit;

  @override
  State<ChatImageViewer> createState() => _ChatImageViewerState();
}

class _ChatImageViewerState extends State<ChatImageViewer> {
  String? url;

  @override
  void initState() {
    super.initState();
    if (url == null) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) => _getUrl());
    }
  }

  Future<void> _getUrl() async {
    if (widget.path == null) return;
    try {
      url = await getUrl(widget.path!);
      setState(() {});
    } catch (e) {
      //
    }
  }

  @override
  Widget build(BuildContext context) {
    if (url == null) {
      return SizedBox.square(
        dimension: widget.height,
        child: Container(),
      );
    }

    return CachedNetworkImage(
      height: widget.height,
      width: widget.width ?? double.infinity,
      imageUrl: url!,
      fit: widget.fit,
      memCacheHeight: 200,
      memCacheWidth: 100,
      placeholder: (context, url) {
        return const LoadingWidget();
      },
      errorWidget: (context, url, error) =>
          errorImageContainer(size: widget.height),
    );
  }
}

class ImageViewerProvider extends StatefulWidget {
  ImageViewerProvider({
    required this.path,
    this.height = 32.0,
    this.width,
    this.fit = BoxFit.cover,
  }) : super(key: Key(path ?? ''));

  final String? path;
  final double height;
  final double? width;
  final BoxFit fit;

  @override
  State<ImageViewerProvider> createState() => _ImageViewerProviderState();
}

class _ImageViewerProviderState extends State<ImageViewerProvider> {
  String? url;

  @override
  void initState() {
    super.initState();
    if (url == null) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) => _getUrl());
    }
  }

  Future<void> _getUrl() async {
    if (widget.path == null) return;
    try {
      url = await getUrl(widget.path!);
      setState(() {});
    } catch (e) {
      //
    }
  }

  @override
  Widget build(BuildContext context) {
    if (url == null) {
      return SizedBox.square(
        dimension: widget.height,
        child: Container(),
      );
    }

    return CachedNetworkImage(
      key: Key(url!),
      height: widget.height,
      width: widget.width ?? double.infinity,
      imageUrl: url!,
      fit: widget.fit,
      placeholder: (context, url) {
        return const LoadingWidget();
      },
      errorWidget: (context, url, error) =>
          errorImageContainer(size: widget.height),
    );
  }
}


// class CustomImageProvider extends StatefulWidget {
//   final String? path;
//   final BoxFit fit;

//   const CustomImageProvider({
//     Key? key,
//     required this.path,
//     this.fit = BoxFit.cover,
//   }) : super(key: key);

//   @override
//   State<CustomImageProvider> createState() => _CustomImageProviderState();

//   DecorationImage getDecorationImage() {
//     return _CustomImageProviderState().getDecorationImage();
//   }
// }

// class _CustomImageProviderState extends State<CustomImageProvider> {
//   String? url;

//   @override
//   void initState() {
//     super.initState();
//     if (url == null) {
//       WidgetsBinding.instance?.addPostFrameCallback((_) => _getUrl());
//     }
//   }

//   Future<void> _getUrl() async {
//     if (widget.path == null) return;
//     try {
//       url = await getUrl(widget.path!);
//       setState(() {});
//     } catch (e) {
//       // Handle error
//     }
//   }

//   DecorationImage getDecorationImage() {
//     if (url == null) {
//       return DecorationImage(
//         image: AssetImage('assets/placeholder_image.png'), // Placeholder image asset
//         fit: widget.fit,
//       );
//     } else {
//       return DecorationImage(
//         image: CachedNetworkImageProvider(url!),
//         fit: widget.fit,
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container();
//   }
// }
