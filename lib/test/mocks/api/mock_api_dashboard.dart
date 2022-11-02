class MockApiDashboard {
  static Map<String, dynamic> defaultResponse = <String, dynamic>{
    "consensus_health": "1.00",
    "current_block_validator": {"moniker": "GENESIS VALIDATOR", "address": "kira12p8c7ynv7uxzdd88dc9trd9e4qzsewjvqq8y2x"},
    "validators": {
      "active_validators": 1,
      "paused_validators": 0,
      "inactive_validators": 0,
      "jailed_validators": 0,
      "total_validators": 1,
      "waiting_validators": 0
    },
    "blocks": {
      "current_height": 89629,
      "since_genesis": 89628,
      "pending_transactions": 0,
      "current_transactions": 0,
      "latest_time": 5.009137321,
      "average_time": 5.009582592
    },
    "proposals": {"total": 0, "active": 0, "enacting": 0, "finished": 0, "successful": 0, "proposers": "1", "voters": "1"}
  };
}
