class MockApiKiraTxs {
  static Map<String, dynamic> dioParseExceptionResponse = <String, dynamic>{
    'unexpected_key': 'unexpected_value',
  };

  // Updated to match BroadcastResp.fromJson expected structure (flattened, not nested in check_tx)
  static Map<String, dynamic> txBroadcastExceptionResponse = <String, dynamic>{
    'hash': '7A856AA342E265F1AD2BA2A2838608EB2A00B6C96A967365E78385EF285ED781',
    'code': 32,
    'codespace': 'sdk',
    'data': null,
    'log': 'account sequence mismatch, expected 47, got 34: incorrect account sequence',
  };

  // Updated to match BroadcastResp.fromJson expected structure (flattened)
  static Map<String, dynamic> defaultResponse = <String, dynamic>{
    'hash': '10FDA415FE8DB2614D51617EDC2F3433CB652C584918F7AD39C41DDF6E397627',
    'code': 0,
    'codespace': '',
    'data': 'Ch4KHC9jb3Ntb3MuYmFuay52MWJldGExLk1zZ1NlbmQ=',
    'log': '[{"events":[{"type":"coin_received","attributes":[{"key":"receiver","value":"kira177lwmjyjds3cy7trers83r4pjn3dhv8zrqk9dl"},{"key":"amount","value":"200ukex"}]}]}]',
  };
}
