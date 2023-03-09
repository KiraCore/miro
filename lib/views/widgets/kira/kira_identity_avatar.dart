import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jdenticon_dart/jdenticon_dart.dart';
import 'package:miro/config/theme/design_colors.dart';

class KiraIdentityAvatar extends StatelessWidget {
  final String? address;
  final double size;

  const KiraIdentityAvatar({
    required this.address,
    required this.size,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(500),
      child: Container(
        width: size,
        height: size,
        padding: const EdgeInsets.all(1),
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: DesignColors.grey2,
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(1000),
          child: CircleAvatar(
            backgroundColor: DesignColors.avatar,
            child: Padding(
              padding: EdgeInsets.all(size - size * 0.85),
              child: address != null && address!.isNotEmpty
                  ? SvgPicture.string(
                      Jdenticon.toSvg(address!),
                      fit: BoxFit.contain,
                    )
                  : null,
            ),
          ),
        ),
      ),
    );
  }
}
