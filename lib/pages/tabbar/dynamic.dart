// import 'package:chewie/chewie.dart';
import 'package:etrflying/component/dialog-component.dart';
import 'package:etrflying/component/positioned-img.dart';
import 'package:etrflying/component/positioned-text-component.dart';
import 'package:etrflying/component/text-component.dart';
import 'package:etrflying/model/praise.dart';
import 'package:etrflying/pages/fill_info/person_email.dart';

import 'package:etrflying/pages/immortal_auth/upload-img.dart';
import 'package:etrflying/pages/tabbar/dynamic-info.dart';
import 'package:etrflying/pages/tabbar/person-dynamic.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:video_player/video_player.dart';

class Dynamic extends StatefulWidget {
  DynamicState createState() => DynamicState();
}

class DynamicState extends State<Dynamic> {
  String path = "assets/img/home";
  bool isAuth = false;
  static final String headUrl =
      "https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fpic1.zhimg.com%2F50%2Fv2-71dcef82c8afb85dacd42a995f64f1b5_hd.jpg&refer=http%3A%2F%2Fpic1.zhimg.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1626688059&t=4f0c438eab733f33f832c484e34a65fa";
  static final String videoUrl =
      "https://vd2.bdstatic.com/mda-jgumsbtxkay5fzg2/sc/mda-jgumsbtxkay5fzg2.mp4?v_from_s=gz_haokan_4469&auth_key=1624103439-0-0-e49ab01197963d65b43b9c59e05c774f&bcevod_channel=searchbox_feed&pd=1&pt=3&abtest=";
  static final String contentUrl =
      "https://vd4.bdstatic.com/mda-kgnrbutu01zc6as0/v1-cae/1080p/mda-kgnrbutu01zc6as0.mp4?v_from_s=gz_haokan_4469&auth_key=1624108149-0-0-d3f1199a0bec77375c7ae628aeac8d9b&bcevod_channel=searchbox_feed&pd=1&pt=3&abtest=";
  List<Praise> praises = [
    Praise(
        headUrl,
        "helloketty",
        "女",
        23,
        158,
        23432,
        [headUrl, headUrl, headUrl],
        [VideoImg(1, headUrl), VideoImg(1, headUrl)],
        "这是我发的第一个动态",
        true)
  ];

  // Widget itemBuilder(BuildContext context, int index) {}

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          width: double.infinity,
          height: isAuth ? 94 : 175,
          padding: EdgeInsets.all(0),
          child: Stack(
            children: <Widget>[
              PositionedTextComponent(
                text: "动态",
                left: 14,
                top: 52,
                height: 33,
                fontSize: 24,
                fontFamily: "PingFangSC",
                color: Color(0xff333333),
                fontWeight: FontWeight.w600,
              ),
              Positioned(
                left: 14,
                right: 14,
                top: 97,
                child: Container(
                    width: 347,
                    height: 62,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular((7)),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                              offset: Offset(0, 5),
                              blurRadius: 8,
                              color: Color.fromRGBO(192, 192, 192, 0.30)),
                        ])),
              ),
              Positioned(
                right: 14,
                top: 57,
                child: GestureDetector(
                  child: Image.asset(
                    path + "/release-icon.png",
                    width: 24,
                    height: 24,
                  ),
                  onTap: () {
//                  Navigator.of(context).push(MaterialPageRoute(
//                      builder: (BuildContext context) => ReleaseDynamic()));
                    showDialog(
                        context: context,
                        builder: (context) {
                          return DialogComponent(
                              tipsIconSrc: path + "/sorry-icon.png",
                              closeIconSrc: path + "/close-icon.png",
                              to: UploadImg(),
//                            PersonEmail(),
                              content: "您需要真人认证份才能发布动态",
//                            "您需要先备份身份才能发布动态",
                              buttonText: "去认证"
//                            "去备份",
                              );
                        });
                  },
                ),
              ),
              isAuth
                  ? Positioned(
                      child: Container(),
                    )
                  : PositionedTextComponent(
                      text: "信息完善提醒",
                      left: 26,
                      top: 108,
                      height: 22,
                      width: 78,
                      fontSize: 11,
                      fontFamily: "PingFangSC",
                      color: Colors.white,
                      backgroundColor: Color(0xff9662FF),
                      textAlign: TextAlign.center,
                      paddingTop: 2,
                    ),
              isAuth
                  ? Positioned(
                      child: Container(),
                    )
                  : PositionedTextComponent(
                      text: "你还没有备份身份，备份后享受更多权益！",
                      left: 26,
                      top: 132,
                      height: 17,
                      fontSize: 12,
                      fontFamily: "PingFangSC",
                      color: Color(0xff333333)),
              isAuth
                  ? Positioned(
                      child: Container(),
                    )
                  : Positioned(
                      right: 26,
                      top: 116,
                      child: Image.asset(
                        path + "/remind-icon.png",
                        width: 69,
                        height: 28,
                      ),
                    ),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            padding: EdgeInsets.all(0),
            scrollDirection: Axis.vertical,
            itemCount: praises.length,
            itemBuilder: (context, index) {
              return DynamicContent(praise: praises[index]);
            },
          ),
        ),
      ],
    );
  }
}

