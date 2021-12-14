class EventAttribute {
  final bool index;
  final String key;
  final String value;

  EventAttribute({
    required this.index,
    required this.key,
    required this.value,
  });

  factory EventAttribute.fromJson(Map<String, dynamic> json) {
    return EventAttribute(
      index: json['index'] as bool,
      key: json['key'] as String,
      value: json['value'] as String,
    );
  }
}
