import 'package:flutter/cupertino.dart';
import 'package:miro/views/widgets/buttons/timed_refresh_button.dart';
import 'package:miro/views/widgets/generic/center_load_spinner.dart';
import 'package:miro/views/widgets/generic/responsive/responsive_value.dart';
import 'package:miro/views/widgets/kira/kira_list/components/last_block_time_widget.dart';
import 'package:sliver_tools/sliver_tools.dart';

class SliverListLayout extends StatelessWidget {
  final bool staticLoadingIndicatorBool;
  final bool loadingOverlayVisibleBool;
  final DateTime? cacheExpirationDateTime;
  final DateTime? lastBlockDateTime;
  final WidgetBuilder? titleBuilder;
  final List<Widget> content;
  final VoidCallback onRefresh;

  const SliverListLayout({
    required this.staticLoadingIndicatorBool,
    required this.loadingOverlayVisibleBool,
    required this.cacheExpirationDateTime,
    required this.lastBlockDateTime,
    required this.titleBuilder,
    required this.content,
    required this.onRefresh,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiSliver(
      children: <Widget>[
        if (titleBuilder != null)
          SliverOpacity(
            opacity: loadingOverlayVisibleBool ? 0.5 : 1,
            sliver: SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: IgnorePointer(
                  ignoring: loadingOverlayVisibleBool,
                  child: titleBuilder!.call(context),
                ),
              ),
            ),
          ),
        SliverOpacity(
          opacity: loadingOverlayVisibleBool ? 0.5 : 1,
          sliver: SliverToBoxAdapter(
            child: IgnorePointer(
              ignoring: loadingOverlayVisibleBool,
              child: SizedBox(
                height: const ResponsiveValue<double>(
                  largeScreen: 30,
                  smallScreen: 36,
                ).get(context),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    LastBlockTimeWidget(blockTime: lastBlockDateTime),
                    const Spacer(),
                    TimedRefreshButton(
                      expirationDateTime: cacheExpirationDateTime,
                      disabledBool: loadingOverlayVisibleBool,
                      onPressed: onRefresh,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        SliverStack(
          children: <Widget>[
            SliverPositioned.fill(
              child: SliverOpacity(
                opacity: loadingOverlayVisibleBool ? 0.5 : 1,
                sliver: SliverIgnorePointer(
                  ignoring: loadingOverlayVisibleBool,
                  sliver: MultiSliver(children: content),
                ),
              ),
            ),
            if (loadingOverlayVisibleBool && staticLoadingIndicatorBool)
              SliverPositioned.fill(
                child: SliverFillRemaining(
                  hasScrollBody: false,
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 20),
                    child: const CenterLoadSpinner(),
                  ),
                ),
              )
            else if (loadingOverlayVisibleBool)
              const SliverPositioned.fill(child: CenterLoadSpinner())
          ],
        ),
      ],
    );
  }
}
