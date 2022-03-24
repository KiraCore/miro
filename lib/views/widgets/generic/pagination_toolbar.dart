library flutter_web_pagination;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/shared/utils/custom_text_input_formatter.dart';

class PaginationToolbar extends StatefulWidget {
  final int currentPage;
  final int totalPage;
  final ValueChanged<int> onPageChanged;

  const PaginationToolbar({
    required this.onPageChanged,
    required this.currentPage,
    required this.totalPage,
    Key? key,
  }) : super(key: key);

  @override
  _PaginationToolbarState createState() => _PaginationToolbarState();
}

class _PaginationToolbarState extends State<PaginationToolbar> {
  late int currentPage = widget.currentPage;
  late int totalPage = widget.totalPage;
  late TextEditingController controller = TextEditingController();

  @override
  void didUpdateWidget(covariant PaginationToolbar oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.currentPage != widget.currentPage || oldWidget.totalPage != widget.totalPage) {
      setState(() {
        currentPage = widget.currentPage;
        totalPage = widget.totalPage;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        ..._buildPageItemList(),
        const SizedBox(width: 10),
        _buildPageInput(),
        const SizedBox(width: 10),
        _PageControlButton(
            enable: true,
            title: 'GO',
            onTap: () {
              setState(() {
                try {
                  _updatePage(int.parse(controller.text));
                  controller.clear();
                } catch (e) {
                  // print(e);
                }
              });
            })
      ],
    );
  }

  void _updatePage(int page) {
    setState(() {
      currentPage = page;
    });
    widget.onPageChanged(page);
  }

  List<Widget> _buildPageItemList() {
    List<Widget> widgetList = <Widget>[
      _PageControlButton(
        enable: currentPage > 1,
        title: '«',
        onTap: () {
          _updatePage(currentPage - 1);
        },
      )
    ];

    int _page = currentPage - 5;
    _page = _page < 1 ? 1 : _page;
    for (; _page <= currentPage; _page++) {
      widgetList.add(
        _PageItem(
          page: _page,
          isChecked: _page == currentPage,
          onTap: _updatePage,
        ),
      );
    }

    int endPage = _page + 4;

    endPage = endPage > totalPage ? totalPage : endPage;
    for (; _page <= endPage; _page++) {
      widgetList.add(_PageItem(
        page: _page,
        isChecked: _page == currentPage,
        onTap: _updatePage,
      ));
    }

    widgetList.add(_PageControlButton(
      enable: currentPage < totalPage,
      title: '»',
      onTap: () {
        _updatePage(currentPage + 1);
      },
    ));
    return widgetList;
  }

  Widget _buildPageInput() {
    return Container(
      height: 40,
      padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(2), border: Border.all(color: const Color(0xFFE3E3E3), width: 1)),
      width: 50,
      child: TextField(
        controller: controller,
        textAlign: TextAlign.center,
        maxLines: 1,
        inputFormatters: CustomTextInputFormatter.getIntFormatter(maxValue: totalPage.toDouble()),
        style: const TextStyle(
            textBaseline: TextBaseline.alphabetic,
            color: DesignColors.gray2_40,
            fontSize: 15,
            height: 1.5,
            fontWeight: FontWeight.w600),
        decoration: InputDecoration(
            contentPadding: EdgeInsets.zero,
            hintText: totalPage.toString(),
            hintStyle: const TextStyle(color: Color(0xFFA3A3A3), fontSize: 15, fontWeight: FontWeight.normal),
            border: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.transparent),
            ),
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.transparent),
            ),
            disabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.transparent),
            ),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.transparent),
            )),
      ),
    );
  }
}

class _PageControlButton extends StatefulWidget {
  final bool enable;
  final String title;
  final VoidCallback onTap;

  const _PageControlButton({
    required this.enable,
    required this.title,
    required this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  _PageControlButtonState createState() => _PageControlButtonState();
}

class _PageControlButtonState extends State<_PageControlButton> {
  Color normalTextColor = DesignColors.gray2_100;
  late Color textColor = widget.enable ? normalTextColor : Colors.grey;

  @override
  void didUpdateWidget(_PageControlButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.enable != widget.enable) {
      setState(() {
        textColor = widget.enable ? normalTextColor : Colors.grey;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.enable ? widget.onTap : null,
      onHover: (bool b) {
        if (!widget.enable) return;
        setState(() {
          textColor = b ? normalTextColor.withAlpha(200) : normalTextColor;
        });
      },
      child: _ItemContainer(
        child: Text(
          widget.title,
          style: TextStyle(color: textColor, fontSize: 14),
        ),
      ),
    );
  }
}

class _PageItem extends StatefulWidget {
  final int page;
  final bool isChecked;
  final ValueChanged<int> onTap;

  const _PageItem({
    required this.page,
    required this.isChecked,
    required this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  __PageItemState createState() => __PageItemState();
}

class __PageItemState extends State<_PageItem> {
  Color normalHighlightColor = DesignColors.gray2_100;

  late Color highlightColor = normalHighlightColor;

  @override
  void didUpdateWidget(covariant _PageItem oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.isChecked != widget.isChecked) {
      if (!widget.isChecked) {
        setState(() {
          highlightColor = normalHighlightColor;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () {
          widget.onTap(widget.page);
        },
        icon: _ItemContainer(
          child: Text(
            widget.page.toString(),
            style: TextStyle(
                color: widget.isChecked ? Colors.white : highlightColor, fontWeight: FontWeight.w600, fontSize: 14),
          ),
        ));
  }
}

class _ItemContainer extends StatelessWidget {
  final Widget child;

  const _ItemContainer({
    required this.child,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      constraints: const BoxConstraints(minWidth: 40, minHeight: 40),
      child: child,
    );
  }
}
