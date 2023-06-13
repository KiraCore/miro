import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miro/blocs/generic/network_module/network_module_bloc.dart';
import 'package:miro/blocs/pages/menu/visualizer/a_visualizer_state.dart';
import 'package:miro/blocs/pages/menu/visualizer/visualizer_cubit.dart';
import 'package:miro/blocs/widgets/kira/kira_list/filters/filters_bloc.dart';
import 'package:miro/config/app_sizes.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/generated/l10n.dart';
import 'package:miro/infra/services/api/query_visualizer_service.dart';
import 'package:miro/shared/controllers/menu/visualizer_page/visualizer_filter_options.dart';
import 'package:miro/shared/controllers/menu/visualizer_page/visualizer_list_controller.dart';
import 'package:miro/shared/models/visualizer/visualizer_node_model.dart';
import 'package:miro/views/pages/menu/visualizer_page/visualizer_list_item/desktop/visualizer_list_item_desktop.dart';
import 'package:miro/views/pages/menu/visualizer_page/visualizer_list_item/desktop/visualizer_list_item_desktop_layout.dart';
import 'package:miro/views/pages/menu/visualizer_page/visualizer_list_item/visualizer_list_item_builder.dart';
import 'package:miro/views/pages/menu/visualizer_page/visualizer_map/visulizer_map.dart';
import 'package:miro/views/widgets/generic/responsive/responsive_widget.dart';
import 'package:miro/views/widgets/kira/kira_list/infinity_list/sliver_infinity_list/sliver_infinity_list.dart';

@RoutePage()
class VisualizerPage extends StatefulWidget {
  const VisualizerPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _VisualizerPage();
}

class _VisualizerPage extends State<VisualizerPage> {
  final FiltersBloc<VisualizerNodeModel> filtersBloc = FiltersBloc<VisualizerNodeModel>(
    searchComparator: VisualizerFilterOptions.search,
  );
  final NetworkModuleBloc networkModuleBloc = globalLocator<NetworkModuleBloc>();
  final QueryVisualizerService queryP2PService = globalLocator<QueryVisualizerService>();
  final ScrollController scrollController = ScrollController();
  final TextEditingController searchBarTextEditingController = TextEditingController();
  final VisualizerCubit visualizerCubit = VisualizerCubit();
  final VisualizerListController visualizerListController = VisualizerListController();

  @override
  void dispose() {
    scrollController.dispose();
    searchBarTextEditingController.dispose();
    visualizerCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    TextStyle style = textTheme.bodySmall!.copyWith(color: DesignColors.white1);
    double listHeight = MediaQuery.of(context).size.height - 300;
    Widget listHeaderWidget = VisualizerListItemDesktopLayout(
      height: 64,
      monikerWidget: Row(
        children: <Widget>[
          const SizedBox(
            width: 20,
          ),
          Text(S.of(context).validatorsTableMoniker, style: style),
        ],
      ),
      ipWidget: Text(S.of(context).visualizerIpAddress, style: style),
      peersWidget: Text(S.of(context).visualizerPeers, style: style),
      countryWidget: Text(S.of(context).visualizerCountry, style: style),
      dataCenterWidget: Text(S.of(context).visualizerDataCenter, style: style),
    );

    return BlocBuilder<VisualizerCubit, AVisualizerState>(
      bloc: visualizerCubit,
      builder: (BuildContext context, AVisualizerState visualizerState) {
        List<VisualizerNodeModel> nodeModelList = <VisualizerNodeModel>[];
        if (visualizerState.visualizerNodeModelList != null) {
          nodeModelList = visualizerState.visualizerNodeModelList!;
        }
        return CustomScrollView(
          controller: scrollController,
          slivers: <Widget>[
            SliverPadding(
              padding: AppSizes.getPagePadding(context),
              sliver: SliverInfinityList<VisualizerNodeModel>(
                itemBuilder: (nodeModelList.isNotEmpty)
                    ? (VisualizerNodeModel visualizerNodeModel) => VisualizerListItemBuilder(
                          key: Key(visualizerNodeModel.toString()),
                          visualizerNodeModel: visualizerNodeModel,
                          scrollController: scrollController,
                        )
                    : (VisualizerNodeModel visualizerNodeItemModel) => const SizedBox(),
                listController: visualizerListController,
                scrollController: scrollController,
                singlePageSize: listHeight ~/ VisualizerListItemDesktop.height + 5,
                hasBackgroundBool: ResponsiveWidget.isLargeScreen(context),
                listHeaderWidget: ResponsiveWidget.isLargeScreen(context) ? listHeaderWidget : null,
                title: VisualizerMap(
                  nodeModelList: nodeModelList,
                  visualizerState: visualizerState,
                  searchBarTextEditingController: searchBarTextEditingController,
                ),
                filtersBloc: filtersBloc,
              ),
            ),
          ],
        );
      },
    );
  }
}
