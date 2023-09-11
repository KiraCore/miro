import 'package:equatable/equatable.dart';
import 'package:miro/blocs/widgets/mnemonic_grid/text_field/mnemonic_text_field_cubit.dart';

class MnemonicGridState extends Equatable {
  final int cellsCount;
  final List<MnemonicTextFieldCubit> mnemonicTextFieldCubitList;

  MnemonicGridState.loading()
      : mnemonicTextFieldCubitList = List<MnemonicTextFieldCubit>.empty(),
        cellsCount = 0;

  const MnemonicGridState.loaded({
    required this.mnemonicTextFieldCubitList,
  }) : cellsCount = mnemonicTextFieldCubitList.length;

  @override
  List<Object?> get props => <Object?>[cellsCount, mnemonicTextFieldCubitList];
}
