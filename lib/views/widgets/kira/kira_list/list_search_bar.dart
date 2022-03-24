import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miro/blocs/abstract_blocs/list_bloc/list_bloc.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/views/widgets/generic/search_bar.dart';

typedef SearchCallback<E> = bool Function(E item, String searchValue);

const double _kSearchBarHeight = 48.0;
const double _kSearchBarWidth = 285.0;

class ListSearchBar<E, T extends ListBloc<E>> extends StatefulWidget {
  final SearchCallback<E> searchCallback;

  const ListSearchBar({
    required this.searchCallback,
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ListSearchBar<E, T>();
}

class _ListSearchBar<E, T extends ListBloc<E>> extends State<ListSearchBar<E, T>> {
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    BlocProvider.of<T>(context).stream.listen(_onListStateChanged);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: _kSearchBarHeight,
      width: _kSearchBarWidth,
      child: SearchBar(
        controller: _controller,
        label: 'Search',
        onChanged: (String value) => _onChanged(context, value),
        backgroundColor: DesignColors.blue1_10,
        border: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.transparent),
          borderRadius: BorderRadius.circular(8),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.transparent),
          borderRadius: BorderRadius.circular(8),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.transparent),
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }

  void _onListStateChanged(ListState state) {
    if (state is ListFilteredState && state is! ListSearchedState) {
      _controller.text = '';
    }
  }

  void _onChanged(BuildContext context, String value) {
    if (value.isNotEmpty) {
      BlocProvider.of<T>(context).add(SearchEvent<E>((E item) => widget.searchCallback(item, value)));
    } else {
      BlocProvider.of<T>(context).add(FilterEvent<E>());
    }
  }
}
