class QueryFaucetReq {
  final String? address;

  QueryFaucetReq({
    required this.address,
  });

  factory QueryFaucetReq.fromJson(Map<String, String> json) {
    return QueryFaucetReq(
      address: json['address'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['address'] = address;
    return data;
  }
}
