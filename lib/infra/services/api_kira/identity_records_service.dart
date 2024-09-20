import 'package:dio/dio.dart';
import 'package:miro/blocs/generic/network_module/network_module_bloc.dart';
import 'package:miro/blocs/widgets/kira/kira_list/abstract_list/models/page_data.dart';
import 'package:miro/config/app_config.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/infra/dto/api_kira/query_identity_record_verify_requests/request/query_identity_record_verify_requests_by_approver_req.dart';
import 'package:miro/infra/dto/api_kira/query_identity_record_verify_requests/request/query_identity_record_verify_requests_by_requester_req.dart';
import 'package:miro/infra/dto/api_kira/query_identity_record_verify_requests/response/pending_verification.dart';
import 'package:miro/infra/dto/api_kira/query_identity_record_verify_requests/response/query_identity_record_verify_requests_by_approver_resp.dart';
import 'package:miro/infra/dto/api_kira/query_identity_record_verify_requests/response/query_identity_record_verify_requests_by_requester_resp.dart';
import 'package:miro/infra/dto/api_kira/query_identity_record_verify_requests/response/verify_record.dart';
import 'package:miro/infra/dto/api_kira/query_identity_records/response/query_identity_record_by_id_resp.dart';
import 'package:miro/infra/dto/api_kira/query_identity_records/response/query_identity_records_by_address_resp.dart';
import 'package:miro/infra/dto/interx_headers.dart';
import 'package:miro/infra/exceptions/dio_parse_exception.dart';
import 'package:miro/infra/models/api_request_model.dart';
import 'package:miro/infra/repositories/api/api_kira_repository.dart';
import 'package:miro/shared/models/identity_registrar/ir_inbound_verification_request_model.dart';
import 'package:miro/shared/models/identity_registrar/ir_model.dart';
import 'package:miro/shared/models/identity_registrar/ir_record_model.dart';
import 'package:miro/shared/models/identity_registrar/ir_record_verification_request_model.dart';
import 'package:miro/shared/models/identity_registrar/ir_user_profile_model.dart';
import 'package:miro/shared/models/identity_registrar/ir_verification_request_status.dart';
import 'package:miro/shared/models/network/block_time_wrapper_model.dart';
import 'package:miro/shared/models/tokens/token_amount_model.dart';
import 'package:miro/shared/models/wallet/address/a_wallet_address.dart';
import 'package:miro/shared/utils/logger/app_logger.dart';
import 'package:miro/shared/utils/logger/log_level.dart';

abstract class _IIdentityRecordsService {
  Future<BlockTimeWrapperModel<IRModel>> getIdentityRecordsByAddress(AWalletAddress walletAddress);

  Future<PageData<IRInboundVerificationRequestModel>> getInboundVerificationRequests(
      QueryIdentityRecordVerifyRequestsByApproverReq queryIdentityRecordVerifyRequestsByApproverReq);

  Future<List<IRRecordVerificationRequestModel>> getOutboundRecordVerificationRequests(IRRecordModel irRecordModel);
}

class IdentityRecordsService implements _IIdentityRecordsService {
  final AppConfig _appConfig = globalLocator<AppConfig>();
  final IApiKiraRepository _apiKiraRepository = globalLocator<IApiKiraRepository>();

  @override
  Future<BlockTimeWrapperModel<IRModel>> getIdentityRecordsByAddress(AWalletAddress walletAddress, {bool forceRequestBool = false}) async {
    Uri networkUri = globalLocator<NetworkModuleBloc>().state.networkUri;

    Response<dynamic> response = await _apiKiraRepository.fetchQueryIdentityRecordsByAddress<dynamic>(ApiRequestModel<String>(
      networkUri: networkUri,
      requestData: walletAddress.address,
      forceRequestBool: forceRequestBool,
    ));
    List<PendingVerification> pendingVerifications = await _getAllPendingVerificationsByRequester(walletAddress, forceRequestBool: forceRequestBool);

    try {
      QueryIdentityRecordsByAddressResp queryIdentityRecordsByAddressResp = QueryIdentityRecordsByAddressResp.fromJson(response.data as Map<String, dynamic>);
      InterxHeaders interxHeaders = InterxHeaders.fromHeaders(response.headers);
      IRModel irModel = IRModel.fromDto(
        walletAddress: walletAddress,
        records: queryIdentityRecordsByAddressResp.records,
        pendingVerifications: pendingVerifications,
      );
      return BlockTimeWrapperModel<IRModel>(model: irModel, blockDateTime: interxHeaders.blockDateTime);
    } catch (e) {
      AppLogger().log(message: 'IdentityRecordsService: Cannot parse getIdentityRecordsByAddress() for URI $networkUri ${e}', logLevel: LogLevel.error);
      throw DioParseException(response: response, error: e);
    }
  }

