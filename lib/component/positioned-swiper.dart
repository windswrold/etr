// import 'package:chewie/chewie.dart';
import 'package:etrflying/model/praise.dart';
import 'package:flutter/material.dart';

// import 'package:flutter_swiper/flutter_swiper.dart';
// import 'package:video_player/video_player.dart';
class PositionedSwiper extends StatefulWidget {
  final double? left;
  final double? right;
  final double? top;
  final double? bottom;
  final double? width;
  final double? height;
  final List<VideoImg>? videos;
  final Widget? to;

  const PositionedSwiper(
      {Key? key,
      this.left,
      this.right,
      this.top,
      this.bottom,
      this.width,
      this.height,
      this.videos,
      this.to})
      : super(key: key);
  PositionedSwiperState createState() => PositionedSwiperState();
}

class PositionedSwiperState extends State<PositionedSwiper> {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: widget.left,
      right: widget.right,
      top: widget.top,
      bottom: widget.bottom,
      child: Container(
          width: widget.width,
          height: widget.height,
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => widget.to!));
            },
            // child:
            // Swiper(
            //     autoplay: false,
            //     itemCount: widget.videos.length,
            //     pagination: new SwiperPagination(
            //         builder: DotSwiperPaginationBuilder(
            //           color: Colors.black54,
            //           activeColor: Colors.white,
            //         )),
            //     itemBuilder: (BuildContext context, int index) {
            //       VideoImg videoImg = widget.videos[index];
            //       VideoPlayerController controller =
            //       VideoPlayerController.network(videoImg.contentUrl);
            //       controller.play;
            //       if (videoImg.type == 0) {
            //         return Chewie(
            //           controller: ChewieController(
            //               videoPlayerController:
            //               VideoPlayerController.network(
            //                   videoImg.contentUrl),
            //               aspectRatio: 1,
            //               autoPlay: true,
            //               looping: true,
            //               showControls: false),
            //         );
            //       }
            //       return Image.network(
            //         videoImg.contentUrl,
            //         fit: BoxFit.cover,
            //       );
            // }
            // ),
          )),
    );
  }
}
