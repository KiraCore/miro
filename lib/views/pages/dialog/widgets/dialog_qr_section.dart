import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:miro/config/app_icons.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/views/widgets/buttons/kira_outlined_button.dart';
import 'package:miro/views/widgets/generic/center_load_spinner.dart';
import 'package:miro/views/widgets/generic/expandable_section_tile.dart';
import 'package:miro/views/widgets/generic/responsive/responsive_widget.dart';
import 'package:miro/views/widgets/kira/kira_qr_code.dart';
import 'package:miro/views/widgets/kira/kira_toast.dart';

class DialogQrSectionController {
  VoidCallback? copy;
  VoidCallback? download;

  void _setUpController({
    required VoidCallback copy,
    required VoidCallback download,
  }) {
    this.copy = copy;
    this.download = download;
  }
}

class DialogQrSection extends StatefulWidget {
  final DialogQrSectionController? controller;
  final Map<String, dynamic> qrData;
  final bool showActionButtons;

  const DialogQrSection({
    required this.qrData,
    this.controller,
    this.showActionButtons = true,
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _DialogQrSection();
}

class _DialogQrSection extends State<DialogQrSection> {
  final ValueNotifier<bool> _downloadingNotifier = ValueNotifier<bool>(false);

  @override
  void initState() {
    if (widget.controller != null) {
      widget.controller!._setUpController(
        copy: _copyQrCode,
        download: _downloadQrCode,
      );
    }
    super.initState();
  }

  bool get hasMarginDesktop {
    return widget.showActionButtons && !ResponsiveWidget.isSmallScreen(context);
  }

  bool get hasMarginMobile {
    return widget.showActionButtons && ResponsiveWidget.isSmallScreen(context);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          height: 276,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: DesignColors.gray1_100,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              if (hasMarginDesktop) const Spacer(),
              Expanded(
                flex: 3,
                child: LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        width: constraints.maxHeight,
                        height: constraints.maxHeight,
                        child: KiraQrCode(
                          size: constraints.maxHeight,
                          data: _getQrCodeData(),
                        ),
                      ),
                    ],
                  );
                }),
              ),
              if (hasMarginDesktop)
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      ValueListenableBuilder<bool>(
                        valueListenable: _downloadingNotifier,
                        builder: (_, bool value, __) => value
                            ? const SizedBox(width: 24, height: 24, child: CenterLoadSpinner(size: 10))
                            : MouseRegion(
                                cursor: SystemMouseCursors.click,
                                child: GestureDetector(
                                  onTap: _downloadQrCode,
                                  child: const Icon(
                                    AppIcons.share,
                                    color: DesignColors.gray2_100,
                                  ),
                                ),
                              ),
                      ),
                      const SizedBox(width: 10),
                      MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: GestureDetector(
                          onTap: _copyQrCode,
                          child: const Icon(
                            AppIcons.copy,
                            color: DesignColors.gray2_100,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
            ],
          ),
        ),
        if (hasMarginMobile) ...<Widget>[
          const SizedBox(height: 20),
          ExpandableSectionTile(
            title: 'Advanced options',
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  children: <Widget>[
                    KiraOutlinedButton(
                      onPressed: _downloadQrCode,
                      title: 'Download QR',
                    ),
                    const SizedBox(height: 10),
                    KiraOutlinedButton(
                      onPressed: _copyQrCode,
                      title: 'Copy QR as plain text',
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ],
    );
  }

  void _copyQrCode() {
    Clipboard.setData(
      ClipboardData(
        text: _getQrCodeData(),
      ),
    );
    KiraToast.show('Copied!');
  }

  Future<void> _downloadQrCode() async {}

  String _getQrCodeData() {
    return jsonEncode(widget.qrData);
  }
}
