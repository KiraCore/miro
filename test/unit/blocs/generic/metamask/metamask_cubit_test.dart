import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_web3/ethereum.dart';
import 'package:miro/blocs/generic/auth/auth_cubit.dart';
import 'package:miro/blocs/generic/metamask/ethereum_provider.dart';
import 'package:miro/blocs/generic/metamask/metamask_cubit.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/shared/models/wallet/address/a_wallet_address.dart';
import 'package:miro/shared/models/wallet/wallet.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

@GenerateNiceMocks(<MockSpec<dynamic>>[
  MockSpec<EthereumProvider>(),
  MockSpec<AuthCubit>(),
])
import 'metamask_cubit_test.mocks.dart';

// To run this test type in console:
// fvm flutter test test/unit/blocs/generic/metamask_cubit_test.dart --platform chrome --null-assertions
Future<void> main() async {
  late MockEthereumProvider mockEthereumProvider;
  late MockAuthCubit mockAuthCubit;
  const String testAddress = '0x1234567890abcdef';
  const int testChainId = 1;

  setUp(() async {
    mockEthereumProvider = MockEthereumProvider();
    mockAuthCubit = MockAuthCubit();
    globalLocator
      ..registerLazySingleton<EthereumProvider>(() => mockEthereumProvider)
      ..registerLazySingleton<AuthCubit>(() => mockAuthCubit);

    when(mockEthereumProvider.isSupported).thenAnswer(
      (_) => true,
    );
    when(mockEthereumProvider.handleConnect(any)).thenAnswer((_) {});
    when(mockEthereumProvider.handleDisconnect(any)).thenAnswer((_) {});
    when(mockEthereumProvider.handleAccountsChanged(any)).thenAnswer((_) {});
    when(mockEthereumProvider.handleChainChanged(any)).thenAnswer((_) {});

    when(mockAuthCubit.signIn(any)).thenAnswer((_) async {});
    when(mockAuthCubit.signOut()).thenAnswer((_) async {});
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
        act: (MetamaskCubit cubit) => cubit.connect(),
        expect: () => <MetamaskState>[
          const MetamaskState(address: testAddress, chainId: testChainId),
        ],
        verify: (MetamaskCubit cubit) {
          verify(mockAuthCubit.signIn(any)).called(1);
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
          const MetamaskState(address: testAddress, chainId: testChainId),
        ],
        verify: (MetamaskCubit cubit) {
          verify(mockAuthCubit.signIn(any)).called(1);
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
          const MetamaskState(address: testAddress, chainId: testChainId),
        ],
        verify: (MetamaskCubit cubit) {
          verify(mockAuthCubit.signIn(
            Wallet(address: AWalletAddress.fromAddress(testAddress)),
          )).called(1);
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
        act: (MetamaskCubit cubit) => cubit.connect(),
        seed: () => const MetamaskState(address: testAddress, chainId: 1),
        expect: () => <MetamaskState>[
          const MetamaskState(),
        ],
        verify: (MetamaskCubit cubit) {
          verify(mockAuthCubit.signOut()).called(1);
        },
      );
    });
  });
}
