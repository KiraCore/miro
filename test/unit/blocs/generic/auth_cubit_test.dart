import 'dart:convert';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:miro/blocs/generic/auth/auth_cubit.dart';
import 'package:miro/blocs/generic/identity_registrar/identity_registrar_cubit.dart';
import 'package:miro/blocs/generic/metamask/ethereum_provider.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/infra/managers/cache/i_cache_manager.dart';
import 'package:miro/infra/managers/cache/impl/hive_cache_manager.dart';
import 'package:miro/shared/models/wallet/address/a_wallet_address.dart';
import 'package:miro/shared/models/wallet/address/cosmos_wallet_address.dart';
import 'package:miro/shared/models/wallet/address/ethereum_wallet_address.dart';
import 'package:miro/shared/models/wallet/wallet.dart';
import 'package:miro/test/mock_locator.dart';
import 'package:miro/test/utils/test_utils.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

@GenerateNiceMocks(<MockSpec<dynamic>>[
  MockSpec<IdentityRegistrarCubit>(),
  MockSpec<EthereumProvider>(),
  MockSpec<HiveCacheManager>(as: #MockICacheManager),
])
import 'auth_cubit_test.mocks.dart';

// To run this test type in console:
// fvm flutter test test/unit/blocs/generic/auth_cubit_test.dart --platform chrome --null-assertions
void main() async {
  // await TestUtils.setupNetworkModel(networkUri: Uri.parse('https://healthy.kira.network/'));

  group('Tests of [AuthCubit]', () {
    late MockIdentityRegistrarCubit mockIdentityRegistrarCubit;
    late MockEthereumProvider mockEthereumProvider;
    late MockICacheManager mockCacheManager;

    setUp(() async {
      await initMockLocator();

      mockIdentityRegistrarCubit = MockIdentityRegistrarCubit();
      mockEthereumProvider = MockEthereumProvider();
      mockCacheManager = MockICacheManager();

      globalLocator
        ..unregister(instance: globalLocator<IdentityRegistrarCubit>())
        ..registerSingleton<IdentityRegistrarCubit>(mockIdentityRegistrarCubit)
        ..unregister(instance: globalLocator<EthereumProvider>())
        ..registerSingleton<EthereumProvider>(mockEthereumProvider)
        ..unregister(instance: globalLocator<ICacheManager>())
        ..registerSingleton<ICacheManager>(mockCacheManager);
    });

    tearDown(() async {
      await globalLocator.reset();
    });

    AuthCubit createCubit() => AuthCubit();

    blocTest<AuthCubit, Wallet?>(
      'Initial state should be null',
      build: createCubit,
      verify: (AuthCubit cubit) {
        expect(cubit.state, isNull);
        expect(cubit.loggedInWithAddressType, isNull);
      },
    );

    blocTest<AuthCubit, Wallet?>(
      'Sign in with Cosmos wallet',
      build: createCubit,
      act: (AuthCubit cubit) async {
        final Wallet cosmosWallet =
            Wallet(address: CosmosWalletAddress.fromBech32(TestUtils.ethereumSignatureDecodeResult.cosmosAddress));
        await cubit.signIn(cosmosWallet);
      },
      expect: () => <TypeMatcher<Wallet>>[
        isA<Wallet>().having(
            (Wallet wallet) => wallet.address,
            'address',
            isA<CosmosWalletAddress>().having(
              (CosmosWalletAddress addr) => addr.address,
              'address',
              TestUtils.ethereumSignatureDecodeResult.cosmosAddress,
            ))
      ],
      verify: (AuthCubit cubit) {
        expect(cubit.loggedInWithAddressType, equals(WalletAddressType.cosmos));
        verify(mockIdentityRegistrarCubit.setWalletAddress(any)).called(1);
      },
    );

    blocTest<AuthCubit, Wallet?>(
      'Sign in with Ethereum wallet and cache address',
      build: createCubit,
      setUp: () {
        final String mockData = jsonEncode(TestUtils.ethereumSignatureDecodeResult.toDataJson());
        when(mockCacheManager.get<String>(
          boxName: EthereumProvider.hiveBoxName,
          key: anyNamed('key'),
          defaultValue: anyNamed('defaultValue'),
        )).thenReturn(mockData);
      },
      act: (AuthCubit cubit) async {
        final Wallet ethWallet = Wallet(
          address: EthereumWalletAddress.fromString(TestUtils.ethereumSignatureDecodeResult.ethAddress),
        );
        await cubit.signIn(ethWallet);
      },
      expect: () => <TypeMatcher<Wallet>>[
        isA<Wallet>().having(
            (Wallet wallet) => wallet.address,
            'address',
            isA<CosmosWalletAddress>().having((CosmosWalletAddress addr) => addr.address, 'address',
                TestUtils.ethereumSignatureDecodeResult.cosmosAddress))
      ],
      verify: (AuthCubit cubit) {
        expect(cubit.loggedInWithAddressType, equals(WalletAddressType.ethereum));
        verify(mockIdentityRegistrarCubit.setWalletAddress(any)).called(1);
      },
    );

    blocTest<AuthCubit, Wallet?>(
      'Sign out resets state',
      build: createCubit,
      act: (AuthCubit cubit) async {
        final Wallet cosmosWallet =
            Wallet(address: CosmosWalletAddress.fromBech32(TestUtils.ethereumSignatureDecodeResult.cosmosAddress));
        await cubit.signIn(cosmosWallet);
        await cubit.signOut();
      },
      expect: () => <TypeMatcher<Wallet>?>[
        isA<Wallet>(),
        null,
      ],
      verify: (AuthCubit cubit) {
        expect(cubit.state, isNull);
        expect(cubit.loggedInWithAddressType, isNull);
        verify(mockIdentityRegistrarCubit.setWalletAddress(null)).called(1);
      },
    );

    blocTest<AuthCubit, Wallet?>(
      'Toggle wallet address between Ethereum and Cosmos',
      build: createCubit,
      setUp: () {
        final String mockData = jsonEncode(TestUtils.ethereumSignatureDecodeResult.toDataJson());
        when(mockCacheManager.get<String>(
          boxName: EthereumProvider.hiveBoxName,
          key: anyNamed('key'),
          defaultValue: anyNamed('defaultValue'),
        )).thenReturn(mockData);
      },
      act: (AuthCubit cubit) async {
        final Wallet ethWallet = Wallet(
          address: EthereumWalletAddress.fromString(TestUtils.ethereumSignatureDecodeResult.ethAddress),
        );
        await cubit.signIn(ethWallet);
        cubit.toggleWalletAddress();
      },
      expect: () => <TypeMatcher<Wallet>>[
        isA<Wallet>().having(
            (Wallet wallet) => wallet.address,
            'cosmos address',
            isA<CosmosWalletAddress>().having((CosmosWalletAddress addr) => addr.address, 'address',
                TestUtils.ethereumSignatureDecodeResult.cosmosAddress)),
        isA<Wallet>().having(
            (Wallet wallet) => wallet.address,
            'eth address',
            isA<EthereumWalletAddress>().having((EthereumWalletAddress addr) => addr.address, 'address',
                TestUtils.ethereumSignatureDecodeResult.ethAddress)),
      ],
    );

    blocTest<AuthCubit, Wallet?>(
      'Replace address type in a string',
      build: createCubit,
      setUp: () {
        final String mockData = jsonEncode(TestUtils.ethereumSignatureDecodeResult.toDataJson());
        when(mockCacheManager.get<String>(
          boxName: EthereumProvider.hiveBoxName,
          key: anyNamed('key'),
          defaultValue: anyNamed('defaultValue'),
        )).thenReturn(mockData);
      },
      act: (AuthCubit cubit) async {
        final Wallet ethWallet = Wallet(
          address: EthereumWalletAddress.fromString(TestUtils.ethereumSignatureDecodeResult.ethAddress),
        );
        await cubit.signIn(ethWallet);
        final String result =
            cubit.replaceAddressTypeIfExists('This is ${TestUtils.ethereumSignatureDecodeResult.ethAddress}');
        expect(result, contains(TestUtils.ethereumSignatureDecodeResult.cosmosAddress));
      },
      expect: () => <TypeMatcher<Wallet>>[
        isA<Wallet>().having(
            (Wallet wallet) => wallet.address,
            'address',
            isA<CosmosWalletAddress>().having((CosmosWalletAddress addr) => addr.address, 'address',
                TestUtils.ethereumSignatureDecodeResult.cosmosAddress))
      ],
    );
  });
}
