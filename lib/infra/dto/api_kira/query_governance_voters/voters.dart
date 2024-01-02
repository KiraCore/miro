import 'package:equatable/equatable.dart';
import 'package:miro/infra/dto/api_kira/query_governance_voters/voters_permissions.dart';

class Voters extends Equatable {
  final String address;
  final List<dynamic> roles;
  final String status;
  final List<dynamic> votes;
  final VotersPermissions permissions;
  final int skin;

  const Voters({
    required this.address,
    required this.roles,
    required this.status,
    required this.votes,
    required this.permissions,
    required this.skin,
  });

  factory Voters.fromJson(Map<String, dynamic> json) => Voters(
        address: json['address'] as String,
        roles: json['roles'] as List<dynamic>,
        status: json['status'] as String,
        votes: json['votes'] as List<dynamic>,
        permissions: VotersPermissions.fromJson(json['permissions'] as Map<String, dynamic>),
        skin: json['skin'] as int,
      );

  @override
  List<Object> get props => <Object>[
        address,
        roles,
        status,
        votes,
        permissions,
        skin,
      ];
}
