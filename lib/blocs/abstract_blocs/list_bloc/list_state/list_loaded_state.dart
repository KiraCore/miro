import 'package:miro/blocs/abstract_blocs/list_bloc/list_state/list_state.dart';

class ListLoadedState<T> extends ListState {
  final List<T> data;

  ListLoadedState({
    required this.data,
  });

  @override
  List<Object?> get props => <Object?>[data];
}
