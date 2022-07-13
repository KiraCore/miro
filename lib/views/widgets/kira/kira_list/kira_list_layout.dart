import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miro/blocs/abstract_blocs/abstract_list/a_list_bloc.dart';
import 'package:miro/blocs/abstract_blocs/abstract_list/a_list_state.dart';
import 'package:miro/blocs/abstract_blocs/abstract_list/models/a_list_item.dart';
import 'package:miro/blocs/abstract_blocs/abstract_list/states/list_loaded_state.dart';

class KiraListLayout<T extends AListItem, B extends AListBloc<T>> extends StatelessWidget {
  final Widget child;
  final Widget? title;

  const KiraListLayout({
    required this.child,
    this.title,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<B, AListState>(
      builder: (BuildContext context, AListState state) {
        return Column(
          children: <Widget>[
            if (title != null) ...<Widget>[
              if (state is! ListLoadedState)
                Opacity(
                  opacity: 0.4,
                  child: Stack(
                    children: <Widget>[
                      title!,
                      Positioned.fill(child: Container(color: Colors.transparent)),
                    ],
                  ),
                )
              else
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
