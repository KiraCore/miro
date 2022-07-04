import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miro/blocs/abstract_blocs/list_bloc/list_bloc.dart';
import 'package:miro/blocs/abstract_blocs/list_bloc/list_state/list_state.dart';
import 'package:miro/shared/utils/list/i_list_item.dart';

class KiraListLayout<T extends IListItem, B extends ListBloc<T>> extends StatelessWidget {
  final Widget child;
  final Widget? title;

  const KiraListLayout({
    required this.child,
    this.title,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<B, ListState>(
      builder: (BuildContext context, ListState state) {
        return Column(
          children: <Widget>[
            if (title != null) ...<Widget>[
              title!,
              const SizedBox(height: 32),
            ],
            child,
          ],
        );
      },
    );
  }
}
