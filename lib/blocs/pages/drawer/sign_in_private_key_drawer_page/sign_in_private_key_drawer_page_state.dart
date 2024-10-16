part of 'sign_in_private_key_drawer_page_cubit.dart';

abstract class ASignInPrivateKeyDrawerPageState extends Equatable {
  const ASignInPrivateKeyDrawerPageState();

  @override
  List<Object?> get props => <Object?>[];
}

// TODO(Mykyta): state of this name is unreadable. Discuss about replacing suffix with prefix
class SignInPrivateKeyDrawerPageInitialState extends ASignInPrivateKeyDrawerPageState {
  const SignInPrivateKeyDrawerPageInitialState();
}

class SignInPrivateKeyDrawerPageSuccessState extends ASignInPrivateKeyDrawerPageState {
  const SignInPrivateKeyDrawerPageSuccessState();
}

class SignInPrivateKeyDrawerPageErrorState extends ASignInPrivateKeyDrawerPageState {
  const SignInPrivateKeyDrawerPageErrorState();
}
