import 'package:miro/blocs/abstract_blocs/abstract_list/models/a_list_item.dart';

class TestListItem extends AListItem {
  final int id;
  final String name;
  final String status;
  bool _favourite;

  TestListItem({
    required this.id,
    required this.name,
    required this.status,
    bool? favourite,
  }) : _favourite = favourite ?? false;

  @override
  String get cacheId => id.toString();

  @override
  bool get isFavourite => _favourite;

  @override
  set favourite(bool value) {
    _favourite = value;
  }

  @override
  String toString() {
    return 'TestListItem{id: $id, name: $name, status: $status}';
  }
}
