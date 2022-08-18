class IdentityInfoEntry {
  final String key;
  final String info;

  IdentityInfoEntry({
    required this.key,
    required this.info,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'key': key,
      'info': info,
    };
  }
}
