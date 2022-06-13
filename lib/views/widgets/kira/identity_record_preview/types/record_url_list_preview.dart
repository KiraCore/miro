import 'package:flutter/material.dart';
import 'package:miro/infra/dto/api_kira/query_identity_records_by_address/response/record.dart';
import 'package:miro/views/widgets/generic/fake_text_field.dart';
import 'package:miro/views/widgets/kira/identity_record_preview/types/social_link_preview.dart';
import 'package:url_recognizer/url_recognizer.dart';

class RecordUrlListPreview extends StatelessWidget {
  final String label;
  final Record? record;

  const RecordUrlListPreview({
    required this.label,
    required this.record,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FakeTextField(
      label: label,
      emptyLabelStyle: const TextStyle(fontSize: 14),
      child: record == null
          ? null
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: socialUrlList.map((SocialUrl e) => SocialLinkPreview(socialUrl: e)).toList(),
            ),
    );
  }

  List<SocialUrl> get socialUrlList {
    List<SocialUrl> socials = List<SocialUrl>.empty(growable: true);
    if (record != null) {
      List<String> socialLinkStrings = (record!.value ?? '').split(',');
      for (String socialLinkString in socialLinkStrings) {
        SocialUrl socialUrl = UrlRecognizer.findObject(url: socialLinkString);
        socials.add(socialUrl);
      }
    }
    return socials;
  }
}
