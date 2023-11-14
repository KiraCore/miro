import 'package:flutter_test/flutter_test.dart';
import 'package:miro/blocs/widgets/kira/kira_list/abstract_list/models/page_data.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/infra/dto/api_kira/query_proposals/request/query_proposals_req.dart';
import 'package:miro/infra/exceptions/dio_connect_exception.dart';
import 'package:miro/infra/exceptions/dio_parse_exception.dart';
import 'package:miro/infra/services/api_kira/query_proposals_service.dart';
import 'package:miro/shared/models/proposals/proposal_model.dart';
import 'package:miro/shared/utils/network_utils.dart';
import 'package:miro/test/mock_locator.dart';
import 'package:miro/test/utils/test_utils.dart';

// To run this test type in console:
// fvm flutter test test/unit/infra/services/api_kira/query_proposals_service_test.dart --platform chrome --null-assertions
// ignore_for_file: avoid_print

Future<void> main() async {
  await initMockLocator();

  final QueryProposalsService queryProposalService = globalLocator<QueryProposalsService>();

  group('Tests of QueryProposalService.getProposals() method', () {
    test('Should return PageData<ProposalModel> if [servery HEALTHY] and [response data VALID]', () async {
      // Arrange
      Uri networkUri = NetworkUtils.parseUrlToInterxUri('https://healthy.kira.network/');

      // Act
      await TestUtils.setupNetworkModel(networkUri: networkUri);

      PageData<ProposalModel> actualProposalsData = await queryProposalService.getProposals(
        const QueryProposalsReq(
          limit: 10,
          offset: 0,
        ),
      );

      // Assert
      // Because we have 18 mocked proposals, defining all objects will be inefficient.
      // Therefore, we check whether all objects were successfully parsed
      expect(actualProposalsData.listItems.length, 18);
    });

    test('Should throw [DioParseException] if [server HEALTHY] and [response data INVALID]', () async {
      // Arrange
      Uri networkUri = NetworkUtils.parseUrlToInterxUri('https://invalid.kira.network/');

      // Act
      await TestUtils.setupNetworkModel(networkUri: networkUri);

      // Assert
      expect(
        queryProposalService.getProposals(const QueryProposalsReq()),
        throwsA(isA<DioParseException>()),
      );
    });

    test('Should throw [DioConnectException] if [server OFFLINE]', () async {
      // Arrange
      Uri networkUri = NetworkUtils.parseUrlToInterxUri('https://offline.kira.network/');

      // Act
      await TestUtils.setupNetworkModel(networkUri: networkUri);

      // Assert
      expect(
        queryProposalService.getProposals(const QueryProposalsReq()),
        throwsA(isA<DioConnectException>()),
      );
    });
  });
}
