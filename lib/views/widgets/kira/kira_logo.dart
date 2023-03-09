import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';
import 'package:miro/generated/assets.dart';

class KiraLogo extends StatelessWidget {
  final double? width;
  final double? height;

  const KiraLogo({Key? key, this.width, this.height}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      Assets.assetsLogoLight,
      height: height,
      width: width,
    );
  }
}
