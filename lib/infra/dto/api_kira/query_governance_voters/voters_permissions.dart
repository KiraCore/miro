import 'package:equatable/equatable.dart';

class VotersPermissions extends Equatable {
  final List<dynamic> blacklist;
  final List<dynamic> whitelist;

  const VotersPermissions({
    required this.blacklist,
    required this.whitelist,
  });

  factory VotersPermissions.fromJson(Map<String, dynamic> json) => VotersPermissions(
        blacklist: json['blacklist'] as List<dynamic>,
        whitelist: json['whitelist'] as List<dynamic>,
      );

  @override
  List<Object> get props => <Object>[blacklist, whitelist];
}
