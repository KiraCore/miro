part of 'blocks_page_cubit.dart';

class BlocksPageState extends Equatable {
  final bool isAgeFormatBool;

  const BlocksPageState({required this.isAgeFormatBool});

  @override
  List<Object?> get props => <Object?>[isAgeFormatBool];
}
