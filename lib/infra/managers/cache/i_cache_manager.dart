abstract class ICacheManager {
  Future<void> init();

  Future<void> add<T>({required String boxName, required String key, required T value});

  Future<void> delete<T>({required String boxName, required String key});

  Future<void> deleteAll<T>({required String boxName});

  T get<T>({required String boxName, required String key, required T defaultValue});

  Map<String, T> getAll<T>({required String boxName});
}
