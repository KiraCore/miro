import 'package:dio/dio.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/infra/dto/api_kira/query_identity_records/request/query_identity_record_req.dart';
import 'package:miro/infra/dto/api_kira/query_identity_records/request/query_identity_records_by_address_req.dart';
import 'package:miro/infra/dto/api_kira/query_identity_records/response/query_identity_record_resp.dart';
import 'package:miro/infra/dto/api_kira/query_identity_records/response/query_identity_records_by_address_resp.dart';
import 'package:miro/infra/dto/api_kira/query_identity_records/response/record.dart';
import 'package:miro/infra/repositories/api_kira_repository.dart';
import 'package:miro/providers/network_provider/network_provider.dart';
import 'package:miro/providers/wallet_provider.dart';
import 'package:miro/shared/models/identity_registrar/identity_record_model.dart';
import 'package:miro/shared/models/wallet/wallet.dart';

abstract class _IQueryIdentityRecordsService {
  Future<List<IdentityRecordModel>> getMyIdentityRecords({Uri? optionalNetworkUri});

  Future<List<IdentityRecordModel>> getIdentityRecordsByAddress(String address, {Uri? optionalNetworkUri});

  Future<QueryIdentityRecordResp> getQueryIdentityRecordResp(int recordId, {Uri? optionalNetworkUri});

  Future<QueryIdentityRecordsByAddressResp> getQueryIdentityRecordsByAddressResp(
    String address, {
    Uri? optionalNetworkUri,
  });
}

class QueryIdentityRecordsService implements _IQueryIdentityRecordsService {
  final ApiKiraRepository _apiKiraRepository = globalLocator<ApiKiraRepository>();

  @override
  Future<List<IdentityRecordModel>> getMyIdentityRecords({Uri? optionalNetworkUri}) async {
    Uri networkUri = optionalNetworkUri ?? globalLocator<NetworkProvider>().networkUri!;
    Wallet? wallet = globalLocator<WalletProvider>().currentWallet;
    assert(wallet != null, 'User must be logged in to use getMyIdentityRecords() method');
    return await getIdentityRecordsByAddress(wallet!.address.bech32Address, optionalNetworkUri: networkUri);
  }

  @override
  Future<List<IdentityRecordModel>> getIdentityRecordsByAddress(
    String address, {
    Uri? optionalNetworkUri,
  }) async {
    QueryIdentityRecordsByAddressResp queryIdentityRecordsByAddressResp = await getQueryIdentityRecordsByAddressResp(
      address,
      optionalNetworkUri: optionalNetworkUri,
    );
    return queryIdentityRecordsByAddressResp.records
        .map((Record record) => IdentityRecordModel.fromDto(record))
        .toList();
  }

  @override
  Future<QueryIdentityRecordResp> getQueryIdentityRecordResp(int recordId, {Uri? optionalNetworkUri}) async {
    Uri networkUri = optionalNetworkUri ?? globalLocator<NetworkProvider>().networkUri!;
    final Response<dynamic> response = await _apiKiraRepository.fetchQueryIdentityRecord<dynamic>(
      networkUri,
      QueryIdentityRecordReq(
        id: recordId,
      ),
    );
    return QueryIdentityRecordResp.fromJson(response.data as Map<String, dynamic>);
  }

  @override
  Future<QueryIdentityRecordsByAddressResp> getQueryIdentityRecordsByAddressResp(
    String address, {
    Uri? optionalNetworkUri,
  }) async {
    Uri networkUri = optionalNetworkUri ?? globalLocator<NetworkProvider>().networkUri!;
    final Response<dynamic> response = await _apiKiraRepository.fetchQueryIdentityRecordsByAddress<dynamic>(
      networkUri,
      QueryIdentityRecordsByAddressReq(
        creator: address,
      ),
    );
    return QueryIdentityRecordsByAddressResp.fromJson(response.data as Map<String, dynamic>);
  }
}
