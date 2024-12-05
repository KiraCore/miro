import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'transactions_page_state.dart';

class TransactionsPageCubit extends Cubit<TransactionsPageState> {
  TransactionsPageCubit() : super(const TransactionsPageState(isAgeFormatBool: true));

  void switchDateFormat() => emit(TransactionsPageState(isAgeFormatBool: !state.isAgeFormatBool));
}
