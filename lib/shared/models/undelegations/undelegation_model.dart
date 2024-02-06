import 'package:decimal/decimal.dart';
import 'package:miro/blocs/widgets/kira/kira_list/abstract_list/models/a_list_item.dart';
import 'package:miro/infra/dto/api_kira/query_undelegations/response/undelegation.dart';
import 'package:miro/infra/dto/shared/coin.dart';
import 'package:miro/shared/models/tokens/token_alias_model.dart';
import 'package:miro/shared/models/tokens/token_amount_model.dart';
import 'package:miro/shared/models/validators/validator_simplified_model.dart';
import 'package:miro/shared/models/wallet/wallet_address.dart';
import 'package:miro/shared/utils/custom_date_utils.dart';

class UndelegationModel extends AListItem {
  final int id;
  final DateTime lockedUntil;
  final ValidatorSimplifiedModel validatorSimplifiedModel;
  final List<TokenAmountModel> tokens;

  UndelegationModel({
    required this.id,
    required this.lockedUntil,
    required this.validatorSimplifiedModel,
    required this.tokens,
  });

  factory UndelegationModel.fromDto(Undelegation undelegation) {
    return UndelegationModel(
      id: undelegation.id,
      lockedUntil: CustomDateUtils.buildDateFromSecondsSinceEpoch(int.parse(undelegation.expiry)),
      validatorSimplifiedModel: ValidatorSimplifiedModel(
        walletAddress: WalletAddress.fromBech32(undelegation.validatorInfo.address),
        moniker: undelegation.validatorInfo.moniker,
        logo: undelegation.validatorInfo.logo,
        valkey: undelegation.validatorInfo.valkey,
      ),
      tokens: undelegation.tokens
          .map((Coin e) => TokenAmountModel(
                defaultDenominationAmount: Decimal.parse(e.amount),
                tokenAliasModel: TokenAliasModel.local(e.denom),
              ))
          .toList(),
    );
  }

  UndelegationModel copyWith({
    List<TokenAmountModel>? tokens,
  }) {
    return UndelegationModel(
      id: id,
      lockedUntil: lockedUntil,
      validatorSimplifiedModel: validatorSimplifiedModel,
      tokens: tokens ?? this.tokens,
    );
  }

  UndelegationModel fillTokenAliases(List<TokenAliasModel> tokenAliasModels) {
    List<TokenAmountModel> filledTokenAmountModels = tokens.map((TokenAmountModel e) {
      return e.copyWith(
        tokenAliasModel: tokenAliasModels.firstWhere(
          (TokenAliasModel tokenAliasModel) => tokenAliasModel.defaultTokenDenominationModel.name == e.tokenAliasModel.defaultTokenDenominationModel.name,
          orElse: () => e.tokenAliasModel,
        ),
      );
    }).toList();

    return copyWith(tokens: filledTokenAmountModels);
  }

  List<String> get denomNames {
    return tokens.map((TokenAmountModel e) => e.tokenAliasModel.defaultTokenDenominationModel.name).toList();
  }

  @override
  String get cacheId => id.toString();

  @override
  bool get isFavourite => false;

  @override
  set favourite(bool value) => false;

  bool isClaimingBlocked({DateTime? dateTime}) {
    dateTime ??= DateTime.now();
    return lockedUntil.difference(dateTime).inSeconds > 0;
  }

  @override
  String toString() {
    return 'UndelegationModel(id: $id, lockedUntil: $lockedUntil, validatorSimplifiedModel: $validatorSimplifiedModel, tokens: $tokens)';
  }
}
