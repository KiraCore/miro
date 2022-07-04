import 'package:miro/blocs/abstract_blocs/list_bloc/list_event/list_event.dart';

class ListUpdatedEvent extends ListEvent {
  final bool jumpToTop;

  ListUpdatedEvent({
    required this.jumpToTop,
  });
}
