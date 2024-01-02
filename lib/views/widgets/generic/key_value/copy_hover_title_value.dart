import 'package:flutter/material.dart';
import 'package:miro/views/widgets/generic/key_value/copy_hover_value.dart';
import 'package:miro/views/widgets/generic/key_value/detail_title.dart';

class CopyHoverTitleValue extends StatelessWidget {
  const CopyHoverTitleValue({required this.title, required this.value, super.key});

  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        DetailTitle(title),
        const SizedBox(height: 4),
        CopyHoverValue(value: value),
      ],
    );
  }
}
