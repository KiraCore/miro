import 'package:equatable/equatable.dart';
import 'package:miro/shared/exceptions/keyfile_exception/keyfile_exception_type.dart';

class SignInKeyfileDrawerPageState extends Equatable {
  final KeyfileExceptionType? keyfileExceptionType;
  final bool isLoadingBool;
  final bool signInSuccessBool;

  const SignInKeyfileDrawerPageState({
    this.keyfileExceptionType,
    this.isLoadingBool = false,
    this.signInSuccessBool = false,
  });

  SignInKeyfileDrawerPageState copyWith({
    KeyfileExceptionType? Function()? keyfileExceptionType,
    bool? isLoadingBool,
    bool? signInSuccessBool,
  }) {
    return SignInKeyfileDrawerPageState(
      keyfileExceptionType: keyfileExceptionType == null ? this.keyfileExceptionType : keyfileExceptionType.call(),
      isLoadingBool: isLoadingBool ?? this.isLoadingBool,
      signInSuccessBool: signInSuccessBool ?? this.signInSuccessBool,
    );
  }

  bool get isSignInDisabled => keyfileExceptionType != null || isLoadingBool || signInSuccessBool;

  @override
  List<Object?> get props => <Object?>[keyfileExceptionType, isLoadingBool, signInSuccessBool];
}
