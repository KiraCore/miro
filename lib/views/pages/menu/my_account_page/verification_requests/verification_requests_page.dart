import 'package:flutter/material.dart';
import 'package:miro/blocs/widgets/kira/kira_list/filters/filters_bloc.dart';
import 'package:miro/blocs/widgets/kira/kira_list/sort/sort_bloc.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/generated/l10n.dart';
import 'package:miro/shared/controllers/menu/my_account_page/verification_requests_list_controller/verification_requests_filter_options.dart';
import 'package:miro/shared/controllers/menu/my_account_page/verification_requests_list_controller/verification_requests_list_controller.dart';
import 'package:miro/shared/controllers/menu/my_account_page/verification_requests_list_controller/verification_requests_sort_options.dart';
import 'package:miro/shared/models/identity_registrar/ir_inbound_verification_request_model.dart';
import 'package:miro/shared/models/wallet/wallet_address.dart';
import 'package:miro/views/pages/menu/my_account_page/verification_requests/verification_request_list_item/desktop/verification_request_list_item_desktop_layout.dart';
import 'package:miro/views/pages/menu/my_account_page/verification_requests/verification_request_list_item/verification_request_list_item_builder.dart';
import 'package:miro/views/pages/menu/my_account_page/verification_requests/verification_requests_list_title/verification_requests_list_title.dart';
import 'package:miro/views/widgets/generic/responsive/responsive_value.dart';
import 'package:miro/views/widgets/generic/responsive/responsive_widget.dart';
import 'package:miro/views/widgets/kira/kira_list/infinity_list/sliver_infinity_list/sliver_infinity_list.dart';

class VerificationRequestsPage extends StatefulWidget {
  final WalletAddress walletAddress;
  final ScrollController parentScrollController;

  const VerificationRequestsPage({
    required this.walletAddress,
    required this.parentScrollController,
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _VerificationRequestsPage();
}

class _VerificationRequestsPage extends State<VerificationRequestsPage> {
  final TextEditingController searchBarTextEditingController = TextEditingController();

  final SortBloc<IRInboundVerificationRequestModel> sortBloc = SortBloc<IRInboundVerificationRequestModel>(
    defaultSortOption: VerificationRequestsSortOptions.sortByDate.reversed(),
  );
  final FiltersBloc<IRInboundVerificationRequestModel> filtersBloc = FiltersBloc<IRInboundVerificationRequestModel>(
    searchComparator: VerificationRequestsFilterOptions.search,
  );

  late final VerificationRequestsListController verificationRequestsListController = VerificationRequestsListController(walletAddress: widget.walletAddress);

  @override
  void dispose() {
    searchBarTextEditingController.dispose();
    sortBloc.close();
    filtersBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    double listHeight = MediaQuery.of(context).size.height - 470;
    double itemSize = const ResponsiveValue<double>(largeScreen: 70, smallScreen: 180).get(context);

    Widget listHeaderWidget = Container(
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(color: DesignColors.grey2, width: 1),
        ),
      ),
      child: VerificationRequestListItemDesktopLayout(
        height: 53,
        infoButtonWidget: const SizedBox(),
        requesterAddressWidget: Text(S.of(context).irVerificationRequestsFrom, style: textTheme.caption!.copyWith(color: DesignColors.white1)),
        dateWidget: Text(S.of(context).irVerificationRequestsCreationDate, style: textTheme.caption!.copyWith(color: DesignColors.white1)),
        keysWidget: Text(S.of(context).irVerificationRequestsRecords, style: textTheme.caption!.copyWith(color: DesignColors.white1)),
        tipWidget: Text(S.of(context).irVerificationRequestsTip, style: textTheme.caption!.copyWith(color: DesignColors.white1)),
      ),
    );

    return SliverInfinityList<IRInboundVerificationRequestModel>(
      sortBloc: sortBloc,
      filtersBloc: filtersBloc,
      itemBuilder: (IRInboundVerificationRequestModel irInboundVerificationRequestModel) => VerificationRequestListItemBuilder(
        irInboundVerificationRequestModel: irInboundVerificationRequestModel,
      ),
      listController: verificationRequestsListController,
      scrollController: widget.parentScrollController,
      hasBackgroundBool: ResponsiveWidget.isLargeScreen(context),
      singlePageSize: listHeight ~/ itemSize + 5,
      listHeaderWidget: ResponsiveWidget.isLargeScreen(context) ? listHeaderWidget : null,
      title: VerificationRequestsListTitle(searchBarTextEditingController: searchBarTextEditingController),
    );
  }
}