  @override
  Future<PageData<IRInboundVerificationRequestModel>> getInboundVerificationRequests(
    QueryIdentityRecordVerifyRequestsByApproverReq queryIdentityRecordVerifyRequestsByApproverReq, {
    bool forceRequestBool = true,
  }) async {
    Uri networkUri = globalLocator<NetworkModuleBloc>().state.networkUri;

    Response<dynamic> response = await _apiKiraRepository.fetchQueryIdentityRecordVerifyRequestsByApprover<dynamic>(
      ApiRequestModel<QueryIdentityRecordVerifyRequestsByApproverReq>(
          networkUri: networkUri, requestData: queryIdentityRecordVerifyRequestsByApproverReq, forceRequestBool: forceRequestBool),
    );

    late QueryIdentityRecordVerifyRequestsByApproverResp queryIdentityRecordVerifyRequestsByApproverResp;
    try {
      Map<String, dynamic> jsonData = response.data as Map<String, dynamic>;
      queryIdentityRecordVerifyRequestsByApproverResp = QueryIdentityRecordVerifyRequestsByApproverResp.fromJson(jsonData);
    } catch (e) {
      AppLogger().log(
        message: 'IdentityRecordsService: Cannot parse getInboundVerificationRequests() for URI $networkUri ${e}',
        logLevel: LogLevel.error,
      );
      throw DioParseException(response: response, error: e);
    }

    List<IRInboundVerificationRequestModel> irInboundVerificationRequestModels = List<IRInboundVerificationRequestModel>.empty(growable: true);
    List<AWalletAddress> requesterAddressList = queryIdentityRecordVerifyRequestsByApproverResp.verifyRecords
        .map((VerifyRecord verifyRecord) => verifyRecord.address)
        .toSet()
        .map(AWalletAddress.fromAddress)
        .toList();

    Map<AWalletAddress, IRUserProfileModel> irUserProfileModelsMap = await _getUserProfilesByAddresses(requesterAddressList);

    for (VerifyRecord verifyRecord in queryIdentityRecordVerifyRequestsByApproverResp.verifyRecords) {
      Map<String, String> records = await _getRecordKeyValuePairsById(verifyRecord.recordIds);
      AWalletAddress requesterWalletAddress = AWalletAddress.fromAddress(verifyRecord.address);

      IRInboundVerificationRequestModel irInboundVerificationRequestModel = IRInboundVerificationRequestModel(
        id: verifyRecord.id,
        tipTokenAmountModel: TokenAmountModel.fromString(verifyRecord.tip),
        dateTime: verifyRecord.lastRecordEditDate,
        requesterIrUserProfileModel: irUserProfileModelsMap[requesterWalletAddress]!,
        records: records,
      );
      irInboundVerificationRequestModels.add(irInboundVerificationRequestModel);
    }

    InterxHeaders interxHeaders = InterxHeaders.fromHeaders(response.headers);

    return PageData<IRInboundVerificationRequestModel>(
      listItems: irInboundVerificationRequestModels,
      lastPageBool: irInboundVerificationRequestModels.length < queryIdentityRecordVerifyRequestsByApproverReq.limit!,
      blockDateTime: interxHeaders.blockDateTime,
      cacheExpirationDateTime: interxHeaders.cacheExpirationDateTime,
    );
  }

  @override
  Future<List<IRRecordVerificationRequestModel>> getOutboundRecordVerificationRequests(IRRecordModel irRecordModel) async {
    List<AWalletAddress> allWalletAddresses = <AWalletAddress>{
      ...irRecordModel.verifiersAddresses,
      ...irRecordModel.pendingVerifiersAddresses,
    }.toList();
    Map<AWalletAddress, IRUserProfileModel> irUserProfileModelsMap = await _getUserProfilesByAddresses(allWalletAddresses);

    List<IRRecordVerificationRequestModel> irRecordVerificationRequestModels = <IRRecordVerificationRequestModel>[
      ...irRecordModel.verifiersAddresses.map((AWalletAddress walletAddress) => IRRecordVerificationRequestModel(
            verifierIrUserProfileModel: irUserProfileModelsMap[walletAddress]!,
            irVerificationRequestStatus: IRVerificationRequestStatus.confirmed,
          )),
      ...irRecordModel.pendingVerifiersAddresses.map((AWalletAddress walletAddress) => IRRecordVerificationRequestModel(
            verifierIrUserProfileModel: irUserProfileModelsMap[walletAddress]!,
            irVerificationRequestStatus: IRVerificationRequestStatus.pending,
          )),
    ];

    return irRecordVerificationRequestModels;
  }

