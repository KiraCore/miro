import 'package:flutter/material.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/infra/dto/api_kira/query_identity_records_by_address/response/record.dart';
import 'package:miro/shared/utils/app_logger.dart';
import 'package:miro/views/widgets/generic/fake_text_field.dart';
import 'package:miro/views/widgets/generic/mouse_state_listener.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_recognizer/url_recognizer.dart';

enum IdentityPreviewType {
  singleText,
  socialList,
  image,
}

class IdentityRegistrarPreview extends StatelessWidget {
  final String label;
  final Record? record;
  final IdentityPreviewType identityPreviewType;

  const IdentityRegistrarPreview({
    required this.label,
    required this.record,
    required this.identityPreviewType,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    switch (identityPreviewType) {
      case IdentityPreviewType.socialList:
        return IdentityRegistrarSocialsPreview(label: label, record: record);
      case IdentityPreviewType.image:
        return _ImageLinkPreview(label: label, record: record);
      default:
        return IdentityRegistrarSingleTextPreview(label: label, record: record);
    }
  }
}

class IdentityRegistrarSingleTextPreview extends StatelessWidget {
  final String label;
  final Record? record;

  const IdentityRegistrarSingleTextPreview({
    required this.label,
    required this.record,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FakeTextField(
      label: label,
      emptyLabelStyle: const TextStyle(fontSize: 14),
      child: record != null
          ? SizedBox(
              width: double.infinity,
              child: Text(
                record!.value,
                style: const TextStyle(fontSize: 16),
              ),
            )
          : null,
    );
  }
}

class IdentityRegistrarSocialsPreview extends StatelessWidget {
  final String label;
  final Record? record;

  const IdentityRegistrarSocialsPreview({
    required this.label,
    required this.record,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<SocialUrl> socials = List<SocialUrl>.empty(growable: true);
    if (record != null) {
      List<String> socialLinkStrings = record!.value.split(',');
      for (String socialLinkString in socialLinkStrings) {
        /// Remove curly branches from the link
        String parsedSocialLink = socialLinkString.substring(1, socialLinkString.length - 1);
        SocialUrl socialUrl = UrlRecognizer.findObject(url: parsedSocialLink);
        socials.add(socialUrl);
      }
    }

    return FakeTextField(
      label: label,
      emptyLabelStyle: const TextStyle(fontSize: 14),
      child: record == null
          ? null
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: socials.map((SocialUrl e) => _SocialLinkPreview(socialUrl: e)).toList(),
            ),
    );
  }
}

class _SocialLinkPreview extends StatelessWidget {
  final SocialUrl socialUrl;

  const _SocialLinkPreview({
    required this.socialUrl,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MouseStateListener(
      disableSplash: true,
      onTap: () async {
        Uri uriToOpen = Uri.parse(socialUrl.url);
        if (!await launchUrl(uriToOpen)) {
          AppLogger().log(message: 'Could not launch $socialUrl.url');
        }
      },
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
              Text(
                socialUrl.title,
                style: TextStyle(
                  fontSize: 16,
                  color: states.contains(MaterialState.hovered) ? DesignColors.blue1_100 : DesignColors.white_100,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _ImageLinkPreview extends StatelessWidget {
  final String label;
  final Record? record;

  const _ImageLinkPreview({
    required this.label,
    this.record,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FakeTextField(
      label: label,
      emptyLabelStyle: const TextStyle(fontSize: 14),
      child: record == null
          ? null
          : Image.network(
              record!.value,
              width: 100,
            ),
    );
  }
}
