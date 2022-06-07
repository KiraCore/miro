import 'package:flutter/cupertino.dart';
import 'package:miro/views/widgets/network_list/network_custom_section/network_custom_section_content.dart';
import 'package:miro/views/widgets/network_list/network_custom_section/network_custom_section_switch.dart';

class NetworkCustomSection extends StatefulWidget {
  const NetworkCustomSection({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _NetworkCustomSection();
}

class _NetworkCustomSection extends State<NetworkCustomSection> {
  bool sectionExpanded = false;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        children: <Widget>[
          NetworkCustomSectionSwitch(
            onChanged: (bool value) => setState(() => sectionExpanded = value),
          ),
          if (sectionExpanded) const NetworkCustomSectionContent(),
        ],
      ),
    );
  }
}
