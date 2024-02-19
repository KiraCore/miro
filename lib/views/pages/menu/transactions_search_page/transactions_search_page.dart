import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/views/widgets/kira/kira_search_bar.dart';

@RoutePage()
class TransactionsSearchPage extends StatefulWidget {
  const TransactionsSearchPage({super.key});

  @override
  State<TransactionsSearchPage> createState() => _TransactionsSearchPageState();
}

class _TransactionsSearchPageState extends State<TransactionsSearchPage> {
  final TextEditingController searchBarTextEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return KiraSearchBar(
      textEditingController: searchBarTextEditingController,
      textStyle: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: DesignColors.white1,
      ),
    );
  }
}
