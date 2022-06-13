import 'package:miro/views/pages/menu/my_account_page/identity_registrar_page/identity_record_config.dart';
import 'package:miro/views/widgets/kira/identity_record_preview/identity_record_preview.dart';

class IdentityRecordsConfig {
  static List<String> defaultIdentityRecordKeys = <String>[
    'username',
    'description',
    'social',
    'avatar',
    'contact',
  ];

  static IdentityRecordConfig? getConfig(String identityKey) {
    return _kIdentityRecordConfigMap[identityKey];
  }
}

Map<String, IdentityRecordConfig> _kIdentityRecordConfigMap = <String, IdentityRecordConfig>{
  'username': IdentityRecordConfig(
    label: 'Username',
    description:
        'Identifies your name as seen on the network explorer. This key must be globally unique. The value can be used for the purpose of sending transactions',
    recordType: RecordType.shortText,
  ),
  'moniker': IdentityRecordConfig(
    label: 'Moniker',
    description:
        'Identifies validator name as seen on the leaderboard table. This key must be globally unique as defined by the UniqueIdentityKeys Network Property.',
    recordType: RecordType.shortText,
  ),
  'description': IdentityRecordConfig(
    label: 'Description',
    description: 'A longer description of validator node',
    recordType: RecordType.longText,
  ),
  'social': IdentityRecordConfig(
    label: 'Social media',
    description: 'List of any social profiles such as Twitter, Telegram, etc…',
    recordType: RecordType.urlList,
  ),
  'avatar': IdentityRecordConfig(
    label: 'Avatar',
    description: 'URL to .SVG image or gif (256kB max)',
    recordType: RecordType.image,
  ),
  'logo': IdentityRecordConfig(
    label: 'Logo',
    description: 'URL to .SVG image (256kB max) representing validator entity',
    recordType: RecordType.image,
  ),
  'contact': IdentityRecordConfig(
    label: 'Contact',
    description: 'Email address, url, or another emergency contact',
    recordType: RecordType.urlList,
  ),
  'website': IdentityRecordConfig(
    label: 'Website',
    description: 'URL to the validator website',
    recordType: RecordType.urlList,
  ),
  'validator_node_id': IdentityRecordConfig(
    label: 'Validator node ID',
    description: 'Node Id of the validator node. Required to identify the node in the network visualizer.',
    recordType: RecordType.shortText,
  ),
  'sentry_node_id': IdentityRecordConfig(
    label: 'Sentry node ID',
    description:
        'List of sentry node ids, required to identify validators public sentry nodes in the network visualizer',
    recordType: RecordType.shortText,
  ),
  'interx_pub_keys': IdentityRecordConfig(
    label: 'Sentry node ID',
    description: 'List of INTERX server public signing keys',
    recordType: RecordType.shortText,
  ),
};
