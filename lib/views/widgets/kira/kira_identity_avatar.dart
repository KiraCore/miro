import 'package:flutter/material.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/views/widgets/generic/jdenticon_gravatar.dart';
import 'package:miro/views/widgets/generic/url_avatar_widget.dart';
import 'package:shimmer/shimmer.dart';

class KiraIdentityAvatar extends StatefulWidget {
  final double size;
  final bool loadingBool;
  final String? address;
  final String? avatarUrl;

  const KiraIdentityAvatar({
    required this.size,
    this.loadingBool = false,
    this.address,
    this.avatarUrl,
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _KiraIdentityAvatarState();
  }
}

class _KiraIdentityAvatarState extends State<KiraIdentityAvatar> {
  @override
  Widget build(BuildContext context) {
    if (widget.loadingBool) {
      return ClipOval(
        child: Shimmer.fromColors(
          baseColor: DesignColors.grey3,
          highlightColor: DesignColors.grey2,
          child: Container(
            width: widget.size,
            height: widget.size,
            color: DesignColors.grey2,
          ),
        ),
      );
    } else if (widget.address == null) {
      return Container(
        height: widget.size,
        width: widget.size,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: DesignColors.grey2,
        ),
      );
    } else if (widget.avatarUrl == null) {
      return SizedBox(
        height: widget.size,
        width: widget.size,
        child: JdenticonGravatar(
          address: widget.address!,
          size: widget.size,
        ),
      );
    } else {
      return UrlAvatarWidget(
        address: widget.address!,
        url: widget.avatarUrl!,
        size: widget.size,
      );
    }
  }
}
