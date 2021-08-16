import '../public.dart';

class EmptyDataPage extends StatefulWidget {
  EmptyDataPage({Key? key, this.refreshAction}) : super(key: key);

  final Function()? refreshAction;

  @override
  _EmptyDataPageState createState() => _EmptyDataPageState();
}

class _EmptyDataPageState extends State<EmptyDataPage> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => {},
      child: Container(
        alignment: Alignment.center,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              child: LoadAssetsImage(
                "home/icon_empty.png",
                width: 209.w,
                fit: BoxFit.cover,
              ),
            ),
            24.columnOffset(),
            Text("暂无记录",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: ColorUtil.rgba(153, 153, 153, 1),
                  fontSize: 12.sp,
                  fontWeight: FontWeightHelper.regular,
                )),
          ],
        ),
      ),
    );
  }
}
