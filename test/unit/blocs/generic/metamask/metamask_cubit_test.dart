import 'dart:convert';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_web3/ethereum.dart';
import 'package:miro/blocs/generic/auth/auth_cubit.dart';
import 'package:miro/blocs/generic/metamask/ethereum_provider.dart';
import 'package:miro/blocs/generic/metamask/metamask_cubit.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/infra/managers/cache/i_cache_manager.dart';
import 'package:miro/infra/managers/cache/impl/hive_cache_manager.dart';
import 'package:miro/test/utils/test_utils.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

@GenerateNiceMocks(<MockSpec<dynamic>>[
  MockSpec<EthereumProvider>(),
  MockSpec<AuthCubit>(),
  MockSpec<HiveCacheManager>(as: #MockICacheManager),
])
import 'metamask_cubit_test.mocks.dart';

// To run this test type in console:
// fvm flutter test test/unit/blocs/generic/metamask/metamask_cubit_test.dart --platform chrome --null-assertions
Future<void> main() async {
  late MockEthereumProvider mockEthereumProvider;
  late MockAuthCubit mockAuthCubit;
  late MockICacheManager mockCacheManager;
  const String testAddress = '0xb83DF76e62980BDb0E324FC9Ce3e7bAF6309E7b5';
  const int testChainId = 1;

  setUp(() async {
    mockEthereumProvider = MockEthereumProvider();
    mockAuthCubit = MockAuthCubit();
    mockCacheManager = MockICacheManager();
    globalLocator
      ..registerLazySingleton<EthereumProvider>(() => mockEthereumProvider)
      ..registerLazySingleton<AuthCubit>(() => mockAuthCubit)
      ..registerLazySingleton<ICacheManager>(() => mockCacheManager);

    when(mockEthereumProvider.isSupported).thenAnswer(
      (_) => true,
    );
    when(mockEthereumProvider.handleConnect(any)).thenAnswer((_) {});
    when(mockEthereumProvider.handleDisconnect(any)).thenAnswer((_) {});
    when(mockEthereumProvider.handleAccountsChanged(any)).thenAnswer((_) {});
    when(mockEthereumProvider.handleChainChanged(any)).thenAnswer((_) {});

    when(mockAuthCubit.signIn(any, defaultAddressIsKiraBool: anyNamed('defaultAddressIsKiraBool')))
        .thenAnswer((_) async {});
    when(mockAuthCubit.signOut()).thenAnswer((_) async {});

    when(mockCacheManager.get<String>(
      boxName: EthereumProvider.hiveBoxName,
      key: anyNamed('key'),
      defaultValue: anyNamed('defaultValue'),
    )).thenAnswer((_) {
      return '';
    });
  });

  tearDown(() async {
    await globalLocator.reset();
  });

  MetamaskCubit createCubit() => MetamaskCubit();

  group('Tests of [MetamaskCubit] process', () {
    group('Init', () {
      test('Init state', () async {
        final MetamaskCubit cubit = createCubit();

        expect(cubit.state, const MetamaskState());
      });

      blocTest<MetamaskCubit, MetamaskState>(
        'Init with supported provider',
        build: createCubit,
        act: (MetamaskCubit cubit) => cubit.init(),
        expect: () => <MetamaskState>[],
      );

      blocTest<MetamaskCubit, MetamaskState>(
        'Init with unsupported provider',
        build: createCubit,
        setUp: () {
          when(mockEthereumProvider.isSupported).thenAnswer(
            (_) => false,
          );
        },
        act: (MetamaskCubit cubit) => cubit.init(),
        expect: () => <MetamaskState>[],
      );
    });

    group('Connect', () {
      blocTest<MetamaskCubit, MetamaskState>(
        'with accounts',
        build: createCubit,
        setUp: () {
          when(mockEthereumProvider.requestAccount()).thenAnswer(
            (_) async => <String>[testAddress],
          );
          when(mockEthereumProvider.getChainId()).thenAnswer(
            (_) async => testChainId,
          );
          when(mockEthereumProvider.switchWalletChain(testChainId)).thenAnswer(
            (_) async {},
          );
        },
        act: (MetamaskCubit cubit) async {
          await Future<void>.delayed(Duration.zero);
          await cubit.connect();
        },
        expect: () => <MetamaskState>[
          const MetamaskState(isLoadingBool: true),
          const MetamaskState(
            address: testAddress,
            chainId: testChainId,
            isLoadingBool: true,
            needRequestForSignaturePermissionBool: true,
          ),
        ],
        verify: (MetamaskCubit cubit) {
          verifyNever(mockAuthCubit.signIn(any, defaultAddressIsKiraBool: false));
        },
      );

      blocTest<MetamaskCubit, MetamaskState>(
        'with accounts, and cached public key',
        build: createCubit,
        setUp: () {
          when(mockEthereumProvider.requestAccount()).thenAnswer(
            (_) async => <String>[testAddress],
          );
          when(mockEthereumProvider.getChainId()).thenAnswer(
            (_) async => testChainId,
          );
          when(mockEthereumProvider.switchWalletChain(testChainId)).thenAnswer(
            (_) async {},
          );
          when(mockCacheManager.get<String>(
            boxName: EthereumProvider.hiveBoxName,
            key: anyNamed('key'),
            defaultValue: anyNamed('defaultValue'),
          )).thenAnswer((_) => json.encode(TestUtils.ethereumSignatureDecodeResult.toDataJson()));
        },
        act: (MetamaskCubit cubit) async {
          await Future<void>.delayed(Duration.zero);
          await cubit.connect();
        },
        expect: () => <MetamaskState>[
          const MetamaskState(isLoadingBool: true),
          const MetamaskState(
            address: testAddress,
            chainId: testChainId,
            isLoadingBool: false,
            needRequestForSignaturePermissionBool: false,
          ),
        ],
        verify: (MetamaskCubit cubit) {
          verify(mockAuthCubit.signIn(any, defaultAddressIsKiraBool: false)).called(1);
        },
      );

      blocTest<MetamaskCubit, MetamaskState>(
        'with accounts, and Signature Explanation approved',
        build: createCubit,
        setUp: () {
          when(mockEthereumProvider.requestAccount()).thenAnswer(
            (_) async => <String>[testAddress],
          );
          when(mockEthereumProvider.getChainId()).thenAnswer(
            (_) async => testChainId,
          );
          when(mockEthereumProvider.switchWalletChain(testChainId)).thenAnswer(
            (_) async {},
          );
        },
        act: (MetamaskCubit cubit) async {
          await Future<void>.delayed(Duration.zero);
          await cubit.connect();
          await Future<void>.delayed(Duration.zero);
          await cubit.resolveUserSignatureApproval(isApproved: true);
        },
        skip: 2,
        expect: () => <MetamaskState>[
          const MetamaskState(
            address: testAddress,
            chainId: testChainId,
            isLoadingBool: true,
            needRequestForSignaturePermissionBool: false,
          ),
          const MetamaskState(
            address: testAddress,
            chainId: testChainId,
            isLoadingBool: false,
            needRequestForSignaturePermissionBool: false,
          ),
        ],
        verify: (MetamaskCubit cubit) {
          verify(mockAuthCubit.signIn(any, defaultAddressIsKiraBool: false)).called(1);
        },
      );

      blocTest<MetamaskCubit, MetamaskState>(
        'with accounts, and Signature Explanation cancelled',
        build: createCubit,
        setUp: () {
          when(mockEthereumProvider.requestAccount()).thenAnswer(
            (_) async => <String>[testAddress],
          );
          when(mockEthereumProvider.getChainId()).thenAnswer(
            (_) async => testChainId,
          );
          when(mockEthereumProvider.switchWalletChain(testChainId)).thenAnswer(
            (_) async {},
          );
        },
        act: (MetamaskCubit cubit) async {
          await Future<void>.delayed(Duration.zero);
          await cubit.connect();
          await Future<void>.delayed(Duration.zero);
          await cubit.resolveUserSignatureApproval(isApproved: false);
        },
        skip: 2,
        expect: () => <MetamaskState>[
          const MetamaskState(
            address: testAddress,
            chainId: testChainId,
            isLoadingBool: false,
            needRequestForSignaturePermissionBool: false,
          ),
        ],
        verify: (MetamaskCubit cubit) {
          verifyNever(mockAuthCubit.signIn(any, defaultAddressIsKiraBool: false));
        },
      );

      blocTest<MetamaskCubit, MetamaskState>(
        'with accounts but failed switch chain',
        build: createCubit,
        setUp: () {
          when(mockEthereumProvider.requestAccount()).thenAnswer(
            (_) async => <String>[testAddress],
          );
          when(mockEthereumProvider.getChainId()).thenAnswer(
            (_) async => testChainId,
          );
          when(mockEthereumProvider.switchWalletChain(testChainId)).thenAnswer(
            (_) async {
              throw Exception('Failed switch chain');
            },
          );
        },
        act: (MetamaskCubit cubit) => cubit.connect(),
        expect: () => <MetamaskState>[
          const MetamaskState(isLoadingBool: true),
          const MetamaskState(
            address: testAddress,
            chainId: testChainId,
            isLoadingBool: true,
            needRequestForSignaturePermissionBool: true,
          ),
        ],
        verify: (MetamaskCubit cubit) {
          verifyNever(mockAuthCubit.signIn(any, defaultAddressIsKiraBool: false));
        },
      );

      blocTest<MetamaskCubit, MetamaskState>(
        'with accounts but failed Switch chain, proceed to Add chain',
        build: createCubit,
        setUp: () {
          when(mockEthereumProvider.requestAccount()).thenAnswer(
            (_) async => <String>[testAddress],
          );
          when(mockEthereumProvider.getChainId()).thenAnswer(
            (_) async => testChainId,
          );
          when(mockEthereumProvider.switchWalletChain(testChainId)).thenAnswer(
            (_) async {
              throw EthereumException(4902, "chain doesn't exist", null);
            },
          );
          when(mockEthereumProvider.addWalletChain(
            chainId: anyNamed('chainId'),
            chainName: anyNamed('chainName'),
            nativeCurrencyName: anyNamed('nativeCurrencyName'),
            nativeCurrencySymbol: anyNamed('nativeCurrencySymbol'),
            nativeCurrencyDecimals: anyNamed('nativeCurrencyDecimals'),
            rpcUrl: anyNamed('rpcUrl'),
          )).thenAnswer(
            (_) async {},
          );
        },
        act: (MetamaskCubit cubit) => cubit.connect(),
        expect: () => <MetamaskState>[
          const MetamaskState(isLoadingBool: true),
          const MetamaskState(
            address: testAddress,
            chainId: testChainId,
            isLoadingBool: true,
            needRequestForSignaturePermissionBool: true,
          ),
        ],
        verify: (MetamaskCubit cubit) {
          verifyNever(mockAuthCubit.signIn(any, defaultAddressIsKiraBool: false));
        },
      );

      blocTest<MetamaskCubit, MetamaskState>(
        'without accounts',
        build: createCubit,
        setUp: () {
          when(mockEthereumProvider.requestAccount()).thenAnswer(
            (_) async => <String>[],
          );
          when(mockEthereumProvider.getChainId()).thenAnswer(
            (_) async => testChainId,
          );
        },
        act: (MetamaskCubit cubit) => cubit.connect(),
        seed: () => const MetamaskState(address: testAddress, chainId: testChainId),
        expect: () => <MetamaskState>[
          const MetamaskState(address: testAddress, chainId: testChainId, isLoadingBool: true),
          const MetamaskState(),
        ],
        verify: (MetamaskCubit cubit) {
          verify(mockAuthCubit.signOut()).called(1);
        },
      );

      blocTest<MetamaskCubit, MetamaskState>(
        'without chainId',
        build: createCubit,
        setUp: () {
          when(mockEthereumProvider.requestAccount()).thenAnswer(
            (_) async => <String>[testAddress],
          );
          when(mockEthereumProvider.getChainId()).thenAnswer(
            (_) async => null,
          );
        },
        act: (MetamaskCubit cubit) => cubit.connect(),
        seed: () => const MetamaskState(address: testAddress, chainId: testChainId),
        expect: () => <MetamaskState>[
          const MetamaskState(address: testAddress, chainId: testChainId, isLoadingBool: true),
          const MetamaskState(),
        ],
        verify: (MetamaskCubit cubit) {
          verify(mockAuthCubit.signOut()).called(1);
        },
      );

      blocTest<MetamaskCubit, MetamaskState>(
        'with error',
        build: createCubit,
        setUp: () {
          when(mockEthereumProvider.requestAccount()).thenThrow(
            Exception('Error'),
          );
        },
        act: (MetamaskCubit cubit) async {
          await Future<void>.delayed(Duration.zero);
          await cubit.connect();
        },
        seed: () => const MetamaskState(address: testAddress, chainId: 1),
        expect: () => <MetamaskState>[
          const MetamaskState(address: testAddress, chainId: testChainId, isLoadingBool: true),
          const MetamaskState(),
        ],
        verify: (MetamaskCubit cubit) {
          verify(mockAuthCubit.signOut()).called(1);
        },
      );
    });
  });
}
