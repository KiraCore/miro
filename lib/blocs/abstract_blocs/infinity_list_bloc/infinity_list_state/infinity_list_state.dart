import 'package:miro/blocs/abstract_blocs/list_bloc/list_state/list_loaded_state.dart';

class InfinityListLoadedState<T> extends ListLoadedState<T> {
  final bool lastPage;

  InfinityListLoadedState({
    required this.lastPage,
    required List<T> data,
  }) : super(data: data);

  @override
  List<Object?> get props => <Object>[data, lastPage];
}
