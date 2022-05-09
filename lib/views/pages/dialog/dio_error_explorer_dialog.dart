import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/views/pages/dialog/widgets/dialog_card.dart';
import 'package:miro/views/pages/dialog/widgets/json_preview.dart';
import 'package:miro/views/widgets/buttons/kira_outlined_button.dart';

class DioErrorExplorerDialog extends StatelessWidget {
  final DioError dioError;

  const DioErrorExplorerDialog({
    required this.dioError,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: DesignColors.gray1_100,
      child: DialogCard(
        width: 800,
        title: 'Error explorer',
        child: Column(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: DesignColors.gray1_100,
              ),
              child: Row(
                children: <Widget>[
                  SizedBox(
                    width: 50,
                    child: Text(
                      dioError.requestOptions.method,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: SelectableText(
                      '${dioError.requestOptions.uri}',
                      style: const TextStyle(),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Row(
              children: <Widget>[
                Expanded(
                  child: _RequestResponsePreview(
                    title: 'Request',
                    data: dioError.requestOptions.data,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _RequestResponsePreview(
                    title: 'Response',
                    subtitle:
                        '${dioError.response?.statusCode} ${dioError.response?.statusMessage?.toUpperCase().replaceAll(' ', '_')}',
                    data: dioError.response?.data ?? dioError.message,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                KiraOutlinedButton(
                  width: 80,
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  title: 'Close',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _RequestResponsePreview extends StatelessWidget {
  final String title;
  final dynamic data;
  final String? subtitle;

  const _RequestResponsePreview({
    required this.title,
    this.data,
    this.subtitle,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        JsonPreview(
          height: 300,
          value: data,
          subtitle: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Text(
                subtitle ?? '',
                style: const TextStyle(
                  color: DesignColors.red_100,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
