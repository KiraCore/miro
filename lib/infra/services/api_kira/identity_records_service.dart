import 'package:dio/dio.dart';
import 'package:miro/blocs/generic/network_module/network_module_bloc.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/infra/dto/api_kira/query_identity_record_verify_requests_by_requester/request/query_identity_record_verify_requests_by_requester_resp.dart';
import 'package:miro/infra/dto/api_kira/query_identity_record_verify_requests_by_requester/response/query_identity_record_verify_requests_by_requester_resp.dart';
import 'package:miro/infra/dto/api_kira/query_identity_records/response/query_identity_records_by_address_resp.dart';
import 'package:miro/infra/exceptions/dio_parse_exception.dart';
import 'package:miro/infra/repositories/api/api_kira_repository.dart';
import 'package:miro/shared/models/identity_registrar/ir_model.dart';
import 'package:miro/shared/models/identity_registrar/ir_record_model.dart';
import 'package:miro/shared/models/identity_registrar/ir_verification_model.dart';
import 'package:miro/shared/models/identity_registrar/ir_verification_request_model.dart';
import 'package:miro/shared/models/identity_registrar/ir_verification_request_status.dart';
import 'package:miro/shared/models/wallet/wallet_address.dart';
import 'package:miro/shared/utils/logger/app_logger.dart';
import 'package:miro/shared/utils/logger/log_level.dart';

abstract class _IIdentityRecordsService {
  Future<IRModel> getIdentityRecordsByAddress(WalletAddress walletAddress);

  Future<List<IRVerificationRequestModel>> getPendingVerificationRequests(String requesterAddress);

  Future<List<IRVerificationModel>> getRecordVerifications(IRRecordModel irRecordModel);
}

class IdentityRecordsService implements _IIdentityRecordsService {
  final IApiKiraRepository _apiKiraRepository = globalLocator<IApiKiraRepository>();

  @override
  Future<IRModel> getIdentityRecordsByAddress(WalletAddress walletAddress) async {
    Uri networkUri = globalLocator<NetworkModuleBloc>().state.networkUri;

    List<IRVerificationRequestModel> pendingIRVerificationRequests = await getPendingVerificationRequests(walletAddress.bech32Address);
    Response<dynamic> response = await _apiKiraRepository.fetchQueryIdentityRecordsByAddress<dynamic>(networkUri, walletAddress.bech32Address);

    try {
      QueryIdentityRecordsByAddressResp queryIdentityRecordsByAddressResp = QueryIdentityRecordsByAddressResp.fromJson(response.data as Map<String, dynamic>);
      IRModel irModel = IRModel.fromDto(
        walletAddress: walletAddress,
        records: queryIdentityRecordsByAddressResp.records,
        irVerificationRequests: pendingIRVerificationRequests,
      );
      return irModel;
    } catch (e) {
      AppLogger().log(message: 'IdentityRecordsService: Cannot parse getIdentityRecordsByAddress() for URI $networkUri ${e}', logLevel: LogLevel.error);
      throw DioParseException(response: response, error: e);
    }
  }

  @override
  Future<List<IRVerificationRequestModel>> getPendingVerificationRequests(String requesterAddress) async {
    Uri networkUri = globalLocator<NetworkModuleBloc>().state.networkUri;
    Response<dynamic> response = await _apiKiraRepository.fetchQueryIdentityRecordVerifyRequestsByRequester<dynamic>(
      networkUri,
      QueryIdentityRecordVerifyRequestsByRequesterReq(address: requesterAddress),
    );

    try {
      Map<String, dynamic> jsonData = response.data as Map<String, dynamic>;
      QueryIdentityRecordVerifyRequestsByRequesterResp queryIdentityRecordVerifyRequestsByRequesterResp =
          QueryIdentityRecordVerifyRequestsByRequesterResp.fromJson(jsonData);
      return queryIdentityRecordVerifyRequestsByRequesterResp.verifyRecords.map(IRVerificationRequestModel.fromDto).toList();
    } catch (e) {
      AppLogger().log(
        message: 'IdentityRecordsService: Cannot parse getPendingVerificationRequests() for URI $networkUri ${e}',
        logLevel: LogLevel.error,
      );
      throw DioParseException(response: response, error: e);
    }
  }

  @override
  Future<List<IRVerificationModel>> getRecordVerifications(IRRecordModel irRecordModel) async {
    List<WalletAddress> confirmedWalletAddressList = irRecordModel.verifiersAddresses;
    List<WalletAddress> pendingWalletAddressList = irRecordModel.irVerificationRequests.map((IRVerificationRequestModel e) => e.verifierWalletAddress).toList();

    List<IRVerificationModel> irVerificationModelList = <IRVerificationModel>[
      ...await _buildVerificationModel(confirmedWalletAddressList, IRVerificationRequestStatus.confirmed),
      ...await _buildVerificationModel(pendingWalletAddressList, IRVerificationRequestStatus.pending),
    ];

    return irVerificationModelList;
  }

  Future<List<IRVerificationModel>> _buildVerificationModel(
    List<WalletAddress> verifiersAddresses,
    IRVerificationRequestStatus irVerificationRequestStatus,
  ) async {
    List<IRVerificationModel> pendingIRVerifications = List<IRVerificationModel>.empty(growable: true);
    for (WalletAddress walletAddress in verifiersAddresses) {
      IRVerificationModel irVerificationModel = IRVerificationModel(
        verifierIrModel: await getIdentityRecordsByAddress(walletAddress),
        irVerificationRequestStatus: irVerificationRequestStatus,
      );
      pendingIRVerifications.add(irVerificationModel);
    }
    return pendingIRVerifications;
  }
}
