import 'package:etrflying/component/positioned-img.dart';
import 'package:etrflying/component/positioned-swiper.dart';
import 'package:etrflying/component/positioned-text-component.dart';
import 'package:etrflying/component/router-back.dart';
import 'package:etrflying/model/praise.dart';
import 'package:flutter/material.dart';

class PersonDynamic extends StatefulWidget {
  PersonDynamicState createState() => PersonDynamicState();
}

class PersonDynamicState extends State<PersonDynamic> {
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
        true),
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
        true),
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
        true),
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
        true),
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
        true),
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
  String path = "assets/img/home";

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: ListView(
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        children: <Widget>[
          Container(
            height: 480,
            child: Stack(
              children: <Widget>[
                praises == null
                    ? Positioned(
                        left: 0,
                        right: 0,
                        top: 0,
                        child: Container(
                          child: Image.asset(
                            path + "/default-list-icon.png",
                            fit: BoxFit.cover,
                          ),
                          width: double.infinity,
                          height: 281,
                        ),
                      )
                    : PositionedSwiper(
                        top: 0,
                        left: 0,
                        right: 0,
                        width: double.infinity,
                        height: 280,
                        videos: praises[0].videos,
                      ),
                BackComponet(),
                //背景白色
                Positioned(
                  top: 260,
                  left: 0,
                  right: 0,
                  child: Container(
                    width: double.infinity,
                    height: 176,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: new BorderRadius.circular(20)),
                  ),
                ),
                //头像
                PositionedImg(
                    left: 14, top: 215, width: 84, height: 84, src: headUrl),
                //昵称
                PositionedTextComponent(
                  left: 13,
                  right: 97,
                  top: 323,
                  width: double.infinity,
                  text: "昵称",
                  color: Color(0xff333333),
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                //ID
                PositionedTextComponent(
                  left: 14,
                  right: 0,
                  top: 363,
                  width: double.infinity,
                  text: "ID：JSAJFOAFASJ",
                  color: Color(0xff999999),
                  fontSize: 12,
                ),
                //签名
                PositionedTextComponent(
                  left: 14,
                  right: 0,
                  top: 384,
                  width: double.infinity,
                  text: "浪漫至死不渝，暖心艳阳天",
                  color: Color(0xff333333),
                  fontSize: 12,
                ),
                //介绍
                PositionedTextComponent(
                  left: 14,
                  right: 0,
                  top: 407,
                  width: double.infinity,
                  text: "女 | 18岁 | 160cm | 广东 深圳 ",
                  color: Color(0xff333333),
                  fontSize: 12,
                ),
                Positioned(
                  right: 2,
                  top: 311,
                  child: Container(
                    width: 95,
                    height: 58,
                    child: Image.asset(path + "/invite-icon.png",fit: BoxFit.cover,),
                  ),

                ),
                Positioned(
                  top: 436,
                  left: 0,
                  right: 0,
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(
                                width: 1, color: Color(0xffD8D8D8)))),
                  ),
                ),
                Positioned(
                  left: 15,
                  top:463,
                  child: Container(
                    width: 30,
                    height: 8,
                    decoration: ShapeDecoration(color: Color(0xff9C6CFF).withOpacity(0.32),shape: RoundedRectangleBorder(
                      borderRadius: BorderRadiusDirectional.only(
                        topStart: Radius.circular(100),
                        bottomStart: Radius.circular(24),

                      ),
                    )),

                  ),
                ),
                PositionedTextComponent(
                  left: 14,
                  right: 0,
                  top: 449,
                  width: double.infinity,
                  text: "动态",
                  color: Color(0xff333333),
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ],
            ),
          ),
          //个人动态
          praises == null ? Container() : ListView(
            shrinkWrap: true,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top:12),
                width: double.infinity,
                height: 147,
                child: Stack(
                  children: <Widget>[
                    PositionedTextComponent(left: 14,width: 70,height: 33,backgroundColor: Colors.red,text:""),
                    Positioned(
                      top: 45,
                      left: 26,
                      child: Container(
                        width: 1,
                        height: 102,
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                                    width: 102, color: Color(0xffE3E3E3)))),
                      ),
                    ),

                  ],
                ),
              )
            ],
          ),
          praises == null
              ? Container(
                  child: Image.asset(
                    path + "/default-background-icon.png",
                    fit: BoxFit.cover,
                  ),
                  padding: EdgeInsets.only(left: 83, right: 83),
                  margin: EdgeInsets.only(top: 73, bottom: 24),
                )
              : Container(),
          praises == null
              ? Container(
                  child: Text(
                    "还未发布动态",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xffC0C0C0),
                      fontSize: 12,
                      decoration: TextDecoration.none,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  height: 17,
                  width: double.infinity,
                  margin: EdgeInsets.only(bottom: 80),
                )
              : Container()
        ],
      ),
    );
    ;
  }
}
