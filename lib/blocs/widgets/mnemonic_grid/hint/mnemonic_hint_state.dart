import 'package:equatable/equatable.dart';

class MnemonicHintState extends Equatable {
  final String hintText;

  const MnemonicHintState({
    required this.hintText,
  });

  const MnemonicHintState.empty({required bool placeholderVisibleBool}) : hintText = placeholderVisibleBool ? '--------' : '';

  @override
  List<Object?> get props => <Object?>[hintText];
}
