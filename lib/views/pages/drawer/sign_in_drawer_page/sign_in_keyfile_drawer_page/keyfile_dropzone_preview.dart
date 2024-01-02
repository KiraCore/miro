import 'package:flutter/material.dart';
import 'package:miro/blocs/widgets/kira/kira_dropzone/a_kira_dropzone_state.dart';
import 'package:miro/blocs/widgets/kira/kira_dropzone/impl/keyfile_dropzone/keyfile_dropzone_state.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/generated/l10n.dart';

class KeyfileDropzonePreview extends StatelessWidget {
  final AKiraDropzoneState kiraDropzoneState;
  final String? errorMessage;

  const KeyfileDropzonePreview({
    required this.kiraDropzoneState,
    required this.errorMessage,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        const Icon(
          Icons.insert_drive_file,
          color: DesignColors.white1,
          size: 50,
        ),
        const SizedBox(width: 8),
        SizedBox(
          width: 200,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                kiraDropzoneState.fileModel?.name ?? '---',
                overflow: TextOverflow.ellipsis,
                style: textTheme.bodyMedium!.copyWith(
                  color: DesignColors.white1,
                ),
              ),
              if (kiraDropzoneState is KeyfileDropzoneState && (kiraDropzoneState as KeyfileDropzoneState).encryptedKeyfileModel != null) ...<Widget>[
                const SizedBox(height: 5),
                Text(
                  S.of(context).keyfileVersion((kiraDropzoneState as KeyfileDropzoneState).encryptedKeyfileModel!.version),
                  style: textTheme.bodySmall!.copyWith(
                    color: DesignColors.accent,
                  ),
                ),
              ],
              const SizedBox(height: 3),
              if (errorMessage != null)
                Text(
                  errorMessage!,
                  overflow: TextOverflow.ellipsis,
                  style: textTheme.bodySmall!.copyWith(
                    color: DesignColors.redStatus1,
                  ),
                )
              else
                Text(
                  kiraDropzoneState.fileModel?.sizeString ?? '---',
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: textTheme.bodySmall!.copyWith(
                    color: DesignColors.white2,
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}
