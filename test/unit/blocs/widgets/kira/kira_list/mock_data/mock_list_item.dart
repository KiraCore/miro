import 'package:miro/blocs/widgets/kira/kira_list/abstract_list/models/a_list_item.dart';

class MockListItem extends AListItem {
  final int id;
  final String name;
  final String status;
  bool _favourite;

  MockListItem({
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
    return 'MockListItem{id: $id, name: $name, status: $status}';
  }
}
