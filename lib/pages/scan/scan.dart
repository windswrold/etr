import 'package:etrflying/component/custom_pageview.dart';
import 'package:scan/scan.dart';

import '../../public.dart';

class ScanCodePage extends StatefulWidget {
  ScanCodePage({Key? key, required this.onCapture}) : super(key: key);
  final Function(String) onCapture;

  @override
  _ScanCodePageState createState() => _ScanCodePageState();
}

class _ScanCodePageState extends State<ScanCodePage> {
  ScanController controller = ScanController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controller.pause();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPageView(
      hiddenScrollView: true,
      child: Container(
        child: ScanView(
          controller: controller,
          scanAreaScale: .7,
          scanLineColor: Colors.green.shade400,
          onCapture: (data) {
            print("data " + data);
            if (widget.onCapture != null) {
              Routers.goBack(context);
              widget.onCapture(data);
            }
          },
        ),
      ),
    );
  }
}
