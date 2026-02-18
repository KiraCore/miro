import 'package:flutter_test/flutter_test.dart';
import 'package:miro/infra/dto/api/query_blocks/request/query_blocks_req.dart';

void main() {
  group('Tests of QueryBlocksReq.toJson()', () {
    test('Should serialize all fields when hasTxs is true', () {
      // Arrange
      QueryBlocksReq queryBlocksReq = QueryBlocksReq(
        limit: 10,
        offset: 0,
        dateStart: DateTime.parse('2023-01-01T00:00:00.000Z'),
        dateEnd: DateTime.parse('2023-12-31T23:59:59.000Z'),
        hasTxs: true,
      );

      // Act
      Map<String, dynamic> actualJson = queryBlocksReq.toJson();

      // Assert
      expect(actualJson['has_txs'], 1);
      expect(actualJson['limit'], 10);
      expect(actualJson['offset'], 0);
      expect(actualJson['sort'], 'desc');
      expect(actualJson['start_date'], '2023-01-01T00:00:00.000Z');
      expect(actualJson['end_date'], '2023-12-31T23:59:59.000Z');
    });

    test('Should serialize has_txs as 0 when hasTxs is false', () {
      // Arrange
      QueryBlocksReq queryBlocksReq = const QueryBlocksReq(
        limit: 10,
        offset: 0,
        hasTxs: false,
      );

      // Act
      Map<String, dynamic> actualJson = queryBlocksReq.toJson();

      // Assert
      expect(actualJson['has_txs'], 0);
    });

    test('Should serialize has_txs as null when hasTxs is null', () {
      // Arrange
      QueryBlocksReq queryBlocksReq = const QueryBlocksReq(
        limit: 10,
        offset: 0,
      );

      // Act
      Map<String, dynamic> actualJson = queryBlocksReq.toJson();

      // Assert
      expect(actualJson['has_txs'], isNull);
    });

    test('Should serialize only default fields when no optional params provided', () {
      // Arrange
      QueryBlocksReq queryBlocksReq = const QueryBlocksReq();

      // Act
      Map<String, dynamic> actualJson = queryBlocksReq.toJson();

      // Assert
      expect(actualJson['has_txs'], isNull);
      expect(actualJson['limit'], isNull);
      expect(actualJson['offset'], isNull);
      expect(actualJson['page'], isNull);
      expect(actualJson['page_size'], isNull);
      expect(actualJson['start_date'], isNull);
      expect(actualJson['end_date'], isNull);
      expect(actualJson['sort'], 'desc');
    });
  });

  group('Tests of QueryBlocksReq equality', () {
    test('Should be equal when all fields match', () {
      // Arrange
      QueryBlocksReq req1 = const QueryBlocksReq(limit: 10, offset: 0, hasTxs: true);
      QueryBlocksReq req2 = const QueryBlocksReq(limit: 10, offset: 0, hasTxs: true);

      // Assert
      expect(req1, req2);
    });

    test('Should not be equal when hasTxs differs', () {
      // Arrange
      QueryBlocksReq req1 = const QueryBlocksReq(limit: 10, offset: 0, hasTxs: true);
      QueryBlocksReq req2 = const QueryBlocksReq(limit: 10, offset: 0, hasTxs: null);

      // Assert
      expect(req1, isNot(req2));
    });

    test('Should not be equal when hasTxs is true vs false', () {
      // Arrange
      QueryBlocksReq req1 = const QueryBlocksReq(limit: 10, offset: 0, hasTxs: true);
      QueryBlocksReq req2 = const QueryBlocksReq(limit: 10, offset: 0, hasTxs: false);

      // Assert
      expect(req1, isNot(req2));
    });
  });
}
