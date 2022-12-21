class MockApiKiraTxs {
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
