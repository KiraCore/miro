class MockApiKiraGovernanceVoters {
  static List<Map<String, dynamic>> defaultResponse = <Map<String, dynamic>>[
    {
      "address": "kira1vmwdgw426aj9fx33fqusmtg6r65yyucmx6rdt4",
      "roles": ["1", "2"],
      "status": "ACTIVE",
      "votes": ["VOTE_OPTION_YES", "VOTE_OPTION_ABSTAIN", "VOTE_OPTION_NO", "VOTE_OPTION_NO_WITH_VETO"],
      "permissions": {
        "blacklist": [],
        "whitelist": [
          "PERMISSION_CREATE_SET_PERMISSIONS_PROPOSAL",
          "",
          "PERMISSION_CREATE_UPSERT_TOKEN_ALIAS_PROPOSAL",
          "PERMISSION_CREATE_SOFTWARE_UPGRADE_PROPOSAL",
          "PERMISSION_VOTE_SET_PERMISSIONS_PROPOSAL",
          "",
          "PERMISSION_VOTE_UPSERT_TOKEN_ALIAS_PROPOSAL",
          "PERMISSION_SOFTWARE_UPGRADE_PROPOSAL"
        ]
      },
      "skin": 1
    }
  ];
}
