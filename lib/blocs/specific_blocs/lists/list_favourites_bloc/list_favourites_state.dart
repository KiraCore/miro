import 'package:equatable/equatable.dart';

class ListFavouritesState extends Equatable {
  const ListFavouritesState();

  @override
  List<Object?> get props => <Object>[];
}

class ListFavouritesLoaded extends ListFavouritesState {
  const ListFavouritesLoaded();

  @override
  List<Object?> get props => <Object>[DateTime.now()];
}
