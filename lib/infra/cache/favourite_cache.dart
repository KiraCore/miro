import 'package:hive/hive.dart';

class FavouriteCache {
  final String workspaceName;

  FavouriteCache({
    required this.workspaceName,
  });

  bool get({required String id}) {
    return Hive.box<bool>(workspaceName).get(id, defaultValue: false)!;
  }

  void add({required String id, required bool value}) {
    Hive.box<bool>(workspaceName).put(id, value);
  }

  void delete({required String id}) {
    Hive.box<bool>(workspaceName).delete(id);
  }

  Map<String, bool> getAll() {
    return Hive.box<bool>(workspaceName).toMap() as Map<String, bool>;
  }
}
