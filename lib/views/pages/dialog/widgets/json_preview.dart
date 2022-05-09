import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:miro/config/app_icons.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/views/widgets/generic/mouse_state_listener.dart';
import 'package:miro/views/widgets/kira/kira_toast.dart';

class JsonPreview extends StatelessWidget {
  final dynamic value;
  final double height;
  final Widget? subtitle;
  final bool allowCopy;

  const JsonPreview({
    required this.value,
    this.height = 172,
    this.subtitle,
    this.allowCopy = true,
    Key? key,
  }) : super(key: key);

  String get decoratedValue {
    JsonEncoder encoder = const JsonEncoder.withIndent('  ');
    String prettyJson = value.toString();
    try {
      prettyJson = encoder.convert(value);
    } catch (e) {
      // Do nothing
    }
    return prettyJson;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        color: DesignColors.gray1_100,
      ),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: <Widget>[
              SizedBox(
                height: height,
                child: MouseStateListener(
                  onTap: () {},
                  childBuilder: (Set<MaterialState> states) {
                    return Stack(
                      children: <Widget>[
                        Positioned.fill(
                          child: SelectableText(
                            decoratedValue,
                            style: const TextStyle(
                              fontSize: 14,
                              color: DesignColors.gray2_100,
                            ),
                          ),
                        ),
                        if (allowCopy && states.contains(MaterialState.hovered))
                          Positioned(
                            top: 0,
                            right: 0,
                            child: _CopyButton(
                              value: decoratedValue,
                            ),
                          ),
                      ],
                    );
                  },
                ),
              ),
              const SizedBox(height: 8),
              if (subtitle != null) subtitle!,
            ],
          ),
        ),
      ),
    );
  }
}

class _CopyButton extends StatelessWidget {
  final String value;

  const _CopyButton({
    required this.value,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      icon: const Icon(
        AppIcons.copy,
        color: DesignColors.white_100,
        size: 16,
      ),
      label: const Text(
        'Copy',
        style: TextStyle(color: DesignColors.white_100, fontSize: 11),
      ),
      onPressed: () {
        Clipboard.setData(ClipboardData(text: value));
        KiraToast.show('Copied!');
      },
    );
  }
}
