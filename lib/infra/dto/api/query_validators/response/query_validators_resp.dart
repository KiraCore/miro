import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:miro/infra/dto/api/query_validators/response/status.dart';
import 'package:miro/infra/dto/api/query_validators/response/validator.dart';

@immutable
class QueryValidatorsResp extends Equatable {
  final Status? status;
  final List<String> waiting;

  final List<Validator> validators;

  const QueryValidatorsResp({
    required this.waiting,
    required this.validators,
    this.status,
  });

  factory QueryValidatorsResp.fromJson(Map<String, dynamic> json) {
    return QueryValidatorsResp(
      status: json['status'] != null ? Status.fromJson(json['status'] as Map<String, dynamic>) : null,
      waiting: json['waiting'] != null
          ? (json['waiting'] as List<dynamic>).map((dynamic e) => e as String).toList()
          : List<String>.empty(growable: true),
      validators: json['validators'] != null
          ? (json['validators'] as List<dynamic>)
              .map((dynamic e) => Validator.fromJson(e as Map<String, dynamic>))
              .toList()
          : List<Validator>.empty(growable: true),
    );
  }

  @override
  List<Object?> get props => <Object?>[status];
}
