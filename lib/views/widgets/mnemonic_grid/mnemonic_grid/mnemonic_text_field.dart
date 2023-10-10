import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miro/blocs/widgets/mnemonic_grid/hint/mnemonic_hint_cubit.dart';
import 'package:miro/blocs/widgets/mnemonic_grid/hint/mnemonic_hint_state.dart';
import 'package:miro/blocs/widgets/mnemonic_grid/text_field/mnemonic_text_field_cubit.dart';
import 'package:miro/blocs/widgets/mnemonic_grid/text_field/mnemonic_text_field_state.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/shared/models/wallet/mnemonic_text_field_status.dart';
import 'package:miro/views/widgets/mnemonic_grid/mnemonic_grid/mnemonic_text_field_layers_wrapper.dart';

class MnemonicTextField extends StatefulWidget {
  final MnemonicTextFieldCubit mnemonicTextFieldCubit;

  const MnemonicTextField({
    required this.mnemonicTextFieldCubit,
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MnemonicTextField();
}

class _MnemonicTextField extends State<MnemonicTextField> {
  final FocusNode focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    widget.mnemonicTextFieldCubit.focusNode = focusNode;
    focusNode.addListener(_changeFocusNode);
  }

  @override
  void dispose() {
    widget.mnemonicTextFieldCubit.focusNode = null;
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return BlocBuilder<MnemonicTextFieldCubit, MnemonicTextFieldState>(
      bloc: widget.mnemonicTextFieldCubit,
      builder: (BuildContext context, MnemonicTextFieldState mnemonicTextFieldState) {
        return MnemonicTextFieldLayersWrapper(
          mnemonicTextFieldCubit: widget.mnemonicTextFieldCubit,
          mnemonicTextFieldStatus: mnemonicTextFieldState.mnemonicTextFieldStatus,
          prefixWidget: Text(
            '${widget.mnemonicTextFieldCubit.index + 1}',
            textAlign: TextAlign.center,
            style: textTheme.bodySmall!.copyWith(
              color: mnemonicTextFieldState.mnemonicTextFieldStatus == MnemonicTextFieldStatus.valid
                  ? DesignColors.greenStatus1
                  : DesignColors.white2,
            ),
          ),
          hintWidget: BlocBuilder<MnemonicHintCubit, MnemonicHintState>(
            bloc: widget.mnemonicTextFieldCubit.mnemonicHintCubit,
            builder: (BuildContext context, MnemonicHintState mnemonicHintState) {
              return RichText(
                text: TextSpan(
                  text: mnemonicTextFieldState.mnemonicText,
                  style: textTheme.bodySmall!.copyWith(
                    letterSpacing: 3,
                    color: Colors.transparent,
                  ),
                  children: <TextSpan>[
                    TextSpan(
                      text: mnemonicHintState.hintText,
                      style: textTheme.bodySmall!.copyWith(
                        letterSpacing: 3,
                        color: DesignColors.white2,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
          editableWidget: EditableText(
            controller: widget.mnemonicTextFieldCubit.textEditingController,
            focusNode: focusNode,
            cursorColor: DesignColors.white1,
            backgroundCursorColor: DesignColors.white1,
            onSubmitted: (_) => widget.mnemonicTextFieldCubit.acceptHint(),
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.allow(RegExp('[a-z]')),
              LengthLimitingTextInputFormatter(8),
            ],
            style: textTheme.bodySmall!.copyWith(
              letterSpacing: 3,
              color: DesignColors.white1,
            ),
          ),
        );
      },
    );
  }

  void _changeFocusNode() {
    widget.mnemonicTextFieldCubit.changeFocus(textFieldFocusedBool: focusNode.hasFocus);
  }
}
