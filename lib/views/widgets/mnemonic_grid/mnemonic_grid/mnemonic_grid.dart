import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miro/blocs/widgets/mnemonic_grid/grid/mnemonic_grid_cubit.dart';
import 'package:miro/blocs/widgets/mnemonic_grid/grid/mnemonic_grid_state.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/generated/l10n.dart';
import 'package:miro/views/widgets/kira/kira_tab_bar/kira_tab_bar.dart';
import 'package:miro/views/widgets/mnemonic_grid/mnemonic_grid/mnemonic_text_field.dart';

class MnemonicGrid extends StatefulWidget {
  final MnemonicGridCubit mnemonicGridCubit;
  final double cellsGap;
  final double cellHeight;
  final int columnCount;

  const MnemonicGrid({
    required this.mnemonicGridCubit,
    this.cellsGap = 10,
    this.cellHeight = 30,
    this.columnCount = 2,
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MnemonicGrid();
}

class _MnemonicGrid extends State<MnemonicGrid> with SingleTickerProviderStateMixin {
  final List<int> availableMnemonicSizes = <int>[24, 21, 18, 15, 12];

  late final TabController tabController = TabController(
    length: availableMnemonicSizes.length,
    vsync: this,
    initialIndex: availableMnemonicSizes.indexOf(24),
  );

  @override
  void initState() {
    super.initState();
    tabController.addListener(_updateMnemonicGridSize);
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          S.of(context).mnemonicWordsSelectAmount,
          style: textTheme.bodySmall!.copyWith(
            color: DesignColors.white2,
          ),
        ),
        const SizedBox(height: 10),
        KiraTabBar(
          tabController: tabController,
          tabs: availableMnemonicSizes.map((int mnemonicSize) => Tab(text: mnemonicSize.toString())).toList(),
        ),
        const SizedBox(height: 30),
        BlocBuilder<MnemonicGridCubit, MnemonicGridState>(
          bloc: widget.mnemonicGridCubit,
          builder: (BuildContext context, MnemonicGridState mnemonicGridState) {
            return SizedBox(
              width: double.infinity,
              height: _calculateGridHeight(mnemonicGridState.cellsCount),
              child: GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: widget.columnCount,
                  mainAxisSpacing: widget.cellsGap,
                  crossAxisSpacing: widget.cellsGap,
                  mainAxisExtent: widget.cellHeight,
                ),
                itemCount: mnemonicGridState.cellsCount,
                itemBuilder: (BuildContext context, int index) {
                  return MnemonicTextField(
                    key: Key(index.toString()),
                    mnemonicTextFieldCubit: mnemonicGridState.mnemonicTextFieldCubitList[index],
                  );
                },
              ),
            );
          },
        ),
      ],
    );
  }

  void _updateMnemonicGridSize() {
    int selectedIndex = tabController.index;
    int newMnemonicSize = availableMnemonicSizes[selectedIndex];
    widget.mnemonicGridCubit.updateMnemonicGridSize(mnemonicGridSize: newMnemonicSize);
  }

  double _calculateGridHeight(int cellsCount) {
    int rowsCount = (cellsCount / widget.columnCount).ceil();
    double textFieldsSize = rowsCount * widget.cellHeight;
    double paddingSize = rowsCount * widget.cellsGap;
    return textFieldsSize + paddingSize;
  }
}
