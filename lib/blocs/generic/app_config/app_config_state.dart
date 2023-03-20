import 'package:equatable/equatable.dart';

class AppConfigState extends Equatable {
  final String locale;

  const AppConfigState({
    required this.locale,
  });

  @override
  List<Object?> get props => <Object?>[locale];
}
