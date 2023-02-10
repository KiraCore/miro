class MockApiKiraTxs {
  static Map<String, dynamic> dioParseExceptionResponse = <String, dynamic>{
    'unexpected_key': 'unexpected_value',
  };

  static Map<String, dynamic> txBroadcastExceptionResponse = <String, dynamic>{
    "check_tx": {
      "code": 32,
      "codespace": "sdk",
      "data": null,
      "events": [],
      "info": "",
      "log":
          "\ngithub.com/cosmos/cosmos-sdk/x/auth/ante.SigVerificationDecorator.AnteHandle\n\t/root/go/pkg/mod/github.com/cosmos/cosmos-sdk@v0.45.10/x/auth/ante/sigverify.go:265\ngithub.com/cosmos/cosmos-sdk/types.ChainAnteDecorators.func1\n\t/root/go/pkg/mod/github.com/cosmos/cosmos-sdk@v0.45.10/types/handler.go:40\ngithub.com/cosmos/cosmos-sdk/x/auth/ante.SigGasConsumeDecorator.AnteHandle\n\t/root/go/pkg/mod/github.com/cosmos/cosmos-sdk@v0.45.10/x/auth/ante/sigverify.go:190\ngithub.com/cosmos/cosmos-sdk/types.ChainAnteDecorators.func1\n\t/root/go/pkg/mod/github.com/cosmos/cosmos-sdk@v0.45.10/types/handler.go:40\ngithub.com/KiraCore/sekai/app/ante.ExecutionFeeRegistrationDecorator.AnteHandle\n\t/root/sekai/app/ante/ante.go:265\ngithub.com/cosmos/cosmos-sdk/types.ChainAnteDecorators.func1\n\t/root/go/pkg/mod/github.com/cosmos/cosmos-sdk@v0.45.10/types/handler.go:40\ngithub.com/KiraCore/sekai/app/ante.BlackWhiteTokensCheckDecorator.AnteHandle\n\t/root/sekai/app/ante/ante.go:365\ngithub.com/cosmos/cosmos-sdk/types.ChainAnteDecorators.func1\n\t/root/go/pkg/mod/github.com/cosmos/cosmos-sdk@v0.45.10/types/handler.go:40\ngithub.com/KiraCore/sekai/app/ante.PoorNetworkManagementDecorator.AnteHandle\n\t/root/sekai/app/ante/ante.go:302\ngithub.com/cosmos/cosmos-sdk/types.ChainAnteDecorators.func1\n\t/root/go/pkg/mod/github.com/cosmos/cosmos-sdk@v0.45.10/types/handler.go:40\ngithub.com/cosmos/cosmos-sdk/x/auth/ante.DeductFeeDecorator.AnteHandle\n\t/root/go/pkg/mod/github.com/cosmos/cosmos-sdk@v0.45.10/x/auth/ante/fee.go:128\ngithub.com/cosmos/cosmos-sdk/types.ChainAnteDecorators.func1\n\t/root/go/pkg/mod/github.com/cosmos/cosmos-sdk@v0.45.10/types/handler.go:40\ngithub.com/cosmos/cosmos-sdk/x/auth/ante.ValidateSigCountDecorator.AnteHandle\n\t/root/go/pkg/mod/github.com/cosmos/cosmos-sdk@v0.45.10/x/auth/ante/sigverify.go:378\ngithub.com/cosmos/cosmos-sdk/types.ChainAnteDecorators.func1\n\t/root/go/pkg/mod/github.com/cosmos/cosmos-sdk@v0.45.10/types/handler.go:40\ngithub.com/cosmos/cosmos-sdk/x/auth/ante.SetPubKeyDecorator.AnteHandle\n\t/root/go/pkg/mod/github.com/cosmos/cosmos-sdk@v0.45.10/x/auth/ante/sigverify.go:126\ngithub.com/cosmos/cosmos-sdk/types.ChainAnteDecorators.func1\n\t/root/go/pkg/mod/github.com/cosmos/cosmos-sdk@v0.45.10/types/handler.go:40\ngithub.com/KiraCore/sekai/app/ante.ValidateFeeRangeDecorator.AnteHandle\n\t/root/sekai/app/ante/ante.go:231\ngithub.com/cosmos/cosmos-sdk/types.ChainAnteDecorators.func1\n\t/root/go/pkg/mod/github.com/cosmos/cosmos-sdk@v0.45.10/types/handler.go:40\ngithub.com/cosmos/cosmos-sdk/x/auth/ante.ConsumeTxSizeGasDecorator.AnteHandle\n\t/root/go/pkg/mod/github.com/cosmos/cosmos-sdk@v0.45.10/x/auth/ante/basic.go:142\ngithub.com/cosmos/cosmos-sdk/types.ChainAnteDecorators.func1\n\t/root/go/pkg/mod/github.com/cosmos/cosmos-sdk@v0.45.10/types/handler.go:40\ngithub.com/cosmos/cosmos-sdk/x/auth/ante.ValidateMemoDecorator.AnteHandle\n\t/root/go/pkg/mod/github.com/cosmos/cosmos-sdk@v0.45.10/x/auth/ante/basic.go:66\ngithub.com/cosmos/cosmos-sdk/types.ChainAnteDecorators.func1\n\t/root/go/pkg/mod/github.com/cosmos/cosmos-sdk@v0.45.10/types/handler.go:40\ngithub.com/cosmos/cosmos-sdk/x/auth/ante.TxTimeoutHeightDecorator.AnteHandle\n\t/root/go/pkg/mod/github.com/cosmos/cosmos-sdk@v0.45.10/x/auth/ante/basic.go:205\ngithub.com/cosmos/cosmos-sdk/types.ChainAnteDecorators.func1\n\t/root/go/pkg/mod/github.com/cosmos/cosmos-sdk@v0.45.10/types/handler.go:40\ngithub.com/cosmos/cosmos-sdk/x/auth/ante.ValidateBasicDecorator.AnteHandle\n\t/root/go/pkg/mod/github.com/cosmos/cosmos-sdk@v0.45.10/x/auth/ante/basic.go:34\ngithub.com/cosmos/cosmos-sdk/types.ChainAnteDecorators.func1\n\t/root/go/pkg/mod/github.com/cosmos/cosmos-sdk@v0.45.10/types/handler.go:40\ngithub.com/cosmos/cosmos-sdk/x/auth/ante.MempoolFeeDecorator.AnteHandle\n\t/root/go/pkg/mod/github.com/cosmos/cosmos-sdk@v0.45.10/x/auth/ante/fee.go:54\ngithub.com/cosmos/cosmos-sdk/types.ChainAnteDecorators.func1\n\t/root/go/pkg/mod/github.com/cosmos/cosmos-sdk@v0.45.10/types/handler.go:40\ngithub.com/cosmos/cosmos-sdk/x/auth/ante.RejectExtensionOptionsDecorator.AnteHandle\n\t/root/go/pkg/mod/github.com/cosmos/cosmos-sdk@v0.45.10/x/auth/ante/ext.go:35\ngithub.com/cosmos/cosmos-sdk/types.ChainAnteDecorators.func1\n\t/root/go/pkg/mod/github.com/cosmos/cosmos-sdk@v0.45.10/types/handler.go:40\naccount sequence mismatch, expected 47, got 34: incorrect account sequence",
      "mempoolError": "",
      "priority": "0",
      "sender": ""
    },
    "deliver_tx": {"code": 0, "codespace": "", "data": null, "events": [], "info": "", "log": ""},
    "hash": "7A856AA342E265F1AD2BA2A2838608EB2A00B6C96A967365E78385EF285ED781",
    "height": "0"
  };

  static Map<String, dynamic> defaultResponse = <String, dynamic>{
    "check_tx": {"code": 0, "codespace": "", "data": "", "events": [], "gas_used": "0", "gas_wanted": "0", "info": "", "log": "[]"},
    "deliver_tx": {
      "code": 0,
      "codespace": "",
      "data": "Ch4KHC9jb3Ntb3MuYmFuay52MWJldGExLk1zZ1NlbmQ=",
      "events": [
        {
          "attributes": [
            {"index": true, "key": "YWNjX3NlcQ==", "value": "a2lyYTE0M3E4dnhwdnV5a3Q5cHE1MGU2aG5nOXMzOHZteTg0NG44azl3eC85MA=="}
          ],
          "type": "tx"
        },
        {
          "attributes": [
            {
              "index": true,
              "key": "c2lnbmF0dXJl",
              "value": "bzZUeGthMndPblpmcndNN2JZMW9oTjVaOC9RcSsrOEY1ZUp3UmROeDlTZ21Tc1JjT3BuL2EzNnlxaDhveW9HOWU3c1FZeDVKZUZZRVE0L2tLQzFBaGc9PQ=="
            }
          ],
          "type": "tx"
        },
        {
          "attributes": [
            {"index": true, "key": "c3BlbmRlcg==", "value": "a2lyYTE0M3E4dnhwdnV5a3Q5cHE1MGU2aG5nOXMzOHZteTg0NG44azl3eA=="},
            {"index": true, "key": "YW1vdW50", "value": "MjAwdWtleA=="}
          ],
          "type": "coin_spent"
        },
        {
          "attributes": [
            {"index": true, "key": "cmVjZWl2ZXI=", "value": "a2lyYTE3eHBmdmFrbTJhbWc5NjJ5bHM2Zjg0ejNrZWxsOGM1bHFrZncycw=="},
            {"index": true, "key": "YW1vdW50", "value": "MjAwdWtleA=="}
          ],
          "type": "coin_received"
        },
        {
          "attributes": [
            {"index": true, "key": "cmVjaXBpZW50", "value": "a2lyYTE3eHBmdmFrbTJhbWc5NjJ5bHM2Zjg0ejNrZWxsOGM1bHFrZncycw=="},
            {"index": true, "key": "c2VuZGVy", "value": "a2lyYTE0M3E4dnhwdnV5a3Q5cHE1MGU2aG5nOXMzOHZteTg0NG44azl3eA=="},
            {"index": true, "key": "YW1vdW50", "value": "MjAwdWtleA=="}
          ],
          "type": "transfer"
        },
        {
          "attributes": [
            {"index": true, "key": "c2VuZGVy", "value": "a2lyYTE0M3E4dnhwdnV5a3Q5cHE1MGU2aG5nOXMzOHZteTg0NG44azl3eA=="}
          ],
          "type": "message"
        },
        {
          "attributes": [
            {"index": true, "key": "ZmVl", "value": "MjAwdWtleA=="}
          ],
          "type": "tx"
        },
        {
          "attributes": [
            {"index": true, "key": "YWN0aW9u", "value": "L2Nvc21vcy5iYW5rLnYxYmV0YTEuTXNnU2VuZA=="}
          ],
          "type": "message"
        },
        {
          "attributes": [
            {"index": true, "key": "c3BlbmRlcg==", "value": "a2lyYTE0M3E4dnhwdnV5a3Q5cHE1MGU2aG5nOXMzOHZteTg0NG44azl3eA=="},
            {"index": true, "key": "YW1vdW50", "value": "MjAwdWtleA=="}
          ],
          "type": "coin_spent"
        },
        {
          "attributes": [
            {"index": true, "key": "cmVjZWl2ZXI=", "value": "a2lyYTE3N2x3bWp5amRzM2N5N3RyZXJzODNyNHBqbjNkaHY4enJxazlkbA=="},
            {"index": true, "key": "YW1vdW50", "value": "MjAwdWtleA=="}
          ],
          "type": "coin_received"
        },
        {
          "attributes": [
            {"index": true, "key": "cmVjaXBpZW50", "value": "a2lyYTE3N2x3bWp5amRzM2N5N3RyZXJzODNyNHBqbjNkaHY4enJxazlkbA=="},
            {"index": true, "key": "c2VuZGVy", "value": "a2lyYTE0M3E4dnhwdnV5a3Q5cHE1MGU2aG5nOXMzOHZteTg0NG44azl3eA=="},
            {"index": true, "key": "YW1vdW50", "value": "MjAwdWtleA=="}
          ],
          "type": "transfer"
        },
        {
          "attributes": [
            {"index": true, "key": "c2VuZGVy", "value": "a2lyYTE0M3E4dnhwdnV5a3Q5cHE1MGU2aG5nOXMzOHZteTg0NG44azl3eA=="}
          ],
          "type": "message"
        },
        {
          "attributes": [
            {"index": true, "key": "bW9kdWxl", "value": "YmFuaw=="}
          ],
          "type": "message"
        }
      ],
      "info": "",
      "log":
          "[{\"events\":[{\"type\":\"coin_received\",\"attributes\":[{\"key\":\"receiver\",\"value\":\"kira177lwmjyjds3cy7trers83r4pjn3dhv8zrqk9dl\"},{\"key\":\"amount\",\"value\":\"200ukex\"}]},{\"type\":\"coin_spent\",\"attributes\":[{\"key\":\"spender\",\"value\":\"kira143q8vxpvuykt9pq50e6hng9s38vmy844n8k9wx\"},{\"key\":\"amount\",\"value\":\"200ukex\"}]},{\"type\":\"message\",\"attributes\":[{\"key\":\"action\",\"value\":\"/cosmos.bank.v1beta1.MsgSend\"},{\"key\":\"sender\",\"value\":\"kira143q8vxpvuykt9pq50e6hng9s38vmy844n8k9wx\"},{\"key\":\"module\",\"value\":\"bank\"}]},{\"type\":\"transfer\",\"attributes\":[{\"key\":\"recipient\",\"value\":\"kira177lwmjyjds3cy7trers83r4pjn3dhv8zrqk9dl\"},{\"key\":\"sender\",\"value\":\"kira143q8vxpvuykt9pq50e6hng9s38vmy844n8k9wx\"},{\"key\":\"amount\",\"value\":\"200ukex\"}]}]}]"
    },
    "hash": "10FDA415FE8DB2614D51617EDC2F3433CB652C584918F7AD39C41DDF6E397627",
    "height": "3750430"
  };
}
