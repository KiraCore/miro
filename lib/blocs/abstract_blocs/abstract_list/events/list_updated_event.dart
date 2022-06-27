import 'package:miro/blocs/abstract_blocs/abstract_list/a_list_event.dart';

class ListUpdatedEvent extends AListEvent {
  final bool jumpToTop;

  const ListUpdatedEvent({
    required this.jumpToTop,
  });
}
