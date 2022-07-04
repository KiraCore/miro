import 'package:equatable/equatable.dart';

class ListFavouritesState extends Equatable {
  const ListFavouritesState();

  @override
  List<Object?> get props => <Object>[];
}

class ListFavouritesLoaded<T> extends ListFavouritesState {
  final List<T> favourites;

  const ListFavouritesLoaded({
    required this.favourites,
  });

  @override
  List<Object?> get props => <Object>[favourites];
}
