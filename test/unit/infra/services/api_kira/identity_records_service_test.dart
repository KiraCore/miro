import 'package:flutter_test/flutter_test.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/infra/exceptions/dio_connect_exception.dart';
import 'package:miro/infra/exceptions/dio_parse_exception.dart';
import 'package:miro/infra/services/api_kira/identity_records_service.dart';
import 'package:miro/shared/models/identity_registrar/ir_model.dart';
import 'package:miro/shared/models/identity_registrar/ir_record_model.dart';
import 'package:miro/shared/models/identity_registrar/ir_verification_model.dart';
import 'package:miro/shared/models/identity_registrar/ir_verification_request_model.dart';
import 'package:miro/shared/models/identity_registrar/ir_verification_request_status.dart';
import 'package:miro/shared/models/wallet/wallet_address.dart';
import 'package:miro/shared/utils/network_utils.dart';
import 'package:miro/test/mock_locator.dart';
import 'package:miro/test/utils/test_utils.dart';

// To run this test type in console:
// fvm flutter test test/unit/infra/services/api_kira/identity_records_service_test.dart --platform chrome --null-assertions
// ignore_for_file: avoid_print
Future<void> main() async {
  await initMockLocator();

  final IdentityRecordsService actualIdentityRecordsService = globalLocator<IdentityRecordsService>();
  final WalletAddress actualWalletAddress = WalletAddress.fromBech32('kira143q8vxpvuykt9pq50e6hng9s38vmy844n8k9wx');
  final IRRecordModel actualIRRecordModel = IRRecordModel(
    id: '3',
    key: 'username',
    value: 'somnitear',
    verifiersAddresses: <WalletAddress>[
      WalletAddress.fromBech32('kira177lwmjyjds3cy7trers83r4pjn3dhv8zrqk9dl'),
    ],
    irVerificationRequests: const <IRVerificationRequestModel>[],
  );

  final IRModel expectedRequesterIRModel = IRModel(
    walletAddress: WalletAddress.fromBech32('kira143q8vxpvuykt9pq50e6hng9s38vmy844n8k9wx'),
    usernameIRRecordModel: IRRecordModel(
      id: '3',
      key: 'username',
      value: 'somnitear',
      verifiersAddresses: const <WalletAddress>[],
      irVerificationRequests: <IRVerificationRequestModel>[
        IRVerificationRequestModel(
          requesterWalletAddress: WalletAddress.fromBech32('kira143q8vxpvuykt9pq50e6hng9s38vmy844n8k9wx'),
          verifierWalletAddress: WalletAddress.fromBech32('kira177lwmjyjds3cy7trers83r4pjn3dhv8zrqk9dl'),
          recordIds: const <String>['3'],
        )
      ],
    ),
    descriptionIRRecordModel: const IRRecordModel.empty(key: 'description'),
    socialMediaIRRecordModel: const IRRecordModel.empty(key: 'social_media'),
    avatarIRRecordModel: const IRRecordModel(
      id: '2',
      key: 'avatar',
      value: 'https://avatars.githubusercontent.com/u/114292385',
      verifiersAddresses: <WalletAddress>[],
      irVerificationRequests: <IRVerificationRequestModel>[],
    ),
    otherIRRecordModelList: <IRRecordModel>[
      IRRecordModel(
        id: '4',
        key: 'github',
        value: 'https://github.com/kiracore',
        verifiersAddresses: <WalletAddress>[
          WalletAddress.fromBech32('kira177lwmjyjds3cy7trers83r4pjn3dhv8zrqk9dl'),
        ],
        irVerificationRequests: const <IRVerificationRequestModel>[],
      ),
    ],
  );

  final IRModel expectedVerifierIRModel = IRModel(
    walletAddress: WalletAddress.fromBech32('kira177lwmjyjds3cy7trers83r4pjn3dhv8zrqk9dl'),
    usernameIRRecordModel: IRRecordModel(
      id: '3',
      key: 'username',
      value: 'somnitear',
      verifiersAddresses: const <WalletAddress>[],
      irVerificationRequests: <IRVerificationRequestModel>[
        IRVerificationRequestModel(
          requesterWalletAddress: WalletAddress.fromBech32('kira143q8vxpvuykt9pq50e6hng9s38vmy844n8k9wx'),
          verifierWalletAddress: WalletAddress.fromBech32('kira177lwmjyjds3cy7trers83r4pjn3dhv8zrqk9dl'),
          recordIds: const <String>['3'],
        )
      ],
    ),
    descriptionIRRecordModel: const IRRecordModel.empty(key: 'description'),
    socialMediaIRRecordModel: const IRRecordModel.empty(key: 'social_media'),
    avatarIRRecordModel: const IRRecordModel(
      id: '2',
      key: 'avatar',
      value: 'https://avatars.githubusercontent.com/u/114292385',
      verifiersAddresses: <WalletAddress>[],
      irVerificationRequests: <IRVerificationRequestModel>[],
    ),
    otherIRRecordModelList: <IRRecordModel>[
      IRRecordModel(
        id: '4',
        key: 'github',
        value: 'https://github.com/kiracore',
        verifiersAddresses: <WalletAddress>[
          WalletAddress.fromBech32('kira177lwmjyjds3cy7trers83r4pjn3dhv8zrqk9dl'),
        ],
        irVerificationRequests: const <IRVerificationRequestModel>[],
      ),
    ],
  );

  group('Tests of IdentityRecordsService.getIdentityRecordsByAddress() method [GET in HTTP]', () {
    test('Should return [IRModel] if [server HEALTHY] and response [CAN be parsed to QueryIdentityRecordsByAddressResp]', () async {
      // Arrange
      Uri networkUri = NetworkUtils.parseUrlToInterxUri('https://healthy.kira.network/');
      await TestUtils.setupNetworkModel(networkUri: networkUri);

      // Act
      IRModel actualIRModel = await actualIdentityRecordsService.getIdentityRecordsByAddress(actualWalletAddress);

      // Assert
      expect(actualIRModel, expectedRequesterIRModel);
    });

    test(
      'Should throw [DioParseException] if [server HEALTHY] and response [CANNOT be parsed to QueryIdentityRecordsByAddressResp] (e.g. response structure changed)',
      () async {
        // Arrange
        Uri networkUri = NetworkUtils.parseUrlToInterxUri('https://invalid.kira.network/');
        await TestUtils.setupNetworkModel(networkUri: networkUri);

        // Assert
        expect(
          actualIdentityRecordsService.getIdentityRecordsByAddress(actualWalletAddress),
          throwsA(isA<DioParseException>()),
        );
      },
    );

    test('Should throw [DioConnectException] if [server OFFLINE]', () async {
      // Arrange
      Uri networkUri = NetworkUtils.parseUrlToInterxUri('https://offline.kira.network/');
      await TestUtils.setupNetworkModel(networkUri: networkUri);

      // Assert
      expect(
        actualIdentityRecordsService.getIdentityRecordsByAddress(actualWalletAddress),
        throwsA(isA<DioConnectException>()),
      );
    });
  });

  group('Tests of IdentityRecordsService.getPendingVerificationRequests() method [GET in HTTP]', () {
    test(
        'Should return [List of IRVerificationRequestModel] if [server HEALTHY] and response [CAN be parsed to QueryIdentityRecordVerifyRequestsByRequesterResp]',
        () async {
      // Arrange
      Uri networkUri = NetworkUtils.parseUrlToInterxUri('https://healthy.kira.network/');
      await TestUtils.setupNetworkModel(networkUri: networkUri);

      // Act
      List<IRVerificationRequestModel> actualIRVerificationRequests =
          await actualIdentityRecordsService.getPendingVerificationRequests(actualWalletAddress.bech32Address);

      // Assert
      List<IRVerificationRequestModel> expectedIRVerificationRequests = <IRVerificationRequestModel>[
        IRVerificationRequestModel(
          requesterWalletAddress: WalletAddress.fromBech32('kira143q8vxpvuykt9pq50e6hng9s38vmy844n8k9wx'),
          verifierWalletAddress: WalletAddress.fromBech32('kira177lwmjyjds3cy7trers83r4pjn3dhv8zrqk9dl'),
          recordIds: const <String>['3'],
        ),
      ];

      expect(actualIRVerificationRequests, expectedIRVerificationRequests);
    });

    test(
      'Should throw [DioParseException] if [server HEALTHY] and response [CANNOT be parsed to QueryIdentityRecordVerifyRequestsByRequesterResp] (e.g. response structure changed)',
      () async {
        // Arrange
        Uri networkUri = NetworkUtils.parseUrlToInterxUri('https://invalid.kira.network/');
        await TestUtils.setupNetworkModel(networkUri: networkUri);

        // Assert
        expect(
          actualIdentityRecordsService.getPendingVerificationRequests(actualWalletAddress.bech32Address),
          throwsA(isA<DioParseException>()),
        );
      },
    );

    test('Should throw [DioConnectException] if [server OFFLINE]', () async {
      // Arrange
      Uri networkUri = NetworkUtils.parseUrlToInterxUri('https://offline.kira.network/');
      await TestUtils.setupNetworkModel(networkUri: networkUri);

      // Assert
      expect(
        actualIdentityRecordsService.getPendingVerificationRequests(actualWalletAddress.bech32Address),
        throwsA(isA<DioConnectException>()),
      );
    });
  });

  group('Tests of IdentityRecordsService.getRecordVerifications() method [GET in HTTP]', () {
    test('Should return [List of IRVerificationModel] if [server HEALTHY] and response [CAN be parsed to QueryIdentityRecordsByAddressResp]', () async {
      // Arrange
      Uri networkUri = NetworkUtils.parseUrlToInterxUri('https://healthy.kira.network/');
      await TestUtils.setupNetworkModel(networkUri: networkUri);

      // Act
      List<IRVerificationModel> actualIRVerificationModel = await actualIdentityRecordsService.getRecordVerifications(actualIRRecordModel);

      // Assert
      List<IRVerificationModel> expectedIRVerificationModel = <IRVerificationModel>[
        IRVerificationModel(
          verifierIrModel: expectedVerifierIRModel,
          irVerificationRequestStatus: IRVerificationRequestStatus.confirmed,
        )
      ];
      expect(actualIRVerificationModel, expectedIRVerificationModel);
    });

    test(
      'Should throw [DioParseException] if [server HEALTHY] and response [CANNOT be parsed to QueryIdentityRecordsByAddressResp] (e.g. response structure changed)',
      () async {
        // Arrange
        Uri networkUri = NetworkUtils.parseUrlToInterxUri('https://invalid.kira.network/');
        await TestUtils.setupNetworkModel(networkUri: networkUri);

        // Assert
        expect(
          actualIdentityRecordsService.getRecordVerifications(actualIRRecordModel),
          throwsA(isA<DioParseException>()),
        );
      },
    );

    test('Should throw [DioConnectException] if [server OFFLINE]', () async {
      // Arrange
      Uri networkUri = NetworkUtils.parseUrlToInterxUri('https://offline.kira.network/');
      await TestUtils.setupNetworkModel(networkUri: networkUri);

      // Assert
      expect(
        actualIdentityRecordsService.getRecordVerifications(actualIRRecordModel),
        throwsA(isA<DioConnectException>()),
      );
    });
  });
}