  Future<List<PendingVerification>> _getAllPendingVerificationsByRequester(AWalletAddress requesterWalletAddress, {bool forceRequestBool = false}) async {
    Uri networkUri = globalLocator<NetworkModuleBloc>().state.networkUri;
    List<PendingVerification> allPendingVerifications = List<PendingVerification>.empty(growable: true);

    bool downloadInProgressBool = true;
    int index = 0;
    int pageSize = _appConfig.bulkSinglePageSize;
    while (downloadInProgressBool) {
      Response<dynamic> response = await _apiKiraRepository.fetchQueryIdentityRecordVerifyRequestsByRequester<dynamic>(
        ApiRequestModel<QueryIdentityRecordVerifyRequestsByRequesterReq>(
          networkUri: networkUri,
          requestData: QueryIdentityRecordVerifyRequestsByRequesterReq(
            address: requesterWalletAddress.address,
            offset: index * pageSize,
            limit: pageSize,
          ),
          forceRequestBool: forceRequestBool,
        ),
      );

      try {
        Map<String, dynamic> jsonData = response.data as Map<String, dynamic>;
        QueryIdentityRecordVerifyRequestsByRequesterResp queryIdentityRecordVerifyRequestsByRequesterResp =
            QueryIdentityRecordVerifyRequestsByRequesterResp.fromJson(jsonData);
        List<PendingVerification> pendingVerifications = queryIdentityRecordVerifyRequestsByRequesterResp.verifyRecords.map((VerifyRecord e) {
          return PendingVerification(verifierAddress: e.verifier, recordIds: e.recordIds);
        }).toList();
        allPendingVerifications.addAll(pendingVerifications);
        if (allPendingVerifications.length < pageSize) {
          downloadInProgressBool = false;
        }
      } catch (e) {
        AppLogger().log(
          message: 'IdentityRecordsService: Cannot parse _getAllPendingVerificationsByRequester() for URI $networkUri ${e}',
          logLevel: LogLevel.error,
        );
        throw DioParseException(response: response, error: e);
      }
    }
    return allPendingVerifications;
  }

  Future<Map<AWalletAddress, IRUserProfileModel>> _getUserProfilesByAddresses(List<AWalletAddress> walletAddressList) async {
    Map<AWalletAddress, IRUserProfileModel> irUserProfileModelsMap = Map<AWalletAddress, IRUserProfileModel>.fromEntries(
      await Future.wait(
        walletAddressList.map((AWalletAddress walletAddress) async {
          BlockTimeWrapperModel<IRModel> wrappedIrModel = await getIdentityRecordsByAddress(walletAddress);
          IRUserProfileModel irUserProfileModel = IRUserProfileModel.fromIrModel(wrappedIrModel.model);
          return MapEntry<AWalletAddress, IRUserProfileModel>(wrappedIrModel.model.walletAddress, irUserProfileModel);
        }),
      ),
    );
    return irUserProfileModelsMap;
  }

  Future<Map<String, String>> _getRecordKeyValuePairsById(List<String> idList) async {
    Map<String, String> records = <String, String>{};
    for (String id in idList) {
      Uri networkUri = globalLocator<NetworkModuleBloc>().state.networkUri;

      try {
        Response<dynamic> response = await _apiKiraRepository.fetchQueryIdentityRecordById<dynamic>(
          ApiRequestModel<String>(networkUri: networkUri, requestData: id),
        );
        Map<String, dynamic> jsonData = response.data as Map<String, dynamic>;
        QueryIdentityRecordByIdResp queryIdentityRecordByIdResp = QueryIdentityRecordByIdResp.fromJson(jsonData);
        records[queryIdentityRecordByIdResp.record.key] = queryIdentityRecordByIdResp.record.value;
      } catch (e) {
        AppLogger().log(
          message: 'IdentityRecordsService: Cannot get result for _getRecordKeyValuePairsById($id) for URI $networkUri ${e}',
          logLevel: LogLevel.error,
        );
      }
    }
    return records;
  }
}
