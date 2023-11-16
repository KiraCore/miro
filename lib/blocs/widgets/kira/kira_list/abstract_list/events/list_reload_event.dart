import 'package:miro/blocs/widgets/kira/kira_list/abstract_list/a_list_event.dart';

class ListReloadEvent extends AListEvent {
  final bool forceRequestBool;
  final bool listContentVisibleBool;

  const ListReloadEvent({
    this.forceRequestBool = false,
    this.listContentVisibleBool = false,
  });

  @override
  List<Object?> get props => <Object?>[forceRequestBool, listContentVisibleBool];
}
