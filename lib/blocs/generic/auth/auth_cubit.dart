import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miro/shared/models/wallet/wallet.dart';

class AuthCubit extends Cubit<Wallet?> {
  AuthCubit() : super(null);

  Future<void> signIn(Wallet wallet) async {
    emit(wallet);
  }

  Future<void> signOut() async {
    emit(null);
  }

  bool get isSignedIn => state != null;
}
