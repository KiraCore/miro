import 'package:decimal/decimal.dart';
import 'package:equatable/equatable.dart';
import 'package:miro/config/app_config.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/infra/dto/api_kira/query_network_properties/response/properties.dart';
import 'package:miro/shared/models/tokens/token_amount_model.dart';

class NetworkPropertiesModel extends Equatable {
  final TokenAmountModel minTxFee;
  final TokenAmountModel minIdentityApprovalTip;

  const NetworkPropertiesModel({
    required this.minTxFee,
    required this.minIdentityApprovalTip,
  });

  factory NetworkPropertiesModel.fromDto(Properties properties) {
    final AppConfig appConfig = globalLocator<AppConfig>();

    return NetworkPropertiesModel(
      minTxFee: TokenAmountModel(
        defaultDenominationAmount: Decimal.parse(properties.minTxFee),
        tokenAliasModel: appConfig.defaultFeeTokenAliasModel,
      ),
      minIdentityApprovalTip: TokenAmountModel(
        defaultDenominationAmount: Decimal.parse(properties.minIdentityApprovalTip),
        tokenAliasModel: appConfig.defaultFeeTokenAliasModel,
      ),
    );
  }

  @override
  List<Object?> get props => <Object>[minTxFee, minIdentityApprovalTip];
}
