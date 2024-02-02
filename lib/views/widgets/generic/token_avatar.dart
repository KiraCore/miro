import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:miro/config/app_config.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/generated/assets.dart';
import 'package:miro/shared/controllers/browser/browser_url_controller.dart';
import 'package:miro/shared/utils/network_utils.dart';

class TokenAvatar extends StatelessWidget {
  final double size;
  final String? iconUrl;
  final AppConfig _appConfig = globalLocator<AppConfig>();

  TokenAvatar({
    required this.size,
    this.iconUrl = '',
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Uri? proxyServerUri = _appConfig.proxyServerUri;
    bool proxyActiveBool = iconUrl != null &&
        NetworkUtils.shouldUseProxy(
          serverUri: Uri.parse(iconUrl!),
          proxyServerUri: proxyServerUri,
          appUri: const BrowserUrlController().uri,
        );
    String networkUri = proxyActiveBool ? '${proxyServerUri}/${iconUrl.toString()}' : iconUrl ?? '';
    bool svgBool = networkUri.endsWith('.svg');

    Widget placeholderWidget = Padding(
      padding: EdgeInsets.all(size - size * 0.75),
      child: Image.asset(Assets.assetsLogoSignet),
    );

    Widget imageWidget;
    if (iconUrl == null || iconUrl!.isEmpty) {
      imageWidget = placeholderWidget;
    }
    if (svgBool) {
      imageWidget = SvgPicture.network(
        networkUri,
        placeholderBuilder: (_) => placeholderWidget,
      );
    } else {
      imageWidget = CachedNetworkImage(
        imageUrl: networkUri,
        errorWidget: (_, __, ___) => placeholderWidget,
      );
    }

    return Container(
      width: size,
      height: size,
      padding: const EdgeInsets.all(1),
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: DesignColors.grey3,
      ),
      child: CircleAvatar(
        backgroundColor: DesignColors.background,
        radius: size / 2,
        child: imageWidget,
      ),
    );
  }
}