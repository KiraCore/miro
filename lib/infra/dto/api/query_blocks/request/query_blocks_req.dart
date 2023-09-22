import 'package:equatable/equatable.dart';

class QueryBlocksReq extends Equatable {
  /// This is the option of the maximum block height.
  final String? maxHeight;

  /// This is the option of the minimum block height.
  final String? minHeight;

  /// This is an option to validators pagination. limit is the total number
  /// of results to be returned in the result page.
  /// If left empty it will default to a value to be set by each app.
  final int? limit;

  /// This is an option to validators pagination. offset is a numeric
  /// offset that can be used when key is unavailable.
  /// It is less efficient than using key. Only one of offset or key should be set
  final int? offset;

  const QueryBlocksReq({
    this.limit,
    this.offset,
    this.maxHeight,
    this.minHeight,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'limit': limit,
      'offset': offset,
      'maxHeight': maxHeight,
      'minHeight': minHeight,
    };
  }

  @override
  List<Object?> get props => <Object?>[limit, offset, minHeight, maxHeight];
}
