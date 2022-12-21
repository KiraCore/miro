import 'package:equatable/equatable.dart';
import 'package:miro/infra/dto/api_kira/broadcast/response/event_attribute.dart';

class Event extends Equatable {
  final List<EventAttribute> attributes;
  final String type;

  const Event({
    required this.attributes,
    required this.type,
  });

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      attributes: (json['attributes'] as List<dynamic>).map((dynamic e) => EventAttribute.fromJson(e as Map<String, dynamic>)).toList(),
      type: json['type'] as String,
    );
  }

  @override
  List<Object?> get props => <Object?>[attributes, type];
}
