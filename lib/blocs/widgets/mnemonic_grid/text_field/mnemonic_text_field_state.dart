import 'package:equatable/equatable.dart';
import 'package:miro/shared/models/wallet/mnemonic/mnemonic_text_field_status.dart';

class MnemonicTextFieldState extends Equatable {
  final String mnemonicText;
  final MnemonicTextFieldStatus mnemonicTextFieldStatus;

  const MnemonicTextFieldState({
    required this.mnemonicText,
    required this.mnemonicTextFieldStatus,
  });

  const MnemonicTextFieldState.empty()
      : mnemonicTextFieldStatus = MnemonicTextFieldStatus.empty,
        mnemonicText = '';

  MnemonicTextFieldState copyWith({
    String? mnemonicText,
    MnemonicTextFieldStatus? mnemonicTextFieldStatus,
  }) {
    return MnemonicTextFieldState(
      mnemonicText: mnemonicText ?? this.mnemonicText,
      mnemonicTextFieldStatus: mnemonicTextFieldStatus ?? this.mnemonicTextFieldStatus,
    );
  }

  @override
  List<Object?> get props => <Object?>[mnemonicText, mnemonicTextFieldStatus];
}
