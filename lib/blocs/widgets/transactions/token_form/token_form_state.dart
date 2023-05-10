import 'package:equatable/equatable.dart';
import 'package:miro/shared/models/tokens/token_amount_model.dart';

class TokenFormState extends Equatable {
  final TokenAmountModel? tokenAmountModel;

  const TokenFormState({
    this.tokenAmountModel,
  });

  bool get empty => tokenAmountModel == null;

  @override
  List<Object?> get props => <Object?>[tokenAmountModel];
}
