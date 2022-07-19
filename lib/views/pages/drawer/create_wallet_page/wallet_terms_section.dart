import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:miro/config/theme/design_colors.dart';

class WalletTermsSection extends StatefulWidget {
  final void Function(bool value) onChanged;
  final bool checked;

  const WalletTermsSection({
    required this.onChanged,
    required this.checked,
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _WalletTermsSection();
}

class _WalletTermsSection extends State<WalletTermsSection> {
  ValueNotifier<bool> termsAcceptedNotifier = ValueNotifier<bool>(false);

  @override
  void didUpdateWidget(covariant WalletTermsSection oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.checked != widget.checked) {
      termsAcceptedNotifier.value = widget.checked;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const SizedBox(height: 20),
        Row(
          children: <Widget>[
            ValueListenableBuilder<bool>(
              valueListenable: termsAcceptedNotifier,
              builder: (_, bool termsChecked, __) {
                return SizedBox(
                  width: 40,
                  child: Checkbox(
                    value: termsChecked,
                    activeColor: DesignColors.blue2_100,
                    checkColor: DesignColors.gray3_100,
                    onChanged: _onCheckboxValueChanged,
                  ),
                );
              },
            ),
            const Expanded(
              child: SizedBox(
                child: Text(
                  'I understand that if I loose seed phrases or private key I will loose access to account forever.',
                  style: TextStyle(
                    fontSize: 12,
                    color: DesignColors.gray2_100,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  void _onCheckboxValueChanged(bool? state) {
    termsAcceptedNotifier.value = !termsAcceptedNotifier.value;
    widget.onChanged(termsAcceptedNotifier.value);
  }
}
