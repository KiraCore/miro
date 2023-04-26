import 'package:equatable/equatable.dart';
import 'package:miro/infra/dto/shared/messages/identity_records/register/identity_info_entry.dart';

class IdentityInfoEntryModel extends Equatable {
  final String key;
  final String info;

  const IdentityInfoEntryModel({
    required this.key,
    required this.info,
  });

  factory IdentityInfoEntryModel.fromDto(IdentityInfoEntry identityInfoEntry) {
    return IdentityInfoEntryModel(
      key: identityInfoEntry.key,
      info: identityInfoEntry.info,
    );
  }

  IdentityInfoEntry toDto() {
    return IdentityInfoEntry(key: key, info: info);
  }

  @override
  List<Object?> get props => <Object>[key, info];
}
