abstract class ACacheRepository {
  T get<T>({required String boxName, required String key, required T defaultValue});

  Map<String, T> getAll<T>({required String boxName});

  void add<T>({required String boxName, required String key, required T value});

  void delete<T>({required String boxName, required String key});
}