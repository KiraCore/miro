import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jdenticon_dart/jdenticon_dart.dart';

class KiraIdentityAvatar extends StatelessWidget {
  final double size;
  final String address;

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
        padding: const EdgeInsets.all(2),
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(1000),
          child: CircleAvatar(
            backgroundColor: const Color(0xFF2B2F78),
            child: SizedBox(
              width: size - size * 0.25,
              height: size - size * 0.25,
              child: SvgPicture.string(
                Jdenticon.toSvg(address),
                fit: BoxFit.contain,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
