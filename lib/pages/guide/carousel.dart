import 'package:etrflying/component/custom_pageview.dart';
import 'package:etrflying/component/positioned-text-component.dart';
import 'package:etrflying/pages/tabbar/tabbar.dart';

import '../../public.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_swiper/flutter_swiper.dart';

class Carousel extends StatefulWidget {
  CarouselState createState() => CarouselState();
}

class CarouselState extends State<Carousel> {
  bool showButton = false;
  int currentIndex = 0;
  List<Widget> slides = [];

  List<Widget> buildWidget() {
    slides.clear();
    slides.add(_swiperBuilder(context, 0));
    slides.add(_swiperBuilder(context, 1));
    slides.add(_swiperBuilder(context, 2));
    return slides;
  }

  void onDonePress() {
    print("onDonePress");
    Provider.of<CurrentChooseWalletState>(context, listen: false).loadWallet();
    Routers.push(context, HomeTabbar(), clearStack: true);
  }

  Widget _buildPoint() {
    return Container(
      width: 54.w,
      height: 9.w,
      alignment: Alignment.center,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(slides.length, (int index) {
          return _pointWidget(index);
        }).toList(),
      ),
    );
  }

  Widget _pointWidget(int index) {
    return currentIndex == index
        ? Container(
            width: 22.w,
            height: 9.w,
            decoration: BoxDecoration(
                color: ColorUtil.rgba(172, 126, 255, 1),
                borderRadius: BorderRadius.all(
                  Radius.circular(4),
                )),
          )
        : Container(
            width: 8.w,
            height: 8.w,
            decoration: BoxDecoration(
                color: ColorUtil.rgba(150, 90, 209, 1),
                borderRadius: BorderRadius.all(
                  Radius.circular(4),
                )),
          );
  }

  @override
  Widget build(BuildContext context) {
    return CustomPageView(
      hiddenAppBar: true,
      hiddenScrollView: true,
      child: Stack(
        children: [
          PageView(
            onPageChanged: (value) {
              setState(() {
                currentIndex = value;
              });
            },
            children: buildWidget(),
            // pageSnapping: false,
          ),
          Positioned(
            right: 14.w,
            top: 15.w,
            child: GestureDetector(
                onTap: () {
                  onDonePress();
                },
                child: LoadAssetsImage(
                  "guide/jump.png",
                  width: 52.w,
                  height: 24.w,
                )),
          ),
          Positioned(
              left: (ScreenUtil().screenWidth - 54.w) / 2,
              bottom: 105.h,
              child: _buildPoint()),
        ],
      ),
    );
  }

  Widget _swiperBuilder(BuildContext context, int index) {
    String path = "assets/img/guide";
    List<Widget> widgets = [];
    widgets.add(Positioned(
        left: 18.w,
        right: 18.w,
        top: 56.h,
        child: Container(
          width: double.infinity,
          height: 360.w,
          child: index == 0
              ? Image.asset(path + "/swiper-one.png")
              : index == 1
                  ? Image.asset(path + "/swiper-two.png")
                  : Image.asset(path + "/swiper-three.png"),
        )));

    if (index == 2) {
      widgets.add(
        Positioned(
            bottom: 125.h,
            left: 40.w,
            right: 40.w,
            child: TRButton(
              onTap: () => {
                onDonePress(),
              },
              text: "开启",
              height: 43.w,
              borderRadius: 22,
              bgc: ColorUtil.rgba(156, 108, 255, 1),
              textStyle: TextStyle(
                color: Colors.white,
                fontSize: 16.sp,
                fontWeight: FontWeightHelper.semiBold,
              ),
            )),
      );
    }

    return Stack(children: widgets);
  }
}
