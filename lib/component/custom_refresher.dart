import 'package:flutter/cupertino.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../public.dart';

class CustomRefresher extends StatelessWidget {
  CustomRefresher({
    Key? key,
    required this.child,
    required this.refreshController,
    this.idle,
    this.loading,
    this.failed,
    this.canLoading,
    this.noData,
    this.onLoading,
    this.onRefresh,
    this.enableHeader = true,
    this.enableFooter = true,
  }) : super(key: key);

  final Widget child;
  Widget? idle;
  Widget? loading;
  Widget? failed;
  Widget? canLoading;
  Widget? noData;
  final VoidCallback? onRefresh;
  final VoidCallback? onLoading;
  final RefreshController refreshController;
  bool enableHeader;
  bool enableFooter;

  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
      enablePullDown: enableHeader,
      enablePullUp: enableFooter,
      header: CustomHeader(
        builder: (BuildContext context, RefreshStatus? mode) {
          Widget? body;
          if (mode == RefreshStatus.idle) {
            body = Text('下拉刷新数据', style: TextStyle(color: Colors.black));
          } else if (mode == RefreshStatus.canRefresh) {
            body = Text('松开即可刷新数据', style: TextStyle(color: Colors.black));
          } else if (mode == RefreshStatus.refreshing) {
            body = Text('刷新数据中', style: TextStyle(color: Colors.black));
          } else if (mode == RefreshStatus.completed) {
            body = Text('加载完成', style: TextStyle(color: Colors.black));
          } else {}
          return Container(
              height: 55.0,
              child: Center(child: body),
              color: Colors.transparent);
        },
      ),
      footer: CustomFooter(
        builder: (BuildContext context, LoadStatus? mode) {
          Widget body;
          if (mode == LoadStatus.idle) {
            body = this.idle ??=
                Text('上拉加载数据', style: TextStyle(color: Colors.black));
          } else if (mode == LoadStatus.loading) {
            body = this.loading ??=
                Text('刷新数据中', style: TextStyle(color: Colors.black));
          } else if (mode == LoadStatus.failed) {
            body = this.failed ??=
                Text('加载失败！点击重试！', style: TextStyle(color: Colors.black));
          } else if (mode == LoadStatus.canLoading) {
            body = this.canLoading ??=
                Text('松手,加载更多', style: TextStyle(color: Colors.black));
          } else {
            body = this.noData ??=
                Text('没有更多数据了', style: TextStyle(color: Colors.black));
          }
          return Container(
            height: 55.0,
            color: Colors.transparent,
            child: Center(child: body),
          );
        },
      ),
      controller: this.refreshController,
      onRefresh: this.onRefresh,
      onLoading: this.onLoading,
      child: child,
    );
  }
}
