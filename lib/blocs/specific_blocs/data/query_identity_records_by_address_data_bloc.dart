import 'package:miro/blocs/abstract_blocs/data_bloc/data_bloc.dart';
import 'package:miro/infra/dto/api_kira/query_identity_records_by_address/response/record.dart';

class QueryIdentityRecordsByAddressDataBloc extends DataBloc<List<Record>> {
  QueryIdentityRecordsByAddressDataBloc();

  List<Record> identityRecords = List<Record>.empty(growable: true);

  Map<String, Record> get recordsMap {
    return identityRecords.fold<Map<String, Record>>(
      <String, Record>{},
      (Map<String, Record> map, Record record) => map..addAll(<String, Record>{record.key: record}),
    );
  }

  void addCustomEntry(String key) {
    identityRecords.add(NewRecord(
      key: key,
      date: DateTime.now(),
    ));
    add(NotifyDataChangedEvent());
  }

  @override
  Future<List<Record>?> fetchCacheData() async {
    return null;
  }

  @override
  Future<List<Record>> fetchRemoteData() async {
    identityRecords = <Record>[
      Record(
        id: '1',
        key: 'username',
        address: 'kira143q8vxpvuykt9pq50e6hng9s38vmy844n8k9wx',
        date: DateTime.now(),
        value: 'somnitear',
        verifiers: const <String>[
          'kira143q8vxpvuykt9pq50e6hng9s38vmy844n8k9wx',
          'kira1c47savjcnwv29hw8zjfy6468d6r5thl86jhvdr',
          'kira177lwmjyjds3cy7trers83r4pjn3dhv8zrqk9dl',
        ],
      ),
      Record(
        id: '2',
        key: 'social',
        address: 'kira143q8vxpvuykt9pq50e6hng9s38vmy844n8k9wx',
        date: DateTime.now(),
        value:
            'https://www.messenger.com/t/100006473500213,https://github.com/dpajak99,https://www.facebook.com/dpajak99/,https://www.instagram.com/somnitear/,https://www.linkedin.com/in/dominikpajak/',
      ),
      Record(
        id: '3',
        key: 'contact',
        address: 'kira143q8vxpvuykt9pq50e6hng9s38vmy844n8k9wx',
        date: DateTime.now(),
        value: '+48784099089, dominik00801@gmail.com',
      ),
      Record(
        id: '4',
        key: 'avatar',
        address: 'kira143q8vxpvuykt9pq50e6hng9s38vmy844n8k9wx',
        date: DateTime.now(),
        value: 'https://avatars.githubusercontent.com/u/67832195?v=4',
      ),
      Record(
        id: '5',
        key: 'description',
        address: 'kira143q8vxpvuykt9pq50e6hng9s38vmy844n8k9wx',
        date: DateTime.now(),
        value:
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Praesent eu augue sed quam ornare pharetra. Cras ante nisl, ultrices a aliquet sed, pharetra ac mi. Maecenas pulvinar, est et feugiat dignissim, erat ante volutpat arcu, in ultricies purus dolor a eros. Aenean sit amet lacinia purus, sed rutrum est. Donec feugiat eget sapien in pellentesque. Etiam vitae metus non nulla commodo laoreet quis ut purus. Mauris ac mi augue.',
      ),
      Record(
        id: '6',
        key: 'Kira address',
        address: 'kira143q8vxpvuykt9pq50e6hng9s38vmy844n8k9wx',
        date: DateTime.now(),
        value: 'https://kira.network/',
        verifiers: const <String>[
          'kira143q8vxpvuykt9pq50e6hng9s38vmy844n8k9wx',
        ],
      ),
    ];
    return identityRecords;
  }
}
