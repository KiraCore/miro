part of 'transactions_page_cubit.dart';

class TransactionsPageState extends Equatable {
  final bool isAgeFormatBool;

  const TransactionsPageState({required this.isAgeFormatBool});

  @override
  List<Object?> get props => <Object?>[isAgeFormatBool];
}
