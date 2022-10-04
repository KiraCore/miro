import 'package:flutter_test/flutter_test.dart';
import 'package:miro/infra/dto/api_cosmos/broadcast/response/broadcast_tx.dart';
import 'package:miro/infra/dto/api_cosmos/broadcast/response/event.dart';
import 'package:miro/shared/models/transactions/broadcast_error_model.dart';

void main() {
  // signature verification failed; please verify account number (669), sequence (144) and chain-id (testnet-9): unauthorized
  String unauthorizedLog =
      'github.com/cosmos/cosmos-sdk/x/auth/ante.SigVerificationDecorator.AnteHandle\n\t/home/go/pkg/mod/github.com/cosmos/cosmos-sdk@v0.44.5/x/auth/ante/sigverify.go:299\ngithub.com/cosmos/cosmos-sdk/types.ChainAnteDecorators.func1\n\t/home/go/pkg/mod/github.com/cosmos/cosmos-sdk@v0.44.5/types/handler.go:40\ngithub.com/cosmos/cosmos-sdk/x/auth/ante.SigGasConsumeDecorator.AnteHandle\n\t/home/go/pkg/mod/github.com/cosmos/cosmos-sdk@v0.44.5/x/auth/ante/sigverify.go:190\ngithub.com/cosmos/cosmos-sdk/types.ChainAnteDecorators.func1\n\t/home/go/pkg/mod/github.com/cosmos/cosmos-sdk@v0.44.5/types/handler.go:40\ngithub.com/KiraCore/sekai/app/ante.ExecutionFeeRegistrationDecorator.AnteHandle\n\t/home/go/src/github.com/kiracore/sekai/app/ante/ante.go:164\ngithub.com/cosmos/cosmos-sdk/types.ChainAnteDecorators.func1\n\t/home/go/pkg/mod/github.com/cosmos/cosmos-sdk@v0.44.5/types/handler.go:40\ngithub.com/KiraCore/sekai/app/ante.BlackWhiteTokensCheckDecorator.AnteHandle\n\t/home/go/src/github.com/kiracore/sekai/app/ante/ante.go:264\ngithub.com/cosmos/cosmos-sdk/types.ChainAnteDecorators.func1\n\t/home/go/pkg/mod/github.com/cosmos/cosmos-sdk@v0.44.5/types/handler.go:40\ngithub.com/KiraCore/sekai/app/ante.PoorNetworkManagementDecorator.AnteHandle\n\t/home/go/src/github.com/kiracore/sekai/app/ante/ante.go:201\ngithub.com/cosmos/cosmos-sdk/types.ChainAnteDecorators.func1\n\t/home/go/pkg/mod/github.com/cosmos/cosmos-sdk@v0.44.5/types/handler.go:40\ngithub.com/cosmos/cosmos-sdk/x/auth/ante.DeductFeeDecorator.AnteHandle\n\t/home/go/pkg/mod/github.com/cosmos/cosmos-sdk@v0.44.5/x/auth/ante/fee.go:125\ngithub.com/cosmos/cosmos-sdk/types.ChainAnteDecorators.func1\n\t/home/go/pkg/mod/github.com/cosmos/cosmos-sdk@v0.44.5/types/handler.go:40\ngithub.com/cosmos/cosmos-sdk/x/auth/ante.ValidateSigCountDecorator.AnteHandle\n\t/home/go/pkg/mod/github.com/cosmos/cosmos-sdk@v0.44.5/x/auth/ante/sigverify.go:381\ngithub.com/cosmos/cosmos-sdk/types.ChainAnteDecorators.func1\n\t/home/go/pkg/mod/github.com/cosmos/cosmos-sdk@v0.44.5/types/handler.go:40\ngithub.com/cosmos/cosmos-sdk/x/auth/ante.SetPubKeyDecorator.AnteHandle\n\t/home/go/pkg/mod/github.com/cosmos/cosmos-sdk@v0.44.5/x/auth/ante/sigverify.go:126\ngithub.com/cosmos/cosmos-sdk/types.ChainAnteDecorators.func1\n\t/home/go/pkg/mod/github.com/cosmos/cosmos-sdk@v0.44.5/types/handler.go:40\ngithub.com/KiraCore/sekai/app/ante.ValidateFeeRangeDecorator.AnteHandle\n\t/home/go/src/github.com/kiracore/sekai/app/ante/ante.go:130\ngithub.com/cosmos/cosmos-sdk/types.ChainAnteDecorators.func1\n\t/home/go/pkg/mod/github.com/cosmos/cosmos-sdk@v0.44.5/types/handler.go:40\ngithub.com/cosmos/cosmos-sdk/x/auth/ante.ConsumeTxSizeGasDecorator.AnteHandle\n\t/home/go/pkg/mod/github.com/cosmos/cosmos-sdk@v0.44.5/x/auth/ante/basic.go:142\ngithub.com/cosmos/cosmos-sdk/types.ChainAnteDecorators.func1\n\t/home/go/pkg/mod/github.com/cosmos/cosmos-sdk@v0.44.5/types/handler.go:40\ngithub.com/cosmos/cosmos-sdk/x/auth/ante.ValidateMemoDecorator.AnteHandle\n\t/home/go/pkg/mod/github.com/cosmos/cosmos-sdk@v0.44.5/x/auth/ante/basic.go:66\ngithub.com/cosmos/cosmos-sdk/types.ChainAnteDecorators.func1\n\t/home/go/pkg/mod/github.com/cosmos/cosmos-sdk@v0.44.5/types/handler.go:40\ngithub.com/cosmos/cosmos-sdk/x/auth/ante.TxTimeoutHeightDecorator.AnteHandle\n\t/home/go/pkg/mod/github.com/cosmos/cosmos-sdk@v0.44.5/x/auth/ante/basic.go:205\ngithub.com/cosmos/cosmos-sdk/types.ChainAnteDecorators.func1\n\t/home/go/pkg/mod/github.com/cosmos/cosmos-sdk@v0.44.5/types/handler.go:40\ngithub.com/cosmos/cosmos-sdk/x/auth/ante.ValidateBasicDecorator.AnteHandle\n\t/home/go/pkg/mod/github.com/cosmos/cosmos-sdk@v0.44.5/x/auth/ante/basic.go:34\ngithub.com/cosmos/cosmos-sdk/types.ChainAnteDecorators.func1\n\t/home/go/pkg/mod/github.com/cosmos/cosmos-sdk@v0.44.5/types/handler.go:40\ngithub.com/cosmos/cosmos-sdk/x/auth/ante.MempoolFeeDecorator.AnteHandle\n\t/home/go/pkg/mod/github.com/cosmos/cosmos-sdk@v0.44.5/x/auth/ante/fee.go:54\ngithub.com/cosmos/cosmos-sdk/types.ChainAnteDecorators.func1\n\t/home/go/pkg/mod/github.com/cosmos/cosmos-sdk@v0.44.5/types/handler.go:40\ngithub.com/cosmos/cosmos-sdk/x/auth/ante.RejectExtensionOptionsDecorator.AnteHandle\n\t/home/go/pkg/mod/github.com/cosmos/cosmos-sdk@v0.44.5/x/auth/ante/ext.go:35\ngithub.com/cosmos/cosmos-sdk/types.ChainAnteDecorators.func1\n\t/home/go/pkg/mod/github.com/cosmos/cosmos-sdk@v0.44.5/types/handler.go:40\ngithub.com/KiraCore/sekai/app/ante.ZeroGasMeterDecorator.AnteHandle\n\t/home/go/src/github.com/kiracore/sekai/app/ante/ante.go:277\nsignature verification failed; please verify account number (669), sequence (144) and chain-id (testnet-9): unauthorized';
  BroadcastTx unauthorizedBroadcastTx = BroadcastTx(
    code: 4,
    codespace: 'sdk',
    events: <Event>[],
    gasUsed: '0',
    gasWanted: '0',
    info: '',
    log: unauthorizedLog,
  );

  // account sequence mismatch, expected 144, got 0: incorrect account sequence
  String incorrectAccountSequenceLog =
      'github.com/cosmos/cosmos-sdk/x/auth/ante.SigVerificationDecorator.AnteHandle\n\t/home/go/pkg/mod/github.com/cosmos/cosmos-sdk@v0.44.5/x/auth/ante/sigverify.go:269\ngithub.com/cosmos/cosmos-sdk/types.ChainAnteDecorators.func1\n\t/home/go/pkg/mod/github.com/cosmos/cosmos-sdk@v0.44.5/types/handler.go:40\ngithub.com/cosmos/cosmos-sdk/x/auth/ante.SigGasConsumeDecorator.AnteHandle\n\t/home/go/pkg/mod/github.com/cosmos/cosmos-sdk@v0.44.5/x/auth/ante/sigverify.go:190\ngithub.com/cosmos/cosmos-sdk/types.ChainAnteDecorators.func1\n\t/home/go/pkg/mod/github.com/cosmos/cosmos-sdk@v0.44.5/types/handler.go:40\ngithub.com/KiraCore/sekai/app/ante.ExecutionFeeRegistrationDecorator.AnteHandle\n\t/home/go/src/github.com/kiracore/sekai/app/ante/ante.go:164\ngithub.com/cosmos/cosmos-sdk/types.ChainAnteDecorators.func1\n\t/home/go/pkg/mod/github.com/cosmos/cosmos-sdk@v0.44.5/types/handler.go:40\ngithub.com/KiraCore/sekai/app/ante.BlackWhiteTokensCheckDecorator.AnteHandle\n\t/home/go/src/github.com/kiracore/sekai/app/ante/ante.go:264\ngithub.com/cosmos/cosmos-sdk/types.ChainAnteDecorators.func1\n\t/home/go/pkg/mod/github.com/cosmos/cosmos-sdk@v0.44.5/types/handler.go:40\ngithub.com/KiraCore/sekai/app/ante.PoorNetworkManagementDecorator.AnteHandle\n\t/home/go/src/github.com/kiracore/sekai/app/ante/ante.go:201\ngithub.com/cosmos/cosmos-sdk/types.ChainAnteDecorators.func1\n\t/home/go/pkg/mod/github.com/cosmos/cosmos-sdk@v0.44.5/types/handler.go:40\ngithub.com/cosmos/cosmos-sdk/x/auth/ante.DeductFeeDecorator.AnteHandle\n\t/home/go/pkg/mod/github.com/cosmos/cosmos-sdk@v0.44.5/x/auth/ante/fee.go:125\ngithub.com/cosmos/cosmos-sdk/types.ChainAnteDecorators.func1\n\t/home/go/pkg/mod/github.com/cosmos/cosmos-sdk@v0.44.5/types/handler.go:40\ngithub.com/cosmos/cosmos-sdk/x/auth/ante.ValidateSigCountDecorator.AnteHandle\n\t/home/go/pkg/mod/github.com/cosmos/cosmos-sdk@v0.44.5/x/auth/ante/sigverify.go:381\ngithub.com/cosmos/cosmos-sdk/types.ChainAnteDecorators.func1\n\t/home/go/pkg/mod/github.com/cosmos/cosmos-sdk@v0.44.5/types/handler.go:40\ngithub.com/cosmos/cosmos-sdk/x/auth/ante.SetPubKeyDecorator.AnteHandle\n\t/home/go/pkg/mod/github.com/cosmos/cosmos-sdk@v0.44.5/x/auth/ante/sigverify.go:126\ngithub.com/cosmos/cosmos-sdk/types.ChainAnteDecorators.func1\n\t/home/go/pkg/mod/github.com/cosmos/cosmos-sdk@v0.44.5/types/handler.go:40\ngithub.com/KiraCore/sekai/app/ante.ValidateFeeRangeDecorator.AnteHandle\n\t/home/go/src/github.com/kiracore/sekai/app/ante/ante.go:130\ngithub.com/cosmos/cosmos-sdk/types.ChainAnteDecorators.func1\n\t/home/go/pkg/mod/github.com/cosmos/cosmos-sdk@v0.44.5/types/handler.go:40\ngithub.com/cosmos/cosmos-sdk/x/auth/ante.ConsumeTxSizeGasDecorator.AnteHandle\n\t/home/go/pkg/mod/github.com/cosmos/cosmos-sdk@v0.44.5/x/auth/ante/basic.go:142\ngithub.com/cosmos/cosmos-sdk/types.ChainAnteDecorators.func1\n\t/home/go/pkg/mod/github.com/cosmos/cosmos-sdk@v0.44.5/types/handler.go:40\ngithub.com/cosmos/cosmos-sdk/x/auth/ante.ValidateMemoDecorator.AnteHandle\n\t/home/go/pkg/mod/github.com/cosmos/cosmos-sdk@v0.44.5/x/auth/ante/basic.go:66\ngithub.com/cosmos/cosmos-sdk/types.ChainAnteDecorators.func1\n\t/home/go/pkg/mod/github.com/cosmos/cosmos-sdk@v0.44.5/types/handler.go:40\ngithub.com/cosmos/cosmos-sdk/x/auth/ante.TxTimeoutHeightDecorator.AnteHandle\n\t/home/go/pkg/mod/github.com/cosmos/cosmos-sdk@v0.44.5/x/auth/ante/basic.go:205\ngithub.com/cosmos/cosmos-sdk/types.ChainAnteDecorators.func1\n\t/home/go/pkg/mod/github.com/cosmos/cosmos-sdk@v0.44.5/types/handler.go:40\ngithub.com/cosmos/cosmos-sdk/x/auth/ante.ValidateBasicDecorator.AnteHandle\n\t/home/go/pkg/mod/github.com/cosmos/cosmos-sdk@v0.44.5/x/auth/ante/basic.go:34\ngithub.com/cosmos/cosmos-sdk/types.ChainAnteDecorators.func1\n\t/home/go/pkg/mod/github.com/cosmos/cosmos-sdk@v0.44.5/types/handler.go:40\ngithub.com/cosmos/cosmos-sdk/x/auth/ante.MempoolFeeDecorator.AnteHandle\n\t/home/go/pkg/mod/github.com/cosmos/cosmos-sdk@v0.44.5/x/auth/ante/fee.go:54\ngithub.com/cosmos/cosmos-sdk/types.ChainAnteDecorators.func1\n\t/home/go/pkg/mod/github.com/cosmos/cosmos-sdk@v0.44.5/types/handler.go:40\ngithub.com/cosmos/cosmos-sdk/x/auth/ante.RejectExtensionOptionsDecorator.AnteHandle\n\t/home/go/pkg/mod/github.com/cosmos/cosmos-sdk@v0.44.5/x/auth/ante/ext.go:35\ngithub.com/cosmos/cosmos-sdk/types.ChainAnteDecorators.func1\n\t/home/go/pkg/mod/github.com/cosmos/cosmos-sdk@v0.44.5/types/handler.go:40\naccount sequence mismatch, expected 144, got 0: incorrect account sequence';
  BroadcastTx incorrectAccountSequenceBroadcastTx = BroadcastTx(
    code: 32,
    codespace: 'sdk',
    events: <Event>[],
    gasUsed: '0',
    gasWanted: '0',
    info: '',
    log: incorrectAccountSequenceLog,
  );

  // failed to execute message; message index: 0: 929279ukex is smaller than 1000000000000000000ukex: insufficient funds
  String insufficientFundsLog =
      'github.com/cosmos/cosmos-sdk/x/bank/keeper.BaseSendKeeper.subUnlockedCoins\n\n/home/go/pkg/mod/github.com/cosmos/cosmos-sdk@v0.44.5/x/bank/keeper/send.go:187\ngithub.com/cosmos/cosmos-sdk/x/bank/keeper.BaseSendKeeper.SendCoins\n\n/home/go/pkg/mod/github.com/cosmos/cosmos-sdk@v0.44.5/x/bank/keeper/send.go:134\ngithub.com/cosmos/cosmos-sdk/x/bank/keeper.msgServer.Send\n\n/home/go/pkg/mod/github.com/cosmos/cosmos-sdk@v0.44.5/x/bank/keeper/msg_server.go:46\ngithub.com/cosmos/cosmos-sdk/x/bank/types._Msg_Send_Handler.func1\n\n/home/go/pkg/mod/github.com/cosmos/cosmos-sdk@v0.44.5/x/bank/types/tx.pb.go:321\ngithub.com/cosmos/cosmos-sdk/baseapp.(*MsgServiceRouter).RegisterService.func2.1\n\n/home/go/pkg/mod/github.com/cosmos/cosmos-sdk@v0.44.5/baseapp/msg_service_router.go:113\ngithub.com/cosmos/cosmos-sdk/x/bank/types._Msg_Send_Handler\n\n/home/go/pkg/mod/github.com/cosmos/cosmos-sdk@v0.44.5/x/bank/types/tx.pb.go:323\ngithub.com/cosmos/cosmos-sdk/baseapp.(*MsgServiceRouter).RegisterService.func2\n\n/home/go/pkg/mod/github.com/cosmos/cosmos-sdk@v0.44.5/baseapp/msg_service_router.go:117\ngithub.com/cosmos/cosmos-sdk/baseapp.(*BaseApp).runMsgs\n\n/home/go/pkg/mod/github.com/cosmos/cosmos-sdk@v0.44.5/baseapp/baseapp.go:719\ngithub.com/cosmos/cosmos-sdk/baseapp.(*BaseApp).runTx\n\n/home/go/pkg/mod/github.com/cosmos/cosmos-sdk@v0.44.5/baseapp/baseapp.go:679\ngithub.com/cosmos/cosmos-sdk/baseapp.(*BaseApp).DeliverTx\n\n/home/go/pkg/mod/github.com/cosmos/cosmos-sdk@v0.44.5/baseapp/abci.go:275\ngithub.com/tendermint/tendermint/abci/client.(*localClient).DeliverTxAsync\n\n/home/go/pkg/mod/github.com/tendermint/tendermint@v0.34.14/abci/client/local_client.go:93\ngithub.com/tendermint/tendermint/proxy.(*appConnConsensus).DeliverTxAsync\n\n/home/go/pkg/mod/github.com/tendermint/tendermint@v0.34.14/proxy/app_conn.go:85\ngithub.com/tendermint/tendermint/state.execBlockOnProxyApp\n\n/home/go/pkg/mod/github.com/tendermint/tendermint@v0.34.14/state/execution.go:320\ngithub.com/tendermint/tendermint/state.(*BlockExecutor).ApplyBlock\n\n/home/go/pkg/mod/github.com/tendermint/tendermint@v0.34.14/state/execution.go:140\ngithub.com/tendermint/tendermint/consensus.(*State).finalizeCommit\n\n/home/go/pkg/mod/github.com/tendermint/tendermint@v0.34.14/consensus/state.go:1635\ngithub.com/tendermint/tendermint/consensus.(*State).tryFinalizeCommit\n\n/home/go/pkg/mod/github.com/tendermint/tendermint@v0.34.14/consensus/state.go:1546\ngithub.com/tendermint/tendermint/consensus.(*State).enterCommit.func1\n\n/home/go/pkg/mod/github.com/tendermint/tendermint@v0.34.14/consensus/state.go:1481\ngithub.com/tendermint/tendermint/consensus.(*State).enterCommit\n\n/home/go/pkg/mod/github.com/tendermint/tendermint@v0.34.14/consensus/state.go:1519\ngithub.com/tendermint/tendermint/consensus.(*State).addVote\n\n/home/go/pkg/mod/github.com/tendermint/tendermint@v0.34.14/consensus/state.go:2132\ngithub.com/tendermint/tendermint/consensus.(*State).tryAddVote\n\n/home/go/pkg/mod/github.com/tendermint/tendermint@v0.34.14/consensus/state.go:1930\ngithub.com/tendermint/tendermint/consensus.(*State).handleMsg\n\n/home/go/pkg/mod/github.com/tendermint/tendermint@v0.34.14/consensus/state.go:838\ngithub.com/tendermint/tendermint/consensus.(*State).receiveRoutine\n\n/home/go/pkg/mod/github.com/tendermint/tendermint@v0.34.14/consensus/state.go:762\nfailed to execute message; message index: 0: 929279ukex is smaller than 1000000000000000000ukex: insufficient funds';
  BroadcastTx insufficientFundsBroadcastTx = BroadcastTx(
    code: 5,
    codespace: 'sdk',
    events: <Event>[],
    gasUsed: '0',
    gasWanted: '0',
    info: '',
    log: insufficientFundsLog,
  );

  group('Tests for UNAUTHORIZED error', () {
    BroadcastErrorModel? actualBroadcastErrorModel = BroadcastErrorModel.fromDto(unauthorizedBroadcastTx);

    test('Should return "UNAUTHORIZED" as an error name', () {
      expect(actualBroadcastErrorModel?.name, 'UNAUTHORIZED');
    });

    test('Should return "UNAUTHORIZED" error message', () {
      expect(actualBroadcastErrorModel?.message,
          'Signature verification failed\nPlease verify account number (669), sequence (144) and chain-id (testnet-9)');
    });
  });

  group('Tests for INCORRECT_ACCOUNT_SEQUENCE error', () {
    BroadcastErrorModel? actualBroadcastErrorModel = BroadcastErrorModel.fromDto(incorrectAccountSequenceBroadcastTx);

    test('Should return "INCORRECT_ACCOUNT_SEQUENCE" as an error name', () {
      expect(actualBroadcastErrorModel?.name, 'INCORRECT_ACCOUNT_SEQUENCE');
    });

    test('Should return "INCORRECT_ACCOUNT_SEQUENCE" error message', () {
      expect(actualBroadcastErrorModel?.message, 'Account sequence mismatch, expected 144, got 0');
    });
  });

  group('Tests for INSUFFICIENT_FUNDS error', () {
    BroadcastErrorModel? actualBroadcastErrorModel = BroadcastErrorModel.fromDto(insufficientFundsBroadcastTx);

    test('Should return "INSUFFICIENT_FUNDS" as an error name', () {
      expect(actualBroadcastErrorModel?.name, 'INSUFFICIENT_FUNDS');
    });

    test('Should return "INSUFFICIENT_FUNDS" error message', () {
      expect(actualBroadcastErrorModel?.message, 'Failed to execute message\nMessage index: 0: 929279ukex is smaller than 1000000000000000000ukex');
    });
  });
}
