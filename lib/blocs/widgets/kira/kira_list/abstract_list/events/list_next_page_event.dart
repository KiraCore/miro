import 'package:miro/blocs/widgets/kira/kira_list/abstract_list/a_list_event.dart';

class ListNextPageEvent extends AListEvent {
  final bool afterReloadBool;

  const ListNextPageEvent({
    this.afterReloadBool = false,
  });

  @override
  List<Object?> get props => <Object?>[
    afterReloadBool,
  ];
}
