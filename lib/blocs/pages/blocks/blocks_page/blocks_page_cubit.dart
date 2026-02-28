import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'blocks_page_state.dart';

class BlocksPageCubit extends Cubit<BlocksPageState> {
  BlocksPageCubit() : super(const BlocksPageState(isAgeFormatBool: true));

  void switchDateFormat() => emit(BlocksPageState(isAgeFormatBool: !state.isAgeFormatBool));
}
