import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:miro/blocs/widgets/kira/kira_list/favourites/favourites_bloc.dart';
import 'package:miro/blocs/widgets/kira/kira_list/filters/filters_bloc.dart';
import 'package:miro/blocs/widgets/kira/kira_list/sort/sort_bloc.dart';
import 'package:miro/config/app_sizes.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/generated/l10n.dart';
import 'package:miro/shared/controllers/menu/validators_page/validators_filter_options.dart';
import 'package:miro/shared/controllers/menu/validators_page/validators_list_controller.dart';
import 'package:miro/shared/controllers/menu/validators_page/validators_sort_options.dart';
import 'package:miro/shared/models/validators/validator_model.dart';
import 'package:miro/views/pages/menu/validators_page/validator_list_item/desktop/validator_list_item_desktop.dart';
import 'package:miro/views/pages/menu/validators_page/validator_list_item/desktop/validator_list_item_desktop_layout.dart';
import 'package:miro/views/pages/menu/validators_page/validator_list_item/validator_list_item_builder.dart';
import 'package:miro/views/pages/menu/validators_page/validator_list_title/validator_list_title.dart';
import 'package:miro/views/widgets/generic/responsive/responsive_widget.dart';
import 'package:miro/views/widgets/kira/kira_list/infinity_list/sliver_infinity_list/sliver_infinity_list.dart';

@RoutePage()
class ValidatorsPage extends StatefulWidget {
  const ValidatorsPage({
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ValidatorsPage();
}

class _ValidatorsPage extends State<ValidatorsPage> {
  final TextEditingController searchBarTextEditingController = TextEditingController();
  final ScrollController scrollController = ScrollController();
  final ValidatorsListController validatorsListController = ValidatorsListController();
  final FiltersBloc<ValidatorModel> filtersBloc = FiltersBloc<ValidatorModel>(
    searchComparator: ValidatorsFilterOptions.search,
  );

  final SortBloc<ValidatorModel> sortBloc = SortBloc<ValidatorModel>(
    defaultSortOption: ValidatorsSortOptions.sortByTop,
  );

  late final FavouritesBloc<ValidatorModel> favouritesBloc = FavouritesBloc<ValidatorModel>(
    listController: validatorsListController,
  );

  @override
  void dispose() {
    searchBarTextEditingController.dispose();
    scrollController.dispose();
    filtersBloc.close();
    sortBloc.close();
    favouritesBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    double listHeight = MediaQuery.of(context).size.height - 300;
    Widget listHeaderWidget = ValidatorListItemDesktopLayout(
      height: 64,
      favouriteButtonWidget: const SizedBox(),
      topWidget: Text(S.of(context).validatorsTableTop, style: textTheme.bodySmall!.copyWith(color: DesignColors.white1)),
      monikerWidget: Text(S.of(context).validatorsTableMoniker, style: textTheme.bodySmall!.copyWith(color: DesignColors.white1)),
      statusWidget: Text(S.of(context).validatorsTableStatus, style: textTheme.bodySmall!.copyWith(color: DesignColors.white1)),
      uptimeWidget: Text(S.of(context).validatorsTableUptime, style: textTheme.bodySmall!.copyWith(color: DesignColors.white1)),
      streakWidget: Text(S.of(context).validatorsTableStreak, style: textTheme.bodySmall!.copyWith(color: DesignColors.white1)),
    );

    return CustomScrollView(
      controller: scrollController,
      slivers: <Widget>[
        SliverPadding(
          padding: AppSizes.getPagePadding(context),
          sliver: SliverInfinityList<ValidatorModel>(
            itemBuilder: (ValidatorModel validatorModel) => ValidatorListItemBuilder(
              key: Key(validatorModel.toString()),
              validatorModel: validatorModel,
              scrollController: scrollController,
            ),
            listController: ValidatorsListController(),
            scrollController: scrollController,
            singlePageSize: listHeight ~/ ValidatorListItemDesktop.height + 5,
            hasBackgroundBool: ResponsiveWidget.isLargeScreen(context),
            listHeaderWidget: ResponsiveWidget.isLargeScreen(context) ? listHeaderWidget : null,
            title: ValidatorListTitle(searchBarTextEditingController: searchBarTextEditingController),
            sortBloc: sortBloc,
            filtersBloc: filtersBloc,
            favouritesBloc: favouritesBloc,
          ),
        ),
      ],
    );
  }
}