class DynamicContent extends StatefulWidget {
  final Praise? praise;

  const DynamicContent({Key? key, this.praise}) : super(key: key);

  DynamicContentState createState() => DynamicContentState();
}

class DynamicContentState extends State<DynamicContent> {
  String path = "assets/img/home";

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(0),
      width: double.infinity,
      child: Column(
        children: <Widget>[
          Container(
            width: double.infinity,
            height: 80,
            padding: EdgeInsets.all(0),
            child: Row(
              children: <Widget>[
                GestureDetector(
                  child: Container(
                    width: 48,
                    height: 48,
                    padding: EdgeInsets.all(0),
                    margin: EdgeInsets.only(left: 14),
                    decoration: ShapeDecoration(
                        image: DecorationImage(
                            image: NetworkImage(widget.praise!.headUrl),
                            fit: BoxFit.cover),
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadiusDirectional.circular(24))),
                  ),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context) => PersonDynamic()));
                  },
                ),
                Container(
                  height: double.infinity,
                  padding: EdgeInsets.all(0),
                  margin: EdgeInsets.only(left: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(top: 21),
                        height: 20,
                        child: TextComponent(
                          text: widget.praise!.nick,
                          color: Color(0xff333333),
                          fontSize: 14,
                          fontFamily: "PingFangSC",
                          fontWeight: FontWeight.w600,
                          textAlign: TextAlign.left,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 2),
                        height: 17,
                        child: TextComponent(
                          text: widget.praise!.gender +
                              "/" +
                              widget.praise!.age.toString() +
                              "岁/" +
                              widget.praise!.height.toString() +
                              "cm",
                          color: Color(0xff666666),
                          fontSize: 12,
                          fontFamily: "PingFangSC",
                          textAlign: TextAlign.left,
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
              width: double.infinity,
              height: 355,
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) => DynamicInfo()));
                },
                // child: Swiper(
                //     autoplay: false,
                //     itemCount: widget.praise.videos.length,
                //     pagination: new SwiperPagination(
                //         builder: DotSwiperPaginationBuilder(
                //       color: Colors.black54,
                //       activeColor: Colors.white,
                //     )),
                //     itemBuilder: (BuildContext context, int index) {
                //       VideoImg videoImg = widget.praise.videos[index];
                //       VideoPlayerController controller =
                //           VideoPlayerController.network(videoImg.contentUrl);
                //       controller.play;
                //       if (videoImg.type == 0) {
                //         return Chewie(
                //           controller: ChewieController(
                //               videoPlayerController:
                //                   VideoPlayerController.network(
                //                       videoImg.contentUrl),
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
                //     }),
              )),
          Container(
            height: 77,
            margin: EdgeInsets.only(top: 9),
            width: double.infinity,
            padding: EdgeInsets.all(0),
            child: Stack(
              children: <Widget>[
                widget.praise!.praiseHeads.length > 0
                    ? PositionedImg(
                        left: 14,
                        top: 12,
                        width: 16,
                        height: 16,
                        src: widget.praise!.praiseHeads[0])
                    : Positioned(
                        child: Container(),
                      ),
                widget.praise!.praiseHeads.length > 1
                    ? PositionedImg(
                        left: 27,
                        top: 12,
                        width: 16,
                        height: 16,
                        src: widget.praise!.praiseHeads[1])
                    : Positioned(
                        child: Container(),
                      ),
                widget.praise!.praiseHeads.length == 3
                    ? PositionedImg(
                        left: 40,
                        top: 12,
                        width: 16,
                        height: 16,
                        src: widget.praise!.praiseHeads[2])
                    : Positioned(
                        child: Container(),
                      ),
                PositionedTextComponent(
                  left: 62,
                  top: 10,
                  text: "等" + widget.praise!.praiseCount.toString() + "次赞",
                  color: Color(0xff333333),
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
                PositionedImg(
                  right: 50,
                  top: 10,
                  width: 20,
                  height: 20,
                  src: (path +
                      (widget.praise!.isLike
                          ? "/like-icon.png"
                          : "/unlike-icon.png")),
                  isNetwork: false,
                ),
                PositionedImg(
                  right: 15,
                  top: 10,
                  width: 20,
                  height: 20,
                  src: path + "/gift-icon.png",
                  isNetwork: false,
                ),
                PositionedTextComponent(
                  left: 14,
                  right: 14,
                  top: 41,
                  width: double.infinity,
                  text: widget.praise!.content,
                  color: Color(0xff333333),
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                  overflow: TextOverflow.ellipsis,
                  event: () => {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context) => DynamicInfo()))
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
