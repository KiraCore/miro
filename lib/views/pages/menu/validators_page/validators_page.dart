import 'package:flutter/material.dart';
import 'package:miro/config/app_sizes.dart';
import 'package:miro/config/theme/design_colors.dart';
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

class ValidatorsPage extends StatefulWidget {
  const ValidatorsPage({
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ValidatorsPage();
}

class _ValidatorsPage extends State<ValidatorsPage> {
  final ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    double listHeight = MediaQuery.of(context).size.height - 300;
    Widget listHeaderWidget = ValidatorListItemDesktopLayout(
      height: 64,
      favouriteButtonWidget: const SizedBox(),
      topWidget: Text('Top', style: textTheme.caption!.copyWith(color: DesignColors.white1)),
      monikerWidget: Text('Moniker', style: textTheme.caption!.copyWith(color: DesignColors.white1)),
      statusWidget: Text('Status', style: textTheme.caption!.copyWith(color: DesignColors.white1)),
      uptimeWidget: Text('Uptime', style: textTheme.caption!.copyWith(color: DesignColors.white1)),
      streakWidget: Text('Streak', style: textTheme.caption!.copyWith(color: DesignColors.white1)),
    );

    return CustomScrollView(
      controller: scrollController,
      slivers: <Widget>[
        SliverPadding(
          padding: AppSizes.getPagePadding(context),
          sliver: SliverInfinityList<ValidatorModel>(
            defaultSortOption: ValidatorsSortOptions.sortByTop,
            itemBuilder: (ValidatorModel validatorModel) => ValidatorListItemBuilder(
              key: Key(validatorModel.toString()),
              validatorModel: validatorModel,
              scrollController: scrollController,
            ),
            listController: ValidatorsListController(),
            searchComparator: ValidatorsFilterOptions.search,
            scrollController: scrollController,
            singlePageSize: listHeight ~/ ValidatorListItemDesktop.height + 5,
            hasBackground: ResponsiveWidget.isLargeScreen(context),
            listHeaderWidget: ResponsiveWidget.isLargeScreen(context) ? listHeaderWidget : null,
            title: const ValidatorListTitle(),
          ),
        ),
      ],
    );
  }
}
