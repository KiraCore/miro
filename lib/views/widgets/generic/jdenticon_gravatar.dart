import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jdenticon_dart/jdenticon_dart.dart';
import 'package:miro/config/theme/design_colors.dart';

class JdenticonGravatar extends StatelessWidget {
  final double size;
  final String address;

  const JdenticonGravatar({
    required this.size,
    required this.address,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      padding: EdgeInsets.all(size - size * 0.85),
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: DesignColors.grey2,
      ),
      child: SvgPicture.string(
        Jdenticon.toSvg(address),
        fit: BoxFit.contain,
      ),
    );
  }
}
