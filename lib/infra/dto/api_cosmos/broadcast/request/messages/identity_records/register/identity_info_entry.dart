import 'package:equatable/equatable.dart';

class IdentityInfoEntry extends Equatable {
  final String key;
  final String info;

  const IdentityInfoEntry({
    required this.key,
    required this.info,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'key': key,
      'info': info,
    };
  }

  @override
  List<Object?> get props => <Object?>[key, info];
}
