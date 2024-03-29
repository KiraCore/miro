import 'package:miro/blocs/widgets/kira/kira_list/favourites/a_favourites_state.dart';

class FavouritesLoadedState<T> extends AFavouritesState {
  final List<T> favourites;

  const FavouritesLoadedState({
    required this.favourites,
  });

  @override
  List<Object?> get props => <Object>[favourites];
}
