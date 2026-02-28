import 'package:equatable/equatable.dart';

/// Response from the dashboard API endpoint.
/// This matches the actual API response structure with:
/// - `validators`: Array of validator objects with address and moniker
/// - `status`: Object containing validator counts
class DashboardResp extends Equatable {
  final List<DashboardValidator> validators;
  final DashboardStatus status;

  const DashboardResp({
    required this.validators,
    required this.status,
  });

  factory DashboardResp.fromJson(Map<String, dynamic> json) {
    final List<dynamic> validatorsList = json['validators'] as List<dynamic>? ?? <dynamic>[];
    final Map<String, dynamic> statusMap = json['status'] as Map<String, dynamic>? ?? <String, dynamic>{};

    return DashboardResp(
      validators: validatorsList.map((dynamic v) => DashboardValidator.fromJson(v as Map<String, dynamic>)).toList(),
      status: DashboardStatus.fromJson(statusMap),
    );
  }

  @override
  List<Object?> get props => <Object>[validators, status];
}

/// Validator info from dashboard response
class DashboardValidator extends Equatable {
  final String address;
  final String moniker;

  const DashboardValidator({
    required this.address,
    required this.moniker,
  });

  factory DashboardValidator.fromJson(Map<String, dynamic> json) {
    return DashboardValidator(
      address: json['address'] as String? ?? '',
      moniker: json['moniker'] as String? ?? '',
    );
  }

  @override
  List<Object?> get props => <Object>[address, moniker];
}

/// Status object from dashboard response containing validator counts
class DashboardStatus extends Equatable {
  final int activeValidators;
  final int pausedValidators;
  final int inactiveValidators;
  final int jailedValidators;
  final int totalValidators;
  final int waitingValidators;

  const DashboardStatus({
    required this.activeValidators,
    required this.pausedValidators,
    required this.inactiveValidators,
    required this.jailedValidators,
    required this.totalValidators,
    required this.waitingValidators,
  });

  factory DashboardStatus.fromJson(Map<String, dynamic> json) {
    return DashboardStatus(
      activeValidators: json['active_validators'] as int? ?? 0,
      pausedValidators: json['paused_validators'] as int? ?? 0,
      inactiveValidators: json['inactive_validators'] as int? ?? 0,
      jailedValidators: json['jailed_validators'] as int? ?? 0,
      totalValidators: json['total_validators'] as int? ?? 0,
      waitingValidators: json['waiting_validators'] as int? ?? 0,
    );
  }

  @override
  List<Object?> get props => <Object>[
        activeValidators,
        pausedValidators,
        inactiveValidators,
        jailedValidators,
        totalValidators,
        waitingValidators,
      ];
}
