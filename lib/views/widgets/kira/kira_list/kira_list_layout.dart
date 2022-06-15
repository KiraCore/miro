import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miro/blocs/abstract_blocs/list_bloc/list_bloc.dart';
import 'package:miro/blocs/abstract_blocs/list_bloc/list_state/list_state.dart';

class KiraListLayout<ItemType, ListBlocType extends ListBloc<ItemType>> extends StatelessWidget {
  final Widget child;
  final Widget? title;

  const KiraListLayout({
    required this.child,
    this.title,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ListBlocType, ListState>(
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
