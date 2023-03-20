import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:miro/blocs/generic/app_config/app_config_cubit.dart';
import 'package:miro/config/app_config.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/generated/l10n.dart';
import 'package:miro/views/widgets/kira/kira_list/components/language_dropdown/language_list_item.dart';

class LanguageList extends StatelessWidget {
  final AppConfigCubit appConfigCubit = globalLocator<AppConfigCubit>();
  final AppConfig appConfig = globalLocator<AppConfig>();
  final List<Locale> locales = S.delegate.supportedLocales;
  final double height;
  final VoidCallback? onTap;

  LanguageList({
    this.height = 40,
    this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        SizedBox(
          height: locales.length * height,
          child: ListView.builder(
            itemCount: locales.length,
            itemBuilder: (BuildContext context, int index) {
              Locale locale = locales[index];

              return LanguageListItem(
                onTap: () => _updateLang(locale),
                title: Text(
                  Intl.message(locale.languageCode, name: 'language', locale: locale.languageCode),
                  style: textTheme.bodyMedium!.copyWith(
                    color: DesignColors.white2,
                  ),
                ),
                height: height,
              );
            },
          ),
        ),
      ],
    );
  }

  void _updateLang(Locale locale) {
    appConfigCubit.updateLang(locale.languageCode);
    onTap?.call();
  }
}
