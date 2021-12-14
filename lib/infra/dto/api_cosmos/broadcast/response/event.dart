import 'package:miro/infra/dto/api_cosmos/broadcast/response/event_attribute.dart';

class Event {
  final List<EventAttribute> attributes;
  final String type;

  Event({
    required this.attributes,
    required this.type,
  });

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      attributes: (json['attributes'] as List<dynamic>)
          .map((dynamic e) => EventAttribute.fromJson(e as Map<String, dynamic>))
          .toList(),
      type: json['type'] as String,
    );
  }
}
