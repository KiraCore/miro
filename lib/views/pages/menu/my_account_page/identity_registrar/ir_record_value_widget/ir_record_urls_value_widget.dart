import 'package:flutter/material.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/shared/controllers/browser/browser_controller.dart';
import 'package:miro/views/widgets/generic/loading_container.dart';
import 'package:miro/views/widgets/generic/mouse_state_listener.dart';
import 'package:miro/views/widgets/generic/prefixed_widget.dart';
import 'package:url_recognizer/url_recognizer.dart';

class IRRecordUrlsValueWidget extends StatelessWidget {
  final bool loadingBool;
  final String label;
  final List<String> urls;

  const IRRecordUrlsValueWidget({
    required this.loadingBool,
    required this.label,
    required this.urls,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    late Widget child;

    if (loadingBool) {
      child = const LoadingContainer(
        height: 20,
        width: 80,
        circularBorderRadius: 5,
      );
    } else if (urls.isEmpty) {
      child = const Text('---');
    } else {
      child = Column(
        children: urls.map((String e) {
          SocialUrl socialUrl = UrlRecognizer.findObject(url: e);
          return MouseStateListener(
            onTap: () => _openUrl(socialUrl),
            childBuilder: (Set<MaterialState> states) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 6),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Icon(socialUrl.icon, size: 19),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          if (socialUrl.url != socialUrl.title)
                            Text(
                              socialUrl.title,
                              overflow: TextOverflow.ellipsis,
                              style: textTheme.bodyMedium!.copyWith(color: DesignColors.white1),
                            ),
                          Text(
                            socialUrl.url,
                            overflow: TextOverflow.ellipsis,
                            style: textTheme.bodyMedium!.copyWith(color: states.contains(MaterialState.hovered) ? DesignColors.white2 : DesignColors.grey1),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        }).toList(),
      );
    }

    return PrefixedWidget(prefix: label, child: child);
  }

  void _openUrl(SocialUrl socialUrl) {
    bool phoneNumberBool = socialUrl is PhoneNumber;
    bool emailBool = socialUrl is EmailAddress;
    if (phoneNumberBool || emailBool) {
      return;
    } else {
      BrowserController.openUrl(socialUrl.url);
    }
  }
}
