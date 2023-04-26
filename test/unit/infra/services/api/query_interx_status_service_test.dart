import 'package:flutter_test/flutter_test.dart';
import 'package:intl/intl.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/infra/dto/api/query_interx_status/interx_info.dart';
import 'package:miro/infra/dto/api/query_interx_status/node.dart';
import 'package:miro/infra/dto/api/query_interx_status/node_info.dart';
import 'package:miro/infra/dto/api/query_interx_status/protocol_version.dart';
import 'package:miro/infra/dto/api/query_interx_status/pub_key.dart';
import 'package:miro/infra/dto/api/query_interx_status/query_interx_status_resp.dart';
import 'package:miro/infra/dto/api/query_interx_status/sync_info.dart';
import 'package:miro/infra/dto/api/query_interx_status/validator_info.dart';
import 'package:miro/infra/exceptions/dio_connect_exception.dart';
import 'package:miro/infra/exceptions/dio_parse_exception.dart';
import 'package:miro/infra/services/api/query_interx_status_service.dart';
import 'package:miro/shared/utils/network_utils.dart';
import 'package:miro/test/mock_locator.dart';
import 'package:miro/test/utils/test_utils.dart';

// To run this test type in console:
// fvm flutter test test/unit/infra/services/api/query_interx_status_service_test.dart --platform chrome --null-assertions
Future<void> main() async {
  await initMockLocator();

  final QueryInterxStatusService queryInterxStatusService = globalLocator<QueryInterxStatusService>();

  QueryInterxStatusResp expectedQueryInterxStatusResp = QueryInterxStatusResp(
    id: '185f6830e3b1fa1027fe8daf386ceddb5b28b869',
    interxInfo: const InterxInfo(
      pubKey: PubKey(type: 'tendermint/PubKeySecp256k1', value: 'A/2wUnalB8tTiEJwR5N/F6q8NUh9VQ+I1whZy+xYD08D'),
      moniker: 'KIRA SENTRY NODE',
      kiraAddress: 'kira1rp0ksv8rk8apqfl73khnsm8dmddj3wrfys2ws2',
      kiraPubKey: 'PubKeySecp256k1{03FDB05276A507CB5388427047937F17AABC35487D550F88D70859CBEC580F4F03}',
      faucetAddress: 'kira1ev7mnj286y3dx3p0pysg7llxhy5s8hggfygnpp',
      genesisChecksum: '3c7dw72740fbd6f840e9757feaa81a3575cabbdb0a213c1e2c1e30913b8771274',
      chainId: 'localnet-1',
      version: 'v0.4.22',
      latestBlockHeight: '108843',
      catchingUp: false,
      node: Node(nodeType: 'seed', sentryNodeId: 'e74dc942ff2213101ba3d024ec0ed22c78c3f58c', snapshotNodeId: '', validatorNodeId: '', seedNodeId: ''),
    ),
    nodeInfo: const NodeInfo(
        protocolVersion: ProtocolVersion(p2p: '8', block: '11', app: '0'),
        id: 'e74dc942ff2213101ba3d024ec0ed22c78c3f58c',
        listenAddress: 'tcp://18.135.115.225:26656',
        network: 'localnet-1',
        version: '0.34.12',
        channels: '40202122233038606100',
        moniker: 'KIRA SENTRY NODE',
        txIndex: 'on',
        rpcAddress: 'tcp://0.0.0.0:26657'),
    syncInfo: SyncInfo(
        latestBlockHash: '510D40E89873857031B9726C75204F089D8DFB893D233E5476AC529188F6CEC8',
        latestAppHash: '8D32891A487D8E9B6583A1896AB108B823F2D8A6E1EC2E5FA0CC5935A319A878',
        latestBlockHeight: '108843',
        latestBlockTime: DateFormat('yyyy-MM-ddTHH:mm').format(DateTime.now()),
        earliestBlockHash: '781FACB1C0D4FE8C150986FBCAC732BDF0573ECFD5920788BBDE96EA4013D740',
        earliestAppHash: 'E3B0C44298FC1C149AFBF4C8996FB92427AE41E4649B934CA495991B7852B855',
        earliestBlockHeight: '2500',
        earliestBlockTime: '2021-10-27T17:28:30.012345678Z'),
    validatorInfo: const ValidatorInfo(
      address: 'B5B1BE023BAE10CE5B9A69DE58D10D952C39BB7A',
      pubKey: PubKey(type: 'tendermint/PubKeyEd25519', value: 'QOHqxX4pUg0Ix1uGuTQ/kJHkvpwPgZ8/VRy9iCFF2Dw='),
      votingPower: '0',
    ),
  );

  group('Tests of QueryInterxStatusService.getQueryInterxStatusResp() method', () {
    test('Should return [QueryInterxStatusResp] if [server HEALTHY] and [response data VALID]', () async {
      // Arrange
      Uri networkUri = NetworkUtils.parseUrlToInterxUri('https://healthy.kira.network/');
      await TestUtils.setupNetworkModel(networkUri: networkUri);

      // Act
      QueryInterxStatusResp actualQueryInterxStatusResp = await queryInterxStatusService.getQueryInterxStatusResp(networkUri);

      // Assert
      expect(actualQueryInterxStatusResp, expectedQueryInterxStatusResp);
    });

    test('Should throw [DioParseException] if [server HEALTHY] and [response data INVALID]', () async {
      // Arrange
      Uri networkUri = NetworkUtils.parseUrlToInterxUri('https://invalid.kira.network/');
      await TestUtils.setupNetworkModel(networkUri: networkUri);

      // Assert
      expect(
        () => queryInterxStatusService.getQueryInterxStatusResp(networkUri),
        throwsA(isA<DioParseException>()),
      );
    });

    test('Should throw [DioConnectException] if [server OFFLINE]', () async {
      // Arrange
      Uri networkUri = NetworkUtils.parseUrlToInterxUri('https://offline.kira.network/');
      await TestUtils.setupNetworkModel(networkUri: networkUri);

      // Assert
      expect(
        () => queryInterxStatusService.getQueryInterxStatusResp(networkUri),
        throwsA(isA<DioConnectException>()),
      );
    });
  });
}
