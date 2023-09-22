import 'package:flutter_test/flutter_test.dart';
import 'package:miro/blocs/widgets/kira/kira_list/filters/models/filter_option.dart';
import 'package:miro/shared/controllers/menu/blocks_page/blocks_filter_options.dart';
import 'package:miro/shared/models/blocks/block_id.dart';
import 'package:miro/shared/models/blocks/block_model.dart';
import 'package:miro/shared/models/blocks/header.dart';

void main() {
  BlockModel height593BlockModel = BlockModel(
      blockId: const BlockId(hash: '5DA5429BE2DFABC2B808942E710C51067CB594928AEBE92B1B575616C0FD7D67'),
      blockSize: '909',
      header: Header(
        appHash: '936F6366251EB9890CFBE8E64CC73C8EFD2C3E2ED20C3663DCAEC01364B491FE',
        chainId: 'localnet-4',
        consensusHash: '048091BC7DDC283F77BFBF91D73C44DA58C3DF8A9CBC867405D8B7F3DAADA22F',
        dataHash: 'E3B0C44298FC1C149AFBF4C8996FB92427AE41E4649B934CA495991B7852B855',
        evidenceHash: 'E3B0C44298FC1C149AFBF4C8996FB92427AE41E4649B934CA495991B7852B855',
        height: '460593',
        proposerAddress: 'AAD2554628B4F2388756655CE26A7B33381BD9D3',
        time: DateTime.parse('2023-07-20T13:09:37.234572353Z'),
        validatorsHash: '78E7F265D3BA68B8B8522AD6A33448A2E52A1CA06F7E11A38D959EC2FB3F84C0',
      ),
      numTxs: '0');

  BlockModel height592BlockModel = BlockModel(
      blockId: const BlockId(hash: '17D483817A8CEA195CE1C6BC3B40295DB2B9D97D8C49B9F2A2E5F5E9022FC9A0'),
      blockSize: '914',
      header: Header(
        appHash: '2C285D8F50AE85D164DC20EC73D0B59324C776E0635303143E735CA2BECC1705',
        chainId: 'localnet-4',
        consensusHash: '048091BC7DDC283F77BFBF91D73C44DA58C3DF8A9CBC867405D8B7F3DAADA22F',
        dataHash: 'E3B0C44298FC1C149AFBF4C8996FB92427AE41E4649B934CA495991B7852B855',
        evidenceHash: 'E3B0C44298FC1C149AFBF4C8996FB92427AE41E4649B934CA495991B7852B855',
        height: '460592',
        proposerAddress: 'CF992A9CB5366E78177DB878CE5C9670B0C4F4FB',
        time: DateTime.parse('2023-07-20T13:09:26.925665233Z'),
        validatorsHash: '78E7F265D3BA68B8B8522AD6A33448A2E52A1CA06F7E11A38D959EC2FB3F84C0',
      ),
      numTxs: '0');

  BlockModel height591BlockModel = BlockModel(
      blockId: const BlockId(hash: '7877F93BA228CA8A9C960B16FC42BFD10D3060DFD198390066486107EC4D8804'),
      blockSize: '914',
      header: Header(
        appHash: 'D5433D0DE66417E23E59E2E76C24A782CE00BA27637F2DBABAFBC392F4FADB10',
        chainId: 'localnet-4',
        consensusHash: '048091BC7DDC283F77BFBF91D73C44DA58C3DF8A9CBC867405D8B7F3DAADA22F',
        dataHash: 'E3B0C44298FC1C149AFBF4C8996FB92427AE41E4649B934CA495991B7852B855',
        evidenceHash: 'E3B0C44298FC1C149AFBF4C8996FB92427AE41E4649B934CA495991B7852B855',
        height: '460591',
        proposerAddress: 'CF992A9CB5366E78177DB878CE5C9670B0C4F4FB',
        time: DateTime.parse('2023-07-20T13:09:16.61665962Z'),
        validatorsHash: '78E7F265D3BA68B8B8522AD6A33448A2E52A1CA06F7E11A38D959EC2FB3F84C0',
      ),
      numTxs: '0');

  BlockModel height589BlockModel = BlockModel(
      blockId: const BlockId(hash: 'C59DB15217584A0DB17C9F4C1B1F241D34C28E80A95ED8A5833BC5E83F3000E3'),
      blockSize: '914',
      header: Header(
        appHash: '1E94HeaderDto8C0E2D56DEF46D100F5486F0A6A31A3FD08CA8C8017EC7264F113B',
        chainId: 'localnet-4',
        consensusHash: '048091BC7DDC283F77BFBF91D73C44DA58C3DF8A9CBC867405D8B7F3DAADA22F',
        dataHash: 'E3B0C44298FC1C149AFBF4C8996FB92427AE41E4649B934CA495991B7852B855',
        evidenceHash: 'E3B0C44298FC1C149AFBF4C8996FB92427AE41E4649B934CA495991B7852B855',
        height: '460589',
        proposerAddress: 'AAD2554628B4F2388756655CE26A7B33381BD9D3',
        time: DateTime.parse('2023-07-20T13:08:55.992959405Z'),
        validatorsHash: '78E7F265D3BA68B8B8522AD6A33448A2E52A1CA06F7E11A38D959EC2FB3F84C0',
      ),
      numTxs: '0');

  BlockModel height588BlockModel = BlockModel(
      blockId: const BlockId(hash: '498F60C0C1E981774BED3F4E7532FE1CB187A917820E6F7E93696D8D75DB2980'),
      blockSize: '914',
      header: Header(
        appHash: '443DC4596A481EHeaderDtoBEF8D33D4CF66E91FAA4628511F4957C6E981E454CAF',
        chainId: 'localnet-4',
        consensusHash: '048091BC7DDC283F77BFBF91D73C44DA58C3DF8A9CBC867405D8B7F3DAADA22F',
        dataHash: 'E3B0C44298FC1C149AFBF4C8996FB92427AE41E4649B934CA495991B7852B855',
        evidenceHash: 'E3B0C44298FC1C149AFBF4C8996FB92427AE41E4649B934CA495991B7852B855',
        height: '460588',
        proposerAddress: 'CF992A9CB5366E78177DB878CE5C9670B0C4F4FB',
        time: DateTime.parse('2023-07-20T13:08:45.679589326Z'),
        validatorsHash: '78E7F265D3BA68B8B8522AD6A33448A2E52A1CA06F7E11A38D959EC2FB3F84C0',
      ),
      numTxs: '0');

  List<BlockModel> blockModelList = <BlockModel>[
    height593BlockModel,
    height592BlockModel,
    height591BlockModel,
    height589BlockModel,
    height588BlockModel,
  ];
  group('Tests of search method', () {
    test('Should return only block matching "593"', () {
      // Arrange
      FilterComparator<BlockModel> filterComparator = BlocksFilterOptions.search('593');

      // Act
      List<BlockModel> actualProposalModelList = blockModelList.where(filterComparator).toList();

      // Assert
      List<BlockModel> expectedProposalModelList = <BlockModel>[height593BlockModel];

      expect(actualProposalModelList, expectedProposalModelList);
    });

    test('Should return only block matching "498F60C0C1E981774BED3F4E7532FE1CB187A917820E6F7E93696D8D75DB2980"', () {
      // Arrange
      FilterComparator<BlockModel> filterComparator = BlocksFilterOptions.search('498F60C0C1E981774BED3F4E7532FE1CB187A917820E6F7E93696D8D75DB2980');

      // Act
      List<BlockModel> actualProposalModelList = blockModelList.where(filterComparator).toList();

      // Assert
      List<BlockModel> expectedProposalModelList = <BlockModel>[height588BlockModel];

      expect(actualProposalModelList, expectedProposalModelList);
    });
  });
}
