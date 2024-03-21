import 'package:decimal/decimal.dart';
import 'package:equatable/equatable.dart';
import 'package:miro/infra/dto/api_kira/query_balance/response/balance.dart';
import 'package:miro/infra/dto/api_kira/query_faucet/response/query_faucet_info_resp.dart';
import 'package:miro/shared/models/balances/balance_model.dart';
import 'package:miro/shared/models/tokens/token_alias_model.dart';
import 'package:miro/shared/models/tokens/token_amount_model.dart';

class FaucetModel extends Equatable {
  final String address;
  final List<BalanceModel> balanceModelList;

  const FaucetModel({
    required this.address,
    required this.balanceModelList,
  });

  factory FaucetModel.fromDto(QueryFaucetInfoResp queryFaucetInfoResp) {
    return FaucetModel(
      address: queryFaucetInfoResp.address,
      balanceModelList: queryFaucetInfoResp.balances.map((Balance e) {
        return BalanceModel(
            tokenAmountModel: TokenAmountModel(
          defaultDenominationAmount: Decimal.fromInt(int.parse(e.amount)),
          tokenAliasModel: TokenAliasModel.local(e.denom),
        ));
      }).toList(),
    );
  }

  @override
  List<Object?> get props => <Object?>[address, balanceModelList];
}
