import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/views/widgets/generic/jdenticon_gravatar.dart';

class UrlAvatarWidget extends StatelessWidget {
  final double size;
  final String address;
  final String url;

  const UrlAvatarWidget({
    required this.size,
    required this.address,
    required this.url,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double primaryAvatarSize = size;
    double secondaryAvatarSize = size * 0.5;

    Widget primaryAvatarWidget = ClipRRect(
      borderRadius: BorderRadius.circular(1000),
      child: CachedNetworkImage(
        imageUrl: url,
        fit: BoxFit.cover,
        errorWidget: (BuildContext context, String url, Object error) {
          return SvgPicture.network(url, fit: BoxFit.cover);
        },
      ),
    );

    Widget secondaryAvatarWidget = JdenticonGravatar(
      address: address,
      size: secondaryAvatarSize,
    );

    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        children: <Widget>[
          Positioned.fill(
            child: Container(
              width: primaryAvatarSize,
              height: primaryAvatarSize,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: DesignColors.grey2,
              ),
              margin: EdgeInsets.only(right: size * 0.06, bottom: size * 0.06),
              child: primaryAvatarWidget,
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: secondaryAvatarWidget,
          ),
        ],
      ),
    );
  }
}
