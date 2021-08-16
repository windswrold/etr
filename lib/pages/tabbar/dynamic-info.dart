// import 'package:chewie/chewie.dart';
import 'package:etrflying/component/positioned-img.dart';
import 'package:etrflying/component/positioned-text-component.dart';
import 'package:etrflying/component/router-back.dart';
import 'package:etrflying/model/praise.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:video_player/video_player.dart';

class DynamicInfo extends StatefulWidget {
  DynamicInfoState createState() => DynamicInfoState();
}

class DynamicInfoState extends State<DynamicInfo> {
  String path = "assets/img/home";
  static final String headUrl =
      "https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fpic1.zhimg.com%2F50%2Fv2-71dcef82c8afb85dacd42a995f64f1b5_hd.jpg&refer=http%3A%2F%2Fpic1.zhimg.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1626688059&t=4f0c438eab733f33f832c484e34a65fa";
  final Praise praise = Praise(
      headUrl,
      "helloketty",
      "女",
      23,
      158,
      23432,
      [headUrl, headUrl, headUrl],
      [VideoImg(1, headUrl), VideoImg(1, headUrl)],
      "这是我发的第一个动态！这是我发的第一个动态！这是我发的第一个动态！这是我发的第一个动态！这是我发的第一个动态！这是我发的第一个动态！这是我发的第一个动态！这是我发的第一个动态！这是我发的第一个动态！这是我发的第一个动态！这是我发的第一个动态！这是我发的第一个动态！这是我发的第一个动态！这是我发的第一个动态！这是我发的第一个动态！这是我发的第一个动态！这是我发的第一个动态！",
      true);

  @override
  Widget build(BuildContext context) {
    return ListView(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      padding: EdgeInsets.all(0),
      children: <Widget>[
      Container(
          color: Colors.white,
          height: 812,
          child: Stack(
            children: <Widget>[
              BackComponet(),
              PositionedTextComponent(
                left: 0,
                right: 0,
                width: double.infinity,
                top: 54,
                text: praise.nick,
                textAlign: TextAlign.center,
                fontSize: 17,
                color: Color(0xff333333),
                fontWeight: FontWeight.bold,
              ),
              PositionedImg(
                  left: 14, top: 104, width: 48, height: 48, src: praise.headUrl),
              PositionedTextComponent(
                left: 74,
                right: 0,
                width: double.infinity,
                top: 109,
                text: praise.nick,
                fontSize: 14,
                color: Color(0xff333333),
                fontWeight: FontWeight.bold,
              ),
              PositionedTextComponent(
                left: 74,
                right: 0,
                width: double.infinity,
                top: 131,
                text: praise.gender +
                    "/" +
                    praise.age.toString() +
                    "岁/" +
                    praise.height.toString() +
                    "cm",
                fontSize: 12,
                color: Color(0xff333333),
              ),
              Positioned(
                top: 168,
                left: 0,
                right: 0,
                child: Container(
                  width: double.infinity,
                  height: 355,
                  child: 
                //   Swiper(
                //       autoplay: false,
                //       itemCount: praise.videos.length,
                //       pagination: new SwiperPagination(
                //           builder: DotSwiperPaginationBuilder(
                //             color: Colors.black54,
                //             activeColor: Colors.white,
                //           )),
                //       itemBuilder: (BuildContext context, int index) {
                //         VideoImg videoImg = praise.videos[index];
                //         VideoPlayerController controller =
                //         VideoPlayerController.network(videoImg.contentUrl);
                //         controller.play;
                //         if (videoImg.type == 0) {
                //           return Chewie(
                //             controller: ChewieController(
                //                 videoPlayerController:
                //                 VideoPlayerController.network(
                //                     videoImg.contentUrl),
                //                 aspectRatio: 1,
                //                 autoPlay: true,
                //                 looping: true,
                //                 showControls: false),
                //           );
                //         }
                //         return Image.network(
                //           videoImg.contentUrl,
                //           fit: BoxFit.cover,
                //         );
                //       }),
                // ),
              // ),
              praise.praiseHeads.length > 0
                  ? PositionedImg(
                  left: 14,
                  top: 535,
                  width: 16,
                  height: 16,
                  src: praise.praiseHeads[0])
                  : Positioned(
                child: Container(),
              ),
              // praise.praiseHeads.length > 1
              //     ? PositionedImg(
              //     left: 27,
              //     top: 535,
              //     width: 16,
              //     height: 16,
              //     src: praise.praiseHeads[1])
              //     : Positioned(
              //   child: Container(),
              // ),
              // praise.praiseHeads.length == 3
              //     ? PositionedImg(
              //     left: 40,
              //     top: 535,
              //     width: 16,
              //     height: 16,
              //     src: praise.praiseHeads[2])
              //     : Positioned(
              //   child: Container(),
              // ),
              // PositionedTextComponent(
              //   left: 62,
              //   top: 533,
              //   text: "等" + praise.praiseCount.toString() + "次赞",
              //   color: Color(0xff333333),
              //   fontWeight: FontWeight.bold,
              //   fontSize: 14,
              // ),
              // PositionedImg(
              //   right: 50,
              //   top: 532,
              //   width: 20,
              //   height: 20,
              //   src: (path +
              //       (praise.isLike ? "/like-icon.png" : "/unlike-icon.png")),
              //   isNetwork: false,
              // ),
              // PositionedImg(
              //   right: 15,
              //   top: 532,
              //   width: 20,
              //   height: 20,
              //   src: path + "/gift-icon.png",
              //   isNetwork: false,
              // ),
              // PositionedTextComponent(
              //   left: 14,
              //   right: 14,
              //   top: 563,
              //   width: double.infinity,
              //   height: 300,
              //   text: praise.content,
              //   color: Color(0xff333333),
              //   fontWeight: FontWeight.w400,
              //   fontSize: 14,
              ))
            ],
          ))
    ],);
  }
}
