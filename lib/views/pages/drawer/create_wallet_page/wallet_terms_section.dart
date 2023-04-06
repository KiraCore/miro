import 'package:flutter/material.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/generated/l10n.dart';
import 'package:miro/views/widgets/kira/kira_checkbox.dart';

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
    TextTheme textTheme = Theme.of(context).textTheme;

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
                  child: KiraCheckbox(
                    size: 28,
                    value: termsChecked,
                    onChanged: _onCheckboxValueChanged,
                  ),
                );
              },
            ),
            Expanded(
              child: SizedBox(
                child: Text(
                  S.of(context).createWalletAcknowledgement,
                  style: textTheme.caption!.copyWith(
                    color: DesignColors.white1,
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
