import 'package:miro/blocs/widgets/kira/kira_list/abstract_list/a_list_event.dart';

class ListNextPageEvent extends AListEvent {
  final bool afterReloadBool;
  final bool forceRequestBool;

  const ListNextPageEvent({
    this.afterReloadBool = false,
    this.forceRequestBool = false,
  });

  @override
  List<Object?> get props => <Object?>[afterReloadBool, forceRequestBool];
}
