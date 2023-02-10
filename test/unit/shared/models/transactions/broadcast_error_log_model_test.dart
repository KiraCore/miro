import 'package:flutter_test/flutter_test.dart';
import 'package:miro/infra/dto/api_kira/broadcast/response/broadcast_tx.dart';
import 'package:miro/infra/dto/api_kira/broadcast/response/event.dart';
import 'package:miro/shared/models/transactions/broadcast_error_log_model.dart';

void main() {
  // signature verification failed; please verify account number (669), sequence (144) and chain-id (testnet-9): unauthorized
  String unauthorizedLog =
      'github.com/cosmos/cosmos-sdk/x/auth/ante.SigVerificationDecorator.AnteHandle\n\t/home/go/pkg/mod/github.com/cosmos/cosmos-sdk@v0.44.5/x/auth/ante/sigverify.go:299\ngithub.com/cosmos/cosmos-sdk/types.ChainAnteDecorators.func1\n\t/home/go/pkg/mod/github.com/cosmos/cosmos-sdk@v0.44.5/types/handler.go:40\ngithub.com/cosmos/cosmos-sdk/x/auth/ante.SigGasConsumeDecorator.AnteHandle\n\t/home/go/pkg/mod/github.com/cosmos/cosmos-sdk@v0.44.5/x/auth/ante/sigverify.go:190\ngithub.com/cosmos/cosmos-sdk/types.ChainAnteDecorators.func1\n\t/home/go/pkg/mod/github.com/cosmos/cosmos-sdk@v0.44.5/types/handler.go:40\ngithub.com/KiraCore/sekai/app/ante.ExecutionFeeRegistrationDecorator.AnteHandle\n\t/home/go/src/github.com/kiracore/sekai/app/ante/ante.go:164\ngithub.com/cosmos/cosmos-sdk/types.ChainAnteDecorators.func1\n\t/home/go/pkg/mod/github.com/cosmos/cosmos-sdk@v0.44.5/types/handler.go:40\ngithub.com/KiraCore/sekai/app/ante.BlackWhiteTokensCheckDecorator.AnteHandle\n\t/home/go/src/github.com/kiracore/sekai/app/ante/ante.go:264\ngithub.com/cosmos/cosmos-sdk/types.ChainAnteDecorators.func1\n\t/home/go/pkg/mod/github.com/cosmos/cosmos-sdk@v0.44.5/types/handler.go:40\ngithub.com/KiraCore/sekai/app/ante.PoorNetworkManagementDecorator.AnteHandle\n\t/home/go/src/github.com/kiracore/sekai/app/ante/ante.go:201\ngithub.com/cosmos/cosmos-sdk/types.ChainAnteDecorators.func1\n\t/home/go/pkg/mod/github.com/cosmos/cosmos-sdk@v0.44.5/types/handler.go:40\ngithub.com/cosmos/cosmos-sdk/x/auth/ante.DeductFeeDecorator.AnteHandle\n\t/home/go/pkg/mod/github.com/cosmos/cosmos-sdk@v0.44.5/x/auth/ante/fee.go:125\ngithub.com/cosmos/cosmos-sdk/types.ChainAnteDecorators.func1\n\t/home/go/pkg/mod/github.com/cosmos/cosmos-sdk@v0.44.5/types/handler.go:40\ngithub.com/cosmos/cosmos-sdk/x/auth/ante.ValidateSigCountDecorator.AnteHandle\n\t/home/go/pkg/mod/github.com/cosmos/cosmos-sdk@v0.44.5/x/auth/ante/sigverify.go:381\ngithub.com/cosmos/cosmos-sdk/types.ChainAnteDecorators.func1\n\t/home/go/pkg/mod/github.com/cosmos/cosmos-sdk@v0.44.5/types/handler.go:40\ngithub.com/cosmos/cosmos-sdk/x/auth/ante.SetPubKeyDecorator.AnteHandle\n\t/home/go/pkg/mod/github.com/cosmos/cosmos-sdk@v0.44.5/x/auth/ante/sigverify.go:126\ngithub.com/cosmos/cosmos-sdk/types.ChainAnteDecorators.func1\n\t/home/go/pkg/mod/github.com/cosmos/cosmos-sdk@v0.44.5/types/handler.go:40\ngithub.com/KiraCore/sekai/app/ante.ValidateFeeRangeDecorator.AnteHandle\n\t/home/go/src/github.com/kiracore/sekai/app/ante/ante.go:130\ngithub.com/cosmos/cosmos-sdk/types.ChainAnteDecorators.func1\n\t/home/go/pkg/mod/github.com/cosmos/cosmos-sdk@v0.44.5/types/handler.go:40\ngithub.com/cosmos/cosmos-sdk/x/auth/ante.ConsumeTxSizeGasDecorator.AnteHandle\n\t/home/go/pkg/mod/github.com/cosmos/cosmos-sdk@v0.44.5/x/auth/ante/basic.go:142\ngithub.com/cosmos/cosmos-sdk/types.ChainAnteDecorators.func1\n\t/home/go/pkg/mod/github.com/cosmos/cosmos-sdk@v0.44.5/types/handler.go:40\ngithub.com/cosmos/cosmos-sdk/x/auth/ante.ValidateMemoDecorator.AnteHandle\n\t/home/go/pkg/mod/github.com/cosmos/cosmos-sdk@v0.44.5/x/auth/ante/basic.go:66\ngithub.com/cosmos/cosmos-sdk/types.ChainAnteDecorators.func1\n\t/home/go/pkg/mod/github.com/cosmos/cosmos-sdk@v0.44.5/types/handler.go:40\ngithub.com/cosmos/cosmos-sdk/x/auth/ante.TxTimeoutHeightDecorator.AnteHandle\n\t/home/go/pkg/mod/github.com/cosmos/cosmos-sdk@v0.44.5/x/auth/ante/basic.go:205\ngithub.com/cosmos/cosmos-sdk/types.ChainAnteDecorators.func1\n\t/home/go/pkg/mod/github.com/cosmos/cosmos-sdk@v0.44.5/types/handler.go:40\ngithub.com/cosmos/cosmos-sdk/x/auth/ante.ValidateBasicDecorator.AnteHandle\n\t/home/go/pkg/mod/github.com/cosmos/cosmos-sdk@v0.44.5/x/auth/ante/basic.go:34\ngithub.com/cosmos/cosmos-sdk/types.ChainAnteDecorators.func1\n\t/home/go/pkg/mod/github.com/cosmos/cosmos-sdk@v0.44.5/types/handler.go:40\ngithub.com/cosmos/cosmos-sdk/x/auth/ante.MempoolFeeDecorator.AnteHandle\n\t/home/go/pkg/mod/github.com/cosmos/cosmos-sdk@v0.44.5/x/auth/ante/fee.go:54\ngithub.com/cosmos/cosmos-sdk/types.ChainAnteDecorators.func1\n\t/home/go/pkg/mod/github.com/cosmos/cosmos-sdk@v0.44.5/types/handler.go:40\ngithub.com/cosmos/cosmos-sdk/x/auth/ante.RejectExtensionOptionsDecorator.AnteHandle\n\t/home/go/pkg/mod/github.com/cosmos/cosmos-sdk@v0.44.5/x/auth/ante/ext.go:35\ngithub.com/cosmos/cosmos-sdk/types.ChainAnteDecorators.func1\n\t/home/go/pkg/mod/github.com/cosmos/cosmos-sdk@v0.44.5/types/handler.go:40\ngithub.com/KiraCore/sekai/app/ante.ZeroGasMeterDecorator.AnteHandle\n\t/home/go/src/github.com/kiracore/sekai/app/ante/ante.go:277\nsignature verification failed; please verify account number (669), sequence (144) and chain-id (testnet-9): unauthorized';
  BroadcastTx unauthorizedBroadcastTx = BroadcastTx(
    code: 4,
    codespace: 'sdk',
    events: const <Event>[],
    info: '',
    log: unauthorizedLog,
  );

  // account sequence mismatch, expected 144, got 0: incorrect account sequence
  String incorrectAccountSequenceLog =
      'github.com/cosmos/cosmos-sdk/x/auth/ante.SigVerificationDecorator.AnteHandle\n\t/home/go/pkg/mod/github.com/cosmos/cosmos-sdk@v0.44.5/x/auth/ante/sigverify.go:269\ngithub.com/cosmos/cosmos-sdk/types.ChainAnteDecorators.func1\n\t/home/go/pkg/mod/github.com/cosmos/cosmos-sdk@v0.44.5/types/handler.go:40\ngithub.com/cosmos/cosmos-sdk/x/auth/ante.SigGasConsumeDecorator.AnteHandle\n\t/home/go/pkg/mod/github.com/cosmos/cosmos-sdk@v0.44.5/x/auth/ante/sigverify.go:190\ngithub.com/cosmos/cosmos-sdk/types.ChainAnteDecorators.func1\n\t/home/go/pkg/mod/github.com/cosmos/cosmos-sdk@v0.44.5/types/handler.go:40\ngithub.com/KiraCore/sekai/app/ante.ExecutionFeeRegistrationDecorator.AnteHandle\n\t/home/go/src/github.com/kiracore/sekai/app/ante/ante.go:164\ngithub.com/cosmos/cosmos-sdk/types.ChainAnteDecorators.func1\n\t/home/go/pkg/mod/github.com/cosmos/cosmos-sdk@v0.44.5/types/handler.go:40\ngithub.com/KiraCore/sekai/app/ante.BlackWhiteTokensCheckDecorator.AnteHandle\n\t/home/go/src/github.com/kiracore/sekai/app/ante/ante.go:264\ngithub.com/cosmos/cosmos-sdk/types.ChainAnteDecorators.func1\n\t/home/go/pkg/mod/github.com/cosmos/cosmos-sdk@v0.44.5/types/handler.go:40\ngithub.com/KiraCore/sekai/app/ante.PoorNetworkManagementDecorator.AnteHandle\n\t/home/go/src/github.com/kiracore/sekai/app/ante/ante.go:201\ngithub.com/cosmos/cosmos-sdk/types.ChainAnteDecorators.func1\n\t/home/go/pkg/mod/github.com/cosmos/cosmos-sdk@v0.44.5/types/handler.go:40\ngithub.com/cosmos/cosmos-sdk/x/auth/ante.DeductFeeDecorator.AnteHandle\n\t/home/go/pkg/mod/github.com/cosmos/cosmos-sdk@v0.44.5/x/auth/ante/fee.go:125\ngithub.com/cosmos/cosmos-sdk/types.ChainAnteDecorators.func1\n\t/home/go/pkg/mod/github.com/cosmos/cosmos-sdk@v0.44.5/types/handler.go:40\ngithub.com/cosmos/cosmos-sdk/x/auth/ante.ValidateSigCountDecorator.AnteHandle\n\t/home/go/pkg/mod/github.com/cosmos/cosmos-sdk@v0.44.5/x/auth/ante/sigverify.go:381\ngithub.com/cosmos/cosmos-sdk/types.ChainAnteDecorators.func1\n\t/home/go/pkg/mod/github.com/cosmos/cosmos-sdk@v0.44.5/types/handler.go:40\ngithub.com/cosmos/cosmos-sdk/x/auth/ante.SetPubKeyDecorator.AnteHandle\n\t/home/go/pkg/mod/github.com/cosmos/cosmos-sdk@v0.44.5/x/auth/ante/sigverify.go:126\ngithub.com/cosmos/cosmos-sdk/types.ChainAnteDecorators.func1\n\t/home/go/pkg/mod/github.com/cosmos/cosmos-sdk@v0.44.5/types/handler.go:40\ngithub.com/KiraCore/sekai/app/ante.ValidateFeeRangeDecorator.AnteHandle\n\t/home/go/src/github.com/kiracore/sekai/app/ante/ante.go:130\ngithub.com/cosmos/cosmos-sdk/types.ChainAnteDecorators.func1\n\t/home/go/pkg/mod/github.com/cosmos/cosmos-sdk@v0.44.5/types/handler.go:40\ngithub.com/cosmos/cosmos-sdk/x/auth/ante.ConsumeTxSizeGasDecorator.AnteHandle\n\t/home/go/pkg/mod/github.com/cosmos/cosmos-sdk@v0.44.5/x/auth/ante/basic.go:142\ngithub.com/cosmos/cosmos-sdk/types.ChainAnteDecorators.func1\n\t/home/go/pkg/mod/github.com/cosmos/cosmos-sdk@v0.44.5/types/handler.go:40\ngithub.com/cosmos/cosmos-sdk/x/auth/ante.ValidateMemoDecorator.AnteHandle\n\t/home/go/pkg/mod/github.com/cosmos/cosmos-sdk@v0.44.5/x/auth/ante/basic.go:66\ngithub.com/cosmos/cosmos-sdk/types.ChainAnteDecorators.func1\n\t/home/go/pkg/mod/github.com/cosmos/cosmos-sdk@v0.44.5/types/handler.go:40\ngithub.com/cosmos/cosmos-sdk/x/auth/ante.TxTimeoutHeightDecorator.AnteHandle\n\t/home/go/pkg/mod/github.com/cosmos/cosmos-sdk@v0.44.5/x/auth/ante/basic.go:205\ngithub.com/cosmos/cosmos-sdk/types.ChainAnteDecorators.func1\n\t/home/go/pkg/mod/github.com/cosmos/cosmos-sdk@v0.44.5/types/handler.go:40\ngithub.com/cosmos/cosmos-sdk/x/auth/ante.ValidateBasicDecorator.AnteHandle\n\t/home/go/pkg/mod/github.com/cosmos/cosmos-sdk@v0.44.5/x/auth/ante/basic.go:34\ngithub.com/cosmos/cosmos-sdk/types.ChainAnteDecorators.func1\n\t/home/go/pkg/mod/github.com/cosmos/cosmos-sdk@v0.44.5/types/handler.go:40\ngithub.com/cosmos/cosmos-sdk/x/auth/ante.MempoolFeeDecorator.AnteHandle\n\t/home/go/pkg/mod/github.com/cosmos/cosmos-sdk@v0.44.5/x/auth/ante/fee.go:54\ngithub.com/cosmos/cosmos-sdk/types.ChainAnteDecorators.func1\n\t/home/go/pkg/mod/github.com/cosmos/cosmos-sdk@v0.44.5/types/handler.go:40\ngithub.com/cosmos/cosmos-sdk/x/auth/ante.RejectExtensionOptionsDecorator.AnteHandle\n\t/home/go/pkg/mod/github.com/cosmos/cosmos-sdk@v0.44.5/x/auth/ante/ext.go:35\ngithub.com/cosmos/cosmos-sdk/types.ChainAnteDecorators.func1\n\t/home/go/pkg/mod/github.com/cosmos/cosmos-sdk@v0.44.5/types/handler.go:40\naccount sequence mismatch, expected 144, got 0: incorrect account sequence';
  BroadcastTx incorrectAccountSequenceBroadcastTx = BroadcastTx(
    code: 32,
    codespace: 'sdk',
    events: const <Event>[],
    info: '',
    log: incorrectAccountSequenceLog,
  );

  // failed to execute message; message index: 0: 929279ukex is smaller than 1000000000000000000ukex: insufficient funds
  String insufficientFundsLog =
      'github.com/cosmos/cosmos-sdk/x/bank/keeper.BaseSendKeeper.subUnlockedCoins\n\n/home/go/pkg/mod/github.com/cosmos/cosmos-sdk@v0.44.5/x/bank/keeper/send.go:187\ngithub.com/cosmos/cosmos-sdk/x/bank/keeper.BaseSendKeeper.SendCoins\n\n/home/go/pkg/mod/github.com/cosmos/cosmos-sdk@v0.44.5/x/bank/keeper/send.go:134\ngithub.com/cosmos/cosmos-sdk/x/bank/keeper.msgServer.Send\n\n/home/go/pkg/mod/github.com/cosmos/cosmos-sdk@v0.44.5/x/bank/keeper/msg_server.go:46\ngithub.com/cosmos/cosmos-sdk/x/bank/types._Msg_Send_Handler.func1\n\n/home/go/pkg/mod/github.com/cosmos/cosmos-sdk@v0.44.5/x/bank/types/tx.pb.go:321\ngithub.com/cosmos/cosmos-sdk/baseapp.(*MsgServiceRouter).RegisterService.func2.1\n\n/home/go/pkg/mod/github.com/cosmos/cosmos-sdk@v0.44.5/baseapp/msg_service_router.go:113\ngithub.com/cosmos/cosmos-sdk/x/bank/types._Msg_Send_Handler\n\n/home/go/pkg/mod/github.com/cosmos/cosmos-sdk@v0.44.5/x/bank/types/tx.pb.go:323\ngithub.com/cosmos/cosmos-sdk/baseapp.(*MsgServiceRouter).RegisterService.func2\n\n/home/go/pkg/mod/github.com/cosmos/cosmos-sdk@v0.44.5/baseapp/msg_service_router.go:117\ngithub.com/cosmos/cosmos-sdk/baseapp.(*BaseApp).runMsgs\n\n/home/go/pkg/mod/github.com/cosmos/cosmos-sdk@v0.44.5/baseapp/baseapp.go:719\ngithub.com/cosmos/cosmos-sdk/baseapp.(*BaseApp).runTx\n\n/home/go/pkg/mod/github.com/cosmos/cosmos-sdk@v0.44.5/baseapp/baseapp.go:679\ngithub.com/cosmos/cosmos-sdk/baseapp.(*BaseApp).DeliverTx\n\n/home/go/pkg/mod/github.com/cosmos/cosmos-sdk@v0.44.5/baseapp/abci.go:275\ngithub.com/tendermint/tendermint/abci/client.(*localClient).DeliverTxAsync\n\n/home/go/pkg/mod/github.com/tendermint/tendermint@v0.34.14/abci/client/local_client.go:93\ngithub.com/tendermint/tendermint/proxy.(*appConnConsensus).DeliverTxAsync\n\n/home/go/pkg/mod/github.com/tendermint/tendermint@v0.34.14/proxy/app_conn.go:85\ngithub.com/tendermint/tendermint/state.execBlockOnProxyApp\n\n/home/go/pkg/mod/github.com/tendermint/tendermint@v0.34.14/state/execution.go:320\ngithub.com/tendermint/tendermint/state.(*BlockExecutor).ApplyBlock\n\n/home/go/pkg/mod/github.com/tendermint/tendermint@v0.34.14/state/execution.go:140\ngithub.com/tendermint/tendermint/consensus.(*State).finalizeCommit\n\n/home/go/pkg/mod/github.com/tendermint/tendermint@v0.34.14/consensus/state.go:1635\ngithub.com/tendermint/tendermint/consensus.(*State).tryFinalizeCommit\n\n/home/go/pkg/mod/github.com/tendermint/tendermint@v0.34.14/consensus/state.go:1546\ngithub.com/tendermint/tendermint/consensus.(*State).enterCommit.func1\n\n/home/go/pkg/mod/github.com/tendermint/tendermint@v0.34.14/consensus/state.go:1481\ngithub.com/tendermint/tendermint/consensus.(*State).enterCommit\n\n/home/go/pkg/mod/github.com/tendermint/tendermint@v0.34.14/consensus/state.go:1519\ngithub.com/tendermint/tendermint/consensus.(*State).addVote\n\n/home/go/pkg/mod/github.com/tendermint/tendermint@v0.34.14/consensus/state.go:2132\ngithub.com/tendermint/tendermint/consensus.(*State).tryAddVote\n\n/home/go/pkg/mod/github.com/tendermint/tendermint@v0.34.14/consensus/state.go:1930\ngithub.com/tendermint/tendermint/consensus.(*State).handleMsg\n\n/home/go/pkg/mod/github.com/tendermint/tendermint@v0.34.14/consensus/state.go:838\ngithub.com/tendermint/tendermint/consensus.(*State).receiveRoutine\n\n/home/go/pkg/mod/github.com/tendermint/tendermint@v0.34.14/consensus/state.go:762\nfailed to execute message; message index: 0: 929279ukex is smaller than 1000000000000000000ukex: insufficient funds';
  BroadcastTx insufficientFundsBroadcastTx = BroadcastTx(
    code: 5,
    codespace: 'sdk',
    events: const <Event>[],
    info: '',
    log: insufficientFundsLog,
  );

  // Fee (0) is out of range [100, 1000000]ukex: invalid request
  String invalidRequestLog =
      'github.com/KiraCore/sekai/app/ante.ValidateFeeRangeDecorator.AnteHandle\n\t/root/sekai/app/ante/ante.go:224\ngithub.com/cosmos/cosmos-sdk/types.ChainAnteDecorators.func1\n\t/root/go/pkg/mod/github.com/cosmos/cosmos-sdk@v0.45.4/types/handler.go:40\ngithub.com/cosmos/cosmos-sdk/x/auth/ante.ConsumeTxSizeGasDecorator.AnteHandle\n\t/root/go/pkg/mod/github.com/cosmos/cosmos-sdk@v0.45.4/x/auth/ante/basic.go:142\ngithub.com/cosmos/cosmos-sdk/types.ChainAnteDecorators.func1\n\t/root/go/pkg/mod/github.com/cosmos/cosmos-sdk@v0.45.4/types/handler.go:40\ngithub.com/cosmos/cosmos-sdk/x/auth/ante.ValidateMemoDecorator.AnteHandle\n\t/root/go/pkg/mod/github.com/cosmos/cosmos-sdk@v0.45.4/x/auth/ante/basic.go:66\ngithub.com/cosmos/cosmos-sdk/types.ChainAnteDecorators.func1\n\t/root/go/pkg/mod/github.com/cosmos/cosmos-sdk@v0.45.4/types/handler.go:40\ngithub.com/cosmos/cosmos-sdk/x/auth/ante.TxTimeoutHeightDecorator.AnteHandle\n\t/root/go/pkg/mod/github.com/cosmos/cosmos-sdk@v0.45.4/x/auth/ante/basic.go:205\ngithub.com/cosmos/cosmos-sdk/types.ChainAnteDecorators.func1\n\t/root/go/pkg/mod/github.com/cosmos/cosmos-sdk@v0.45.4/types/handler.go:40\ngithub.com/cosmos/cosmos-sdk/x/auth/ante.ValidateBasicDecorator.AnteHandle\n\t/root/go/pkg/mod/github.com/cosmos/cosmos-sdk@v0.45.4/x/auth/ante/basic.go:34\ngithub.com/cosmos/cosmos-sdk/types.ChainAnteDecorators.func1\n\t/root/go/pkg/mod/github.com/cosmos/cosmos-sdk@v0.45.4/types/handler.go:40\ngithub.com/cosmos/cosmos-sdk/x/auth/ante.MempoolFeeDecorator.AnteHandle\n\t/root/go/pkg/mod/github.com/cosmos/cosmos-sdk@v0.45.4/x/auth/ante/fee.go:54\ngithub.com/cosmos/cosmos-sdk/types.ChainAnteDecorators.func1\n\t/root/go/pkg/mod/github.com/cosmos/cosmos-sdk@v0.45.4/types/handler.go:40\ngithub.com/cosmos/cosmos-sdk/x/auth/ante.RejectExtensionOptionsDecorator.AnteHandle\n\t/root/go/pkg/mod/github.com/cosmos/cosmos-sdk@v0.45.4/x/auth/ante/ext.go:35\ngithub.com/cosmos/cosmos-sdk/types.ChainAnteDecorators.func1\n\t/root/go/pkg/mod/github.com/cosmos/cosmos-sdk@v0.45.4/types/handler.go:40\ngithub.com/KiraCore/sekai/app/ante.ZeroGasMeterDecorator.AnteHandle\n\t/root/sekai/app/ante/ante.go:378\ngithub.com/cosmos/cosmos-sdk/types.ChainAnteDecorators.func1\n\t/root/go/pkg/mod/github.com/cosmos/cosmos-sdk@v0.45.4/types/handler.go:40\ngithub.com/KiraCore/sekai/app/ante.CustodyDecorator.AnteHandle\n\t/root/sekai/app/ante/ante.go:157\ngithub.com/cosmos/cosmos-sdk/types.ChainAnteDecorators.func1\n\t/root/go/pkg/mod/github.com/cosmos/cosmos-sdk@v0.45.4/types/handler.go:40\ngithub.com/cosmos/cosmos-sdk/x/auth/ante.SetUpContextDecorator.AnteHandle\n\t/root/go/pkg/mod/github.com/cosmos/cosmos-sdk@v0.45.4/x/auth/ante/setup.go:64\ngithub.com/cosmos/cosmos-sdk/types.ChainAnteDecorators.func1\n\t/root/go/pkg/mod/github.com/cosmos/cosmos-sdk@v0.45.4/types/handler.go:40\ngithub.com/cosmos/cosmos-sdk/baseapp.(*BaseApp).runTx\n\t/root/go/pkg/mod/github.com/cosmos/cosmos-sdk@v0.45.4/baseapp/baseapp.go:660\ngithub.com/cosmos/cosmos-sdk/baseapp.(*BaseApp).CheckTx\n\t/root/go/pkg/mod/github.com/cosmos/cosmos-sdk@v0.45.4/baseapp/abci.go:244\ngithub.com/tendermint/tendermint/abci/client.(*localClient).CheckTxAsync\n\t/root/go/pkg/mod/github.com/tendermint/tendermint@v0.34.19/abci/client/local_client.go:104\ngithub.com/tendermint/tendermint/proxy.(*appConnMempool).CheckTxAsync\n\t/root/go/pkg/mod/github.com/tendermint/tendermint@v0.34.19/proxy/app_conn.go:126\ngithub.com/tendermint/tendermint/mempool.(*CListMempool).CheckTx\n\t/root/go/pkg/mod/github.com/tendermint/tendermint@v0.34.19/mempool/clist_mempool.go:288\ngithub.com/tendermint/tendermint/rpc/core.BroadcastTxCommit\n\t/root/go/pkg/mod/github.com/tendermint/tendermint@v0.34.19/rpc/core/mempool.go:82\nreflect.Value.call\n\t/usr/local/go/src/reflect/value.go:556\nreflect.Value.Call\n\t/usr/local/go/src/reflect/value.go:339\ngithub.com/tendermint/tendermint/rpc/jsonrpc/server.makeHTTPHandler.func2\n\t/root/go/pkg/mod/github.com/tendermint/tendermint@v0.34.19/rpc/jsonrpc/server/http_uri_handler.go:54\nnet/http.HandlerFunc.ServeHTTP\n\t/usr/local/go/src/net/http/server.go:2084\nnet/http.(*ServeMux).ServeHTTP\n\t/usr/local/go/src/net/http/server.go:2462\nfee (0) is out of range [100, 1000000]ukex: invalid request';
  BroadcastTx invalidRequestBroadcastTx = BroadcastTx(
    code: 5,
    codespace: 'sdk',
    events: const <Event>[],
    info: '',
    log: invalidRequestLog,
  );

  // staking pool not found
  String stakingPoolNotFoundLog =
      'github.com/cosmos/cosmos-sdk/baseapp.(*BaseApp).runMsgs\n\t/root/go/pkg/mod/github.com/cosmos/cosmos-sdk@v0.45.4/baseapp/baseapp.go:757\ngithub.com/cosmos/cosmos-sdk/baseapp.(*BaseApp).runTx\n\t/root/go/pkg/mod/github.com/cosmos/cosmos-sdk@v0.45.4/baseapp/baseapp.go:693\ngithub.com/cosmos/cosmos-sdk/baseapp.(*BaseApp).DeliverTx\n\t/root/go/pkg/mod/github.com/cosmos/cosmos-sdk@v0.45.4/baseapp/abci.go:276\ngithub.com/tendermint/tendermint/abci/client.(*localClient).DeliverTxAsync\n\t/root/go/pkg/mod/github.com/tendermint/tendermint@v0.34.19/abci/client/local_client.go:93\ngithub.com/tendermint/tendermint/proxy.(*appConnConsensus).DeliverTxAsync\n\t/root/go/pkg/mod/github.com/tendermint/tendermint@v0.34.19/proxy/app_conn.go:85\ngithub.com/tendermint/tendermint/state.execBlockOnProxyApp\n\t/root/go/pkg/mod/github.com/tendermint/tendermint@v0.34.19/state/execution.go:320\ngithub.com/tendermint/tendermint/state.(*BlockExecutor).ApplyBlock\n\t/root/go/pkg/mod/github.com/tendermint/tendermint@v0.34.19/state/execution.go:140\ngithub.com/tendermint/tendermint/consensus.(*State).finalizeCommit\n\t/root/go/pkg/mod/github.com/tendermint/tendermint@v0.34.19/consensus/state.go:1655\ngithub.com/tendermint/tendermint/consensus.(*State).tryFinalizeCommit\n\t/root/go/pkg/mod/github.com/tendermint/tendermint@v0.34.19/consensus/state.go:1564\ngithub.com/tendermint/tendermint/consensus.(*State).enterCommit.func1\n\t/root/go/pkg/mod/github.com/tendermint/tendermint@v0.34.19/consensus/state.go:1499\ngithub.com/tendermint/tendermint/consensus.(*State).enterCommit\n\t/root/go/pkg/mod/github.com/tendermint/tendermint@v0.34.19/consensus/state.go:1537\ngithub.com/tendermint/tendermint/consensus.(*State).addVote\n\t/root/go/pkg/mod/github.com/tendermint/tendermint@v0.34.19/consensus/state.go:2151\ngithub.com/tendermint/tendermint/consensus.(*State).tryAddVote\n\t/root/go/pkg/mod/github.com/tendermint/tendermint@v0.34.19/consensus/state.go:1949\ngithub.com/tendermint/tendermint/consensus.(*State).handleMsg\n\t/root/go/pkg/mod/github.com/tendermint/tendermint@v0.34.19/consensus/state.go:856\ngithub.com/tendermint/tendermint/consensus.(*State).receiveRoutine\n\t/root/go/pkg/mod/github.com/tendermint/tendermint@v0.34.19/consensus/state.go:783\nfailed to execute message; message index: 0: staking pool not found';
  BroadcastTx stakingPoolNotFoundBroadcastTx = BroadcastTx(
    code: 5,
    codespace: 'sdk',
    events: const <Event>[],
    info: '',
    log: stakingPoolNotFoundLog,
  );

  // invalid Bech32 prefix
  String invalidBechPrefixLog =
      'github.com/cosmos/cosmos-sdk/baseapp.(*BaseApp).runMsgs\n\t/root/go/pkg/mod/github.com/cosmos/cosmos-sdk@v0.45.4/baseapp/baseapp.go:757\ngithub.com/cosmos/cosmos-sdk/baseapp.(*BaseApp).runTx\n\t/root/go/pkg/mod/github.com/cosmos/cosmos-sdk@v0.45.4/baseapp/baseapp.go:693\ngithub.com/cosmos/cosmos-sdk/baseapp.(*BaseApp).DeliverTx\n\t/root/go/pkg/mod/github.com/cosmos/cosmos-sdk@v0.45.4/baseapp/abci.go:276\ngithub.com/tendermint/tendermint/abci/client.(*localClient).DeliverTxAsync\n\t/root/go/pkg/mod/github.com/tendermint/tendermint@v0.34.19/abci/client/local_client.go:93\ngithub.com/tendermint/tendermint/proxy.(*appConnConsensus).DeliverTxAsync\n\t/root/go/pkg/mod/github.com/tendermint/tendermint@v0.34.19/proxy/app_conn.go:85\ngithub.com/tendermint/tendermint/state.execBlockOnProxyApp\n\t/root/go/pkg/mod/github.com/tendermint/tendermint@v0.34.19/state/execution.go:320\ngithub.com/tendermint/tendermint/state.(*BlockExecutor).ApplyBlock\n\t/root/go/pkg/mod/github.com/tendermint/tendermint@v0.34.19/state/execution.go:140\ngithub.com/tendermint/tendermint/consensus.(*State).finalizeCommit\n\t/root/go/pkg/mod/github.com/tendermint/tendermint@v0.34.19/consensus/state.go:1655\ngithub.com/tendermint/tendermint/consensus.(*State).tryFinalizeCommit\n\t/root/go/pkg/mod/github.com/tendermint/tendermint@v0.34.19/consensus/state.go:1564\ngithub.com/tendermint/tendermint/consensus.(*State).enterCommit.func1\n\t/root/go/pkg/mod/github.com/tendermint/tendermint@v0.34.19/consensus/state.go:1499\ngithub.com/tendermint/tendermint/consensus.(*State).enterCommit\n\t/root/go/pkg/mod/github.com/tendermint/tendermint@v0.34.19/consensus/state.go:1537\ngithub.com/tendermint/tendermint/consensus.(*State).addVote\n\t/root/go/pkg/mod/github.com/tendermint/tendermint@v0.34.19/consensus/state.go:2151\ngithub.com/tendermint/tendermint/consensus.(*State).tryAddVote\n\t/root/go/pkg/mod/github.com/tendermint/tendermint@v0.34.19/consensus/state.go:1949\ngithub.com/tendermint/tendermint/consensus.(*State).handleMsg\n\t/root/go/pkg/mod/github.com/tendermint/tendermint@v0.34.19/consensus/state.go:856\ngithub.com/tendermint/tendermint/consensus.(*State).receiveRoutine\n\t/root/go/pkg/mod/github.com/tendermint/tendermint@v0.34.19/consensus/state.go:783\nfailed to execute message; message index: 0: invalid Bech32 prefix; expected kiravaloper, got kira';
  BroadcastTx invalidBechPrefixBroadcastTx = BroadcastTx(
    code: 5,
    codespace: 'sdk',
    events: const <Event>[],
    info: '',
    log: invalidBechPrefixLog,
  );

  // failed to execute message; message index: 0: executor is not validator owner
  String executorNotValidatorOwnerLog =
      'github.com/cosmos/cosmos-sdk/baseapp.(*BaseApp).runMsgs\n\t/root/go/pkg/mod/github.com/cosmos/cosmos-sdk@v0.45.4/baseapp/baseapp.go:757\ngithub.com/cosmos/cosmos-sdk/baseapp.(*BaseApp).runTx\n\t/root/go/pkg/mod/github.com/cosmos/cosmos-sdk@v0.45.4/baseapp/baseapp.go:693\ngithub.com/cosmos/cosmos-sdk/baseapp.(*BaseApp).DeliverTx\n\t/root/go/pkg/mod/github.com/cosmos/cosmos-sdk@v0.45.4/baseapp/abci.go:276\ngithub.com/tendermint/tendermint/abci/client.(*localClient).DeliverTxAsync\n\t/root/go/pkg/mod/github.com/tendermint/tendermint@v0.34.19/abci/client/local_client.go:93\ngithub.com/tendermint/tendermint/proxy.(*appConnConsensus).DeliverTxAsync\n\t/root/go/pkg/mod/github.com/tendermint/tendermint@v0.34.19/proxy/app_conn.go:85\ngithub.com/tendermint/tendermint/state.execBlockOnProxyApp\n\t/root/go/pkg/mod/github.com/tendermint/tendermint@v0.34.19/state/execution.go:320\ngithub.com/tendermint/tendermint/state.(*BlockExecutor).ApplyBlock\n\t/root/go/pkg/mod/github.com/tendermint/tendermint@v0.34.19/state/execution.go:140\ngithub.com/tendermint/tendermint/consensus.(*State).finalizeCommit\n\t/root/go/pkg/mod/github.com/tendermint/tendermint@v0.34.19/consensus/state.go:1655\ngithub.com/tendermint/tendermint/consensus.(*State).tryFinalizeCommit\n\t/root/go/pkg/mod/github.com/tendermint/tendermint@v0.34.19/consensus/state.go:1564\ngithub.com/tendermint/tendermint/consensus.(*State).enterCommit.func1\n\t/root/go/pkg/mod/github.com/tendermint/tendermint@v0.34.19/consensus/state.go:1499\ngithub.com/tendermint/tendermint/consensus.(*State).enterCommit\n\t/root/go/pkg/mod/github.com/tendermint/tendermint@v0.34.19/consensus/state.go:1537\ngithub.com/tendermint/tendermint/consensus.(*State).addVote\n\t/root/go/pkg/mod/github.com/tendermint/tendermint@v0.34.19/consensus/state.go:2151\ngithub.com/tendermint/tendermint/consensus.(*State).tryAddVote\n\t/root/go/pkg/mod/github.com/tendermint/tendermint@v0.34.19/consensus/state.go:1949\ngithub.com/tendermint/tendermint/consensus.(*State).handleMsg\n\t/root/go/pkg/mod/github.com/tendermint/tendermint@v0.34.19/consensus/state.go:856\ngithub.com/tendermint/tendermint/consensus.(*State).receiveRoutine\n\t/root/go/pkg/mod/github.com/tendermint/tendermint@v0.34.19/consensus/state.go:783\nfailed to execute message; message index: 0: executor is not validator owner';
  BroadcastTx executorNotValidatorOwnerBroadcastTx = BroadcastTx(
    code: 5,
    codespace: 'sdk',
    events: const <Event>[],
    info: '',
    log: executorNotValidatorOwnerLog,
  );

  group('Tests for UNAUTHORIZED error', () {
    BroadcastErrorLogModel? actualBroadcastErrorLogModel = BroadcastErrorLogModel.fromDto(unauthorizedBroadcastTx);

    test('Should return "UNAUTHORIZED" as an error name', () {
      expect(actualBroadcastErrorLogModel?.code, 'UNAUTHORIZED');
    });

    test('Should return "UNAUTHORIZED" error message', () {
      expect(
          actualBroadcastErrorLogModel?.message, 'Signature verification failed\nPlease verify account number (669), sequence (144) and chain-id (testnet-9)');
    });
  });

  group('Tests for INCORRECT_ACCOUNT_SEQUENCE error', () {
    BroadcastErrorLogModel? actualBroadcastErrorLogModel = BroadcastErrorLogModel.fromDto(incorrectAccountSequenceBroadcastTx);

    test('Should return "INCORRECT_ACCOUNT_SEQUENCE" as an error name', () {
      expect(actualBroadcastErrorLogModel?.code, 'INCORRECT_ACCOUNT_SEQUENCE');
    });

    test('Should return "INCORRECT_ACCOUNT_SEQUENCE" error message', () {
      expect(actualBroadcastErrorLogModel?.message, 'Account sequence mismatch, expected 144, got 0');
    });
  });

  group('Tests for INSUFFICIENT_FUNDS error', () {
    BroadcastErrorLogModel? actualBroadcastErrorLogModel = BroadcastErrorLogModel.fromDto(insufficientFundsBroadcastTx);

    test('Should return "INSUFFICIENT_FUNDS" as an error name', () {
      expect(actualBroadcastErrorLogModel?.code, 'INSUFFICIENT_FUNDS');
    });

    test('Should return "INSUFFICIENT_FUNDS" error message', () {
      expect(actualBroadcastErrorLogModel?.message, 'Failed to execute message\nMessage index: 0: 929279ukex is smaller than 1000000000000000000ukex');
    });
  });

  group('Tests for INVALID_REQUEST error', () {
    BroadcastErrorLogModel? actualBroadcastErrorLogModel = BroadcastErrorLogModel.fromDto(invalidRequestBroadcastTx);

    test('Should return "INVALID_REQUEST" as an error name', () {
      expect(actualBroadcastErrorLogModel?.code, 'INVALID_REQUEST');
    });

    test('Should return "INVALID_REQUEST" error message', () {
      expect(actualBroadcastErrorLogModel?.message, 'Fee (0) is out of range [100, 1000000]ukex');
    });
  });

  group('Tests for STAKING_POOL_NOT_FOUND error', () {
    BroadcastErrorLogModel? actualBroadcastErrorLogModel = BroadcastErrorLogModel.fromDto(stakingPoolNotFoundBroadcastTx);

    test('Should return "STAKING_POOL_NOT_FOUND" as an error name', () {
      expect(actualBroadcastErrorLogModel?.code, 'STAKING_POOL_NOT_FOUND');
    });

    test('Should return "STAKING_POOL_NOT_FOUND" error message', () {
      expect(actualBroadcastErrorLogModel?.message, 'Failed to execute message\nMessage index: 0');
    });
  });

  group('Tests for INVALID_BECH32_PREFIX error', () {
    BroadcastErrorLogModel? actualBroadcastErrorLogModel = BroadcastErrorLogModel.fromDto(invalidBechPrefixBroadcastTx);

    test('Should return "INVALID_BECH32_PREFIX" as an error name', () {
      expect(actualBroadcastErrorLogModel?.code, 'INVALID_BECH32_PREFIX');
    });

    test('Should return "INVALID_BECH32_PREFIX" error message', () {
      expect(actualBroadcastErrorLogModel?.message, 'Failed to execute message\nMessage index: 0\nExpected kiravaloper, got kira');
    });
  });

  group('Tests for EXECUTOR_IS_NOT_VALIDATOR_OWNER error', () {
    BroadcastErrorLogModel? actualBroadcastErrorLogModel = BroadcastErrorLogModel.fromDto(executorNotValidatorOwnerBroadcastTx);

    test('Should return "EXECUTOR_IS_NOT_VALIDATOR_OWNER" as an error name', () {
      expect(actualBroadcastErrorLogModel?.code, 'EXECUTOR_IS_NOT_VALIDATOR_OWNER');
    });

    test('Should return "EXECUTOR_IS_NOT_VALIDATOR_OWNER" error message', () {
      expect(actualBroadcastErrorLogModel?.message, 'Failed to execute message\nMessage index: 0');
    });
  });
}
