import 'dart:math';

import 'package:flutter/material.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/generated/l10n.dart';
import 'package:miro/views/widgets/buttons/kira_outlined_button.dart';
import 'package:miro/views/widgets/generic/mouse_state_listener.dart';
import 'package:miro/views/widgets/generic/responsive/responsive_widget.dart';

class ExpandableText extends StatefulWidget {
  final int initialTextLength;
  final int textLengthSeeMore;
  final Text text;

  const ExpandableText({
    required this.initialTextLength,
    required this.textLengthSeeMore,
    required this.text,
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ExpandableText();
}

class _ExpandableText extends State<ExpandableText> {
  int visibleSectionsCount = 0;

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    int totalSectionsCount = ((widget.text.data!.length - widget.initialTextLength) / widget.textLengthSeeMore).ceil();

    bool fullTextVisibleBool = visibleSectionsCount == totalSectionsCount;
    bool initialTextOverflowedBool = (widget.text.data?.length ?? 0) >= widget.initialTextLength;
    bool showSeeMoreBool = fullTextVisibleBool == false && initialTextOverflowedBool;

    int textEndPosition = totalSectionsCount == 0 ? widget.initialTextLength : widget.initialTextLength + visibleSectionsCount * widget.textLengthSeeMore;
    String visibleText = widget.text.data!.substring(0, min(textEndPosition, widget.text.data?.length ?? 0));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        RichText(
          text: TextSpan(
            text: '${visibleText}${showSeeMoreBool ? '... ' : ''}',
            style: widget.text.style,
            children: <InlineSpan>[
              if (showSeeMoreBool) ...<InlineSpan>[
                WidgetSpan(
                  child: MouseStateListener(
                    onTap: () => setState(() => visibleSectionsCount += 1),
                    childBuilder: (Set<MaterialState> states) {
                      bool seeMoreHoveredBool = states.contains(MaterialState.hovered);

                      Widget textButton = Text(
                        S.of(context).seeMore,
                        style: (ResponsiveWidget.isLargeScreen(context) ? textTheme.caption : textTheme.bodyText2)?.copyWith(
                          overflow: TextOverflow.visible,
                          color: seeMoreHoveredBool ? DesignColors.white1 : DesignColors.greenStatus1,
                          fontWeight: FontWeight.bold,
                        ),
                      );

                      if (ResponsiveWidget.isLargeScreen(context)) {
                        return Padding(padding: EdgeInsets.zero, child: textButton);
                      } else {
                        return textButton;
                      }
                    },
                  ),
                ),
              ],
            ],
          ),
        ),
        if (showSeeMoreBool) ...<Widget>[
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              KiraOutlinedButton(
                height: 28,
                width: 90,
                trailing: const Icon(Icons.arrow_downward_outlined, size: 14),
                uppercaseBool: false,
                onPressed: () => setState(() => visibleSectionsCount = totalSectionsCount),
                title: S.of(context).seeAll,
              ),
            ],
          ),
        ],
      ],
    );
  }
}
