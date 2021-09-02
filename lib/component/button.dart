import '../public.dart';

class TRButton extends StatelessWidget {
  const TRButton({
    Key? key,
    this.onTap,
    this.bgc,
    this.text,
    this.textStyle,
    this.borderRadius,
    this.height,
    this.padding,
    this.border,
    this.width,
    this.gradient = const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Color(0XFFFF80E3),
          Color(0XFF9855F8),
        ]),
    this.margin,
  }) : super(key: key);
  final VoidCallback? onTap;
  final Color? bgc;
  final String? text;
  final TextStyle? textStyle;
  final double? borderRadius;
  final double? height;
  final double? width;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;

  final BoxBorder? border;
  final Gradient? gradient;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Container(
        color: borderRadius == null ? bgc : null,
        height: height,
        padding: padding,
        margin: margin,
        width: width,
        alignment: Alignment.center,
        decoration: borderRadius == null
            ? null
            : BoxDecoration(
                color: bgc,
                borderRadius: BorderRadius.circular(borderRadius!),
                border: border,
                gradient: gradient,
              ),
        child: Text(text ?? "", textAlign: TextAlign.center, style: textStyle),
      ),
    );
  }
}
