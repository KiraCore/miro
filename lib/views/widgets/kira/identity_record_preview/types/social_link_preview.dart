import 'package:flutter/material.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/shared/utils/app_logger.dart';
import 'package:miro/views/widgets/generic/mouse_state_listener.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_recognizer/url_recognizer.dart';

class SocialLinkPreview extends StatelessWidget {
  final SocialUrl socialUrl;

  const SocialLinkPreview({
    required this.socialUrl,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MouseStateListener(
      disableSplash: true,
      onTap: _openSocialLink,
      childBuilder: (Set<MaterialState> states) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 3),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SizedBox(
                width: 20,
                height: 20,
                child: Center(
                  child: Icon(
                    socialUrl.icon,
                    color: DesignColors.gray2_100,
                    size: 18,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  socialUrl.title,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 16,
                    color: states.contains(MaterialState.hovered) ? DesignColors.blue1_100 : DesignColors.white_100,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _openSocialLink() async {
    Uri uriToOpen = Uri.parse(socialUrl.url);
    if (!await launchUrl(uriToOpen)) {
      AppLogger().log(message: 'Could not launch $socialUrl.url');
    }
  }
}
