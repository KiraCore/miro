import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:miro/blocs/abstract_blocs/list_bloc/list_bloc.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/providers/network_provider.dart';
import 'package:miro/shared/utils/app_logger.dart';
import 'package:miro/views/widgets/generic/center_load_spinner.dart';
import 'package:miro/views/widgets/generic/responsive/responsive_widget.dart';
import 'package:miro/views/widgets/kira/kira_list/models/sort_option.dart';
import 'package:miro/views/widgets/kira/kira_list/search_option_widget.dart';
import 'package:miro/views/widgets/kira/kira_list/sort_option_widget.dart';
import 'package:provider/provider.dart';

class KiraList<E, T extends ListBloc<E>> extends StatefulWidget {
  final ScrollController scrollController;
  final Widget Function(E item) itemBuilder;
  final List<SortOption<E>>? sortOptions;
  final SearchCallback<E>? searchCallback;
  final Color? backgroundColor;
  final bool shrinkWrap;
  final List<Widget>? customFilterWidgets;

  const KiraList({
    required this.itemBuilder,
    required this.scrollController,
    this.customFilterWidgets,
    this.backgroundColor,
    this.searchCallback,
    this.sortOptions,
    this.shrinkWrap = false,
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _KiraList<E, T>();
}

class _KiraList<E, T extends ListBloc<E>> extends State<KiraList<E, T>> {
  NetworkProvider networkProvider = globalLocator<NetworkProvider>();
  bool downloadingStatus = false;

  @override
  void initState() {
    widget.scrollController.addListener(_fetchDataAfterReachedMax);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        _buildListHeader(),
        const SizedBox(height: 20),
        Container(
          constraints: BoxConstraints(
            minHeight: MediaQuery.of(context).size.height - 440,
          ),
          child: BlocBuilder<T, ListState>(
            builder: (_, ListState state) => _buildListBody(state),
          ),
        ),
      ],
    );
  }

  void _fetchDataAfterReachedMax() {
    bool reachedMax = widget.scrollController.offset > widget.scrollController.position.maxScrollExtent - 200;
    if (reachedMax) {
      BlocProvider.of<T>(context).add(GetNextPageEvent());
    }
  }

  Widget _buildListBody(ListState state) {
    if (state is ListEmptyState<E>) {
      return const Center(child: Text('No results'));
    } else if (state is ListLoadedState<E>) {
      return _buildList(state);
    } else if (state is ListErrorState) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const <Widget>[
          Icon(
            Icons.wifi_off,
            size: 40,
            color: DesignColors.red,
          ),
          SizedBox(height: 20),
          Text(
            'No interx connection specified',
            style: TextStyle(
              color: DesignColors.red,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      );
    } else {
      return const CenterLoadSpinner();
    }
  }

  Widget _buildListHeader() {
    return ResponsiveWidget(
      largeScreen: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              if (widget.sortOptions != null) _buildSortOptionsWidget(),
              if (widget.customFilterWidgets != null)
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: widget.customFilterWidgets!,
                  ),
                ),
              if (widget.searchCallback != null) _buildSearchOptionsWidget(),
            ],
          ),
          _buildLastUpdateTimeWidget(),
        ],
      ),
      mediumScreen: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          if (widget.searchCallback != null)
            Row(
              children: <Widget>[
                Expanded(
                  child: _buildSearchOptionsWidget(),
                ),
              ],
            ),
          const SizedBox(height: 15),
          Row(
            children: <Widget>[
              if (widget.sortOptions != null) _buildSortOptionsWidget(),
              if (widget.customFilterWidgets != null)
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: widget.customFilterWidgets!,
                  ),
                ),
            ],
          ),
          const SizedBox(height: 10),
          _buildLastUpdateTimeWidget(),
        ],
      ),
    );
  }

  Widget _buildLastUpdateTimeWidget() {
    return Consumer<NetworkProvider>(
      builder: (_, __, ___) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            const Text(
              'Last updated:',
              style: TextStyle(
                fontSize: 13,
                color: DesignColors.gray2_100,
              ),
            ),
            const SizedBox(width: 8),
            Text(
              _getLastUpdateTime(),
              style: const TextStyle(
                fontSize: 12,
                color: DesignColors.white_100,
              ),
            ),
          ],
        );
      },
    );
  }

  String _getLastUpdateTime() {
    String? latestBlockTimeString = networkProvider.networkModel?.queryInterxStatus?.syncInfo.latestBlockTime;
    if (latestBlockTimeString != null) {
      try {
        DateTime latestBlockTime = DateTime.parse(latestBlockTimeString).toLocal();
        String formattedDate = DateFormat('HH:mm dd.MM.yyyy').format(latestBlockTime);
        return formattedDate;
      } catch (_) {
        AppLogger().log(message: 'Error while parsing latest bloc time: $latestBlockTimeString');
      }
    }
    return '---';
  }

  Widget _buildSortOptionsWidget() {
    return SortOptionWidget<E, T>(
      sortOptions: widget.sortOptions!,
    );
  }

  Widget _buildSearchOptionsWidget() {
    return SearchOptionWidget<E>(
      searchCallback: widget.searchCallback!,
      onChanged: (String value) {
        BlocProvider.of<T>(context).add(SearchEvent<E>((E item) => widget.searchCallback!(item, value)));
      },
    );
  }

  Widget _buildList(ListLoadedState<E> state) {
    int finalListLength = state.listItems.length;
    if (!state.listEndStatus) {
      finalListLength += 1;
    }
    return Container(
      decoration: BoxDecoration(
        color: widget.backgroundColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: ListView.builder(
        controller: ScrollController(),
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: finalListLength,
        itemBuilder: (BuildContext context, int index) {
          if (!state.listEndStatus && index == finalListLength - 1) {
            return const Padding(
              padding: EdgeInsets.symmetric(vertical: 15),
              child: SpinKitThreeBounce(
                size: 15,
                color: Colors.white,
              ),
            );
          }
          E item = state.listItems.toList()[index];
          return widget.itemBuilder(item);
        },
      ),
    );
  }
}
