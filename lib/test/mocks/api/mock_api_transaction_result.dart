class MockApiTransactionResult {
  static Map<String, dynamic> defaultResponse = {
    "hash": "ffe7dbf6acd40e0080406568a33d3f32bd2ad815e05e33ece22c0c835d256872",
    "status": "Success",
    "block_height": 465237,
    "block_timestamp": 1708089925,
    "confirmation": 66843,
    "msgs": [
      {
        "type": "send",
        "data": {
          "from_address": "kira143q8vxpvuykt9pq50e6hng9s38vmy844n8k9wx",
          "to_address": "kira143q8vxpvuykt9pq50e6hng9s38vmy844n8k9wx",
          "amount": [
            {
              "denom": "udev",
              "amount": "1222"
            }
          ]
        }
      }
    ],
    "transactions": [
      {
        "type": "send",
        "from": "kira143q8vxpvuykt9pq50e6hng9s38vmy844n8k9wx",
        "to": "kira143q8vxpvuykt9pq50e6hng9s38vmy844n8k9wx",
        "amounts": [
          {
            "denom": "udev",
            "amount": "1222"
          }
        ]
      }
    ],
    "fees": [
      {
        "denom": "udev",
        "amount": "100"
      }
    ],
    "gas_wanted": 0,
    "gas_used": 0,
    "memo": ""
  }
}

