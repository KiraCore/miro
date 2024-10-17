import 'package:flutter/material.dart';
import 'package:miro/blocs/widgets/keyfile_dropzone/keyfile_dropzone_state.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/generated/l10n.dart';
import 'package:miro/shared/models/keyfile/encrypted/a_encrypted_keyfile_model.dart';
import 'package:miro/shared/models/keyfile/encrypted/cosmos_encrypted_keyfile_model.dart';

class KeyfileDropzonePreview extends StatelessWidget {
  final KeyfileDropzoneState keyfileDropzoneState;
  final String? errorMessage;

  const KeyfileDropzonePreview({
    required this.keyfileDropzoneState,
    required this.errorMessage,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    AEncryptedKeyfileModel? encryptedKeyfileModel;

    encryptedKeyfileModel = keyfileDropzoneState.encryptedKeyfileModel;

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
                keyfileDropzoneState.fileModel?.name ?? '---',
                overflow: TextOverflow.ellipsis,
                style: textTheme.bodyMedium!.copyWith(
                  color: DesignColors.white1,
                ),
              ),
              if (encryptedKeyfileModel is CosmosEncryptedKeyfileModel) ...<Widget>[
                const SizedBox(height: 5),
                Text(
                  S.of(context).keyfileVersion(encryptedKeyfileModel.version),
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
                  keyfileDropzoneState.fileModel?.sizeString ?? '---',
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
