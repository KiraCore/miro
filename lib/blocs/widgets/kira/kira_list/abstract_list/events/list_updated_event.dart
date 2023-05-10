import 'package:miro/blocs/widgets/kira/kira_list/abstract_list/a_list_event.dart';

class ListUpdatedEvent extends AListEvent {
  final bool jumpToTop;

  const ListUpdatedEvent({
    required this.jumpToTop,
  });
}
