import 'package:miro/infra/repositories/cache/favourites_cache_repository.dart';

class FavouritesCacheService {
  final FavouritesCacheRepository _favouritesCacheRepository;
  final String domainName;

  FavouritesCacheService({
    required this.domainName,
    FavouritesCacheRepository? favouritesCacheRepository,
  }) : _favouritesCacheRepository = favouritesCacheRepository ?? FavouritesCacheRepository();

  Future<void> add(String favouriteId) async {
    await _favouritesCacheRepository.add(domainName, favouriteId);
  }

  Future<void> delete(String favouriteId) async {
    await _favouritesCacheRepository.delete(domainName, favouriteId);
  }

  Set<String> getAll() {
    return _favouritesCacheRepository.getAll(domainName);
  }
}
