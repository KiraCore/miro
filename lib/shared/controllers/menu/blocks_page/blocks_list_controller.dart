import 'package:miro/blocs/widgets/kira/kira_list/abstract_list/controllers/i_list_controller.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/infra/services/api/query_blocks_service.dart';
import 'package:miro/infra/services/cache/favourites_cache_service.dart';
import 'package:miro/shared/models/blocks/block_model.dart';
import 'package:miro/shared/utils/list_utils.dart';

class BlocksListController implements IListController<BlockModel> {
  final FavouritesCacheService favouritesCacheService = FavouritesCacheService(domainName: 'blocks');
  final QueryBlocksService _queryBlocksService = globalLocator<QueryBlocksService>();

  @override
  FavouritesCacheService getFavouritesCacheService() {
    return favouritesCacheService;
  }

  @override
  Future<List<BlockModel>> getFavouritesData() async {
    return <BlockModel>[];
  }

  @override
  Future<List<BlockModel>> getPageData(int pageIndex, int offset, int limit) async {
    List<BlockModel> blockModelList = await _queryBlocksService.getBlockList();

    return ListUtils.getSafeSublist(list: blockModelList, start: offset, end: limit);
    // List<BlockModel> blocksModelList = <BlockModel>[
    //   BlockModel(
    //       blockId: const BlockId(hash: '5DA5429BE2DFABC2B808942E710C51067CB594928AEBE92B1B575616C0FD7D67'),
    //       blockSize: '909',
    //       header: Header(
    //         appHash: '936F6366251EB9890CFBE8E64CC73C8EFD2C3E2ED20C3663DCAEC01364B491FE',
    //         chainId: 'localnet-4',
    //         consensusHash: '048091BC7DDC283F77BFBF91D73C44DA58C3DF8A9CBC867405D8B7F3DAADA22F',
    //         dataHash: 'E3B0C44298FC1C149AFBF4C8996FB92427AE41E4649B934CA495991B7852B855',
    //         evidenceHash: 'E3B0C44298FC1C149AFBF4C8996FB92427AE41E4649B934CA495991B7852B855',
    //         height: '460593',
    //         proposerAddress: 'AAD2554628B4F2388756655CE26A7B33381BD9D3',
    //         time: DateTime.parse('2023-07-20T13:09:37.234572353Z'),
    //         validatorsHash: '78E7F265D3BA68B8B8522AD6A33448A2E52A1CA06F7E11A38D959EC2FB3F84C0',
    //       ),
    //       numTxs: '0'),
    //   BlockModel(
    //       blockId: const BlockId(
    //         hash: '17D483817A8CEA195CE1C6BC3B40295DB2B9D97D8C49B9F2A2E5F5E9022FC9A0',
    //       ),
    //       blockSize: '914',
    //       header: Header(
    //         appHash: '2C285D8F50AE85D164DC20EC73D0B59324C776E0635303143E735CA2BECC1705',
    //         chainId: 'localnet-4',
    //         consensusHash: '048091BC7DDC283F77BFBF91D73C44DA58C3DF8A9CBC867405D8B7F3DAADA22F',
    //         dataHash: 'E3B0C44298FC1C149AFBF4C8996FB92427AE41E4649B934CA495991B7852B855',
    //         evidenceHash: 'E3B0C44298FC1C149AFBF4C8996FB92427AE41E4649B934CA495991B7852B855',
    //         height: '460592',
    //         proposerAddress: 'CF992A9CB5366E78177DB878CE5C9670B0C4F4FB',
    //         time: DateTime.parse('2023-07-20T13:09:26.925665233Z'),
    //         validatorsHash: '78E7F265D3BA68B8B8522AD6A33448A2E52A1CA06F7E11A38D959EC2FB3F84C0',
    //       ),
    //       numTxs: '0'),
    //   BlockModel(
    //       blockId: const BlockId(
    //         hash: '7877F93BA228CA8A9C960B16FC42BFD10D3060DFD198390066486107EC4D8804',
    //       ),
    //       blockSize: '914',
    //       header: Header(
    //         appHash: 'D5433D0DE66417E23E59E2E76C24A782CE00BA27637F2DBABAFBC392F4FADB10',
    //         chainId: 'localnet-4',
    //         consensusHash: '048091BC7DDC283F77BFBF91D73C44DA58C3DF8A9CBC867405D8B7F3DAADA22F',
    //         dataHash: 'E3B0C44298FC1C149AFBF4C8996FB92427AE41E4649B934CA495991B7852B855',
    //         evidenceHash: 'E3B0C44298FC1C149AFBF4C8996FB92427AE41E4649B934CA495991B7852B855',
    //         height: '460591',
    //         proposerAddress: 'CF992A9CB5366E78177DB878CE5C9670B0C4F4FB',
    //         time: DateTime.parse('2023-07-20T13:09:16.61665962Z'),
    //         validatorsHash: '78E7F265D3BA68B8B8522AD6A33448A2E52A1CA06F7E11A38D959EC2FB3F84C0',
    //       ),
    //       numTxs: '0'),
    //   BlockModel(
    //       blockId: const BlockId(
    //         hash: 'C59DB15217584A0DB17C9F4C1B1F241D34C28E80A95ED8A5833BC5E83F3000E3',
    //       ),
    //       blockSize: '914',
    //       header: Header(
    //         appHash: '1E943C7B278C0E2D56DEF46D100F5486F0A6A31A3FD08CA8C8017EC7264F113B',
    //         chainId: 'localnet-4',
    //         consensusHash: '048091BC7DDC283F77BFBF91D73C44DA58C3DF8A9CBC867405D8B7F3DAADA22F',
    //         dataHash: 'E3B0C44298FC1C149AFBF4C8996FB92427AE41E4649B934CA495991B7852B855',
    //         evidenceHash: 'E3B0C44298FC1C149AFBF4C8996FB92427AE41E4649B934CA495991B7852B855',
    //         height: '460589',
    //         proposerAddress: 'AAD2554628B4F2388756655CE26A7B33381BD9D3',
    //         time: DateTime.parse('2023-07-20T13:08:55.992959405Z'),
    //         validatorsHash: '78E7F265D3BA68B8B8522AD6A33448A2E52A1CA06F7E11A38D959EC2FB3F84C0',
    //       ),
    //       numTxs: '0'),
    //   BlockModel(
    //       blockId: const BlockId(
    //         hash: '498F60C0C1E981774BED3F4E7532FE1CB187A917820E6F7E93696D8D75DB2980',
    //       ),
    //       blockSize: '914',
    //       header: Header(
    //         appHash: '443DC4596A481EAE732EBEF8D33D4CF66E91FAA4628511F4957C6E981E454CAF',
    //         chainId: 'localnet-4',
    //         consensusHash: '048091BC7DDC283F77BFBF91D73C44DA58C3DF8A9CBC867405D8B7F3DAADA22F',
    //         dataHash: 'E3B0C44298FC1C149AFBF4C8996FB92427AE41E4649B934CA495991B7852B855',
    //         evidenceHash: 'E3B0C44298FC1C149AFBF4C8996FB92427AE41E4649B934CA495991B7852B855',
    //         height: '460588',
    //         proposerAddress: 'CF992A9CB5366E78177DB878CE5C9670B0C4F4FB',
    //         time: DateTime.parse('2023-07-20T13:08:45.679589326Z'),
    //         validatorsHash: '78E7F265D3BA68B8B8522AD6A33448A2E52A1CA06F7E11A38D959EC2FB3F84C0',
    //       ),
    //       numTxs: '0'),
    //   BlockModel(
    //       blockId: const BlockId(
    //         hash: 'E914A3FC2FAD444FD784F68D6C05869753D9A1A935AE37110BFC99C4B452CB4C',
    //       ),
    //       blockSize: '914',
    //       header: Header(
    //         appHash: 'A94EFF2F2D07080E60BB0084BE0F939A7FC2CE41117AF097657509ACE696FCDF',
    //         chainId: 'localnet-4',
    //         consensusHash: '048091BC7DDC283F77BFBF91D73C44DA58C3DF8A9CBC867405D8B7F3DAADA22F',
    //         dataHash: 'E3B0C44298FC1C149AFBF4C8996FB92427AE41E4649B934CA495991B7852B855',
    //         evidenceHash: 'E3B0C44298FC1C149AFBF4C8996FB92427AE41E4649B934CA495991B7852B855',
    //         height: '460587',
    //         proposerAddress: 'AFC8EBD65CE1E7DD38E1E4DD514E9B03A0085E98',
    //         time: DateTime.parse('2023-07-20T13:08:35.367290455Z'),
    //         validatorsHash: '78E7F265D3BA68B8B8522AD6A33448A2E52A1CA06F7E11A38D959EC2FB3F84C0',
    //       ),
    //       numTxs: '0'),
    //   BlockModel(
    //       blockId: const BlockId(
    //         hash: '17478DE80EB00FC423DEAB02DED51394631716EEC9D1428C0CE392A71ABBC86C',
    //       ),
    //       blockSize: '914',
    //       header: Header(
    //         appHash: 'C3DD927FD7D89FE2B96C5D57D221D72ABBDBD558680AB1542D37D3C2DEFBBF3F',
    //         chainId: 'localnet-4',
    //         consensusHash: '048091BC7DDC283F77BFBF91D73C44DA58C3DF8A9CBC867405D8B7F3DAADA22F',
    //         dataHash: 'E3B0C44298FC1C149AFBF4C8996FB92427AE41E4649B934CA495991B7852B855',
    //         evidenceHash: 'E3B0C44298FC1C149AFBF4C8996FB92427AE41E4649B934CA495991B7852B855',
    //         height: '460586',
    //         proposerAddress: '463E25C36D575B4B10360776B7AE46CFBFF2E928',
    //         time: DateTime.parse('2023-07-20T13:08:25.055094432Z'),
    //         validatorsHash: '78E7F265D3BA68B8B8522AD6A33448A2E52A1CA06F7E11A38D959EC2FB3F84C0',
    //       ),
    //       numTxs: '0'),
    //   BlockModel(
    //       blockId: const BlockId(
    //         hash: 'A7BC10C1A0A6599CDF78E8E0816D2F38E899385DDF1B2DA9B499B24A2539D504',
    //       ),
    //       blockSize: '914',
    //       header: Header(
    //         appHash: '1E7B5B0C1A9BB0EE64A64D60AB4FC69380B876D5D4066BD0E27B467AAA07E5C9',
    //         chainId: 'localnet-4',
    //         consensusHash: '048091BC7DDC283F77BFBF91D73C44DA58C3DF8A9CBC867405D8B7F3DAADA22F',
    //         dataHash: 'E3B0C44298FC1C149AFBF4C8996FB92427AE41E4649B934CA495991B7852B855',
    //         evidenceHash: 'E3B0C44298FC1C149AFBF4C8996FB92427AE41E4649B934CA495991B7852B855',
    //         height: '460585',
    //         proposerAddress: 'AAD2554628B4F2388756655CE26A7B33381BD9D3',
    //         time: DateTime.parse('2023-07-20T13:08:14.740045992Z'),
    //         validatorsHash: '78E7F265D3BA68B8B8522AD6A33448A2E52A1CA06F7E11A38D959EC2FB3F84C0',
    //       ),
    //       numTxs: '0'),
    //   BlockModel(
    //       blockId: const BlockId(
    //         hash: '264C6F1DFB099342A5EB82A6C0DA0B58D3A840E3680D3085856CEC0FD62DCA3E',
    //       ),
    //       blockSize: '914',
    //       header: Header(
    //         appHash: 'E4FFCBC3400368DA958355F46EA7C99B5B2D5FC863383339379F731B834ACAC4',
    //         chainId: 'localnet-4',
    //         consensusHash: '048091BC7DDC283F77BFBF91D73C44DA58C3DF8A9CBC867405D8B7F3DAADA22F',
    //         dataHash: 'E3B0C44298FC1C149AFBF4C8996FB92427AE41E4649B934CA495991B7852B855',
    //         evidenceHash: 'E3B0C44298FC1C149AFBF4C8996FB92427AE41E4649B934CA495991B7852B855',
    //         height: '460584',
    //         proposerAddress: 'CF992A9CB5366E78177DB878CE5C9670B0C4F4FB',
    //         time: DateTime.parse('2023-07-20T13:08:04.435272419Z'),
    //         validatorsHash: '78E7F265D3BA68B8B8522AD6A33448A2E52A1CA06F7E11A38D959EC2FB3F84C0',
    //       ),
    //       numTxs: '0'),
    //   BlockModel(
    //       blockId: const BlockId(
    //         hash: '6616DED92930FB60141D73B9C58B30BFD79C0BD220AC5E66F6100FF9F5DE3167',
    //       ),
    //       blockSize: '909',
    //       header: Header(
    //         appHash: '523F7DBD65F53226A5C9384E1F7A3F53B8676381FF2BAF6F11D6E1D873A807E7',
    //         chainId: 'localnet-4',
    //         consensusHash: '048091BC7DDC283F77BFBF91D73C44DA58C3DF8A9CBC867405D8B7F3DAADA22F',
    //         dataHash: 'E3B0C44298FC1C149AFBF4C8996FB92427AE41E4649B934CA495991B7852B855',
    //         evidenceHash: 'E3B0C44298FC1C149AFBF4C8996FB92427AE41E4649B934CA495991B7852B855',
    //         height: '460583',
    //         proposerAddress: 'AFC8EBD65CE1E7DD38E1E4DD514E9B03A0085E98',
    //         time: DateTime.parse('2023-07-20T13:07:54.126126335Z'),
    //         validatorsHash: '78E7F265D3BA68B8B8522AD6A33448A2E52A1CA06F7E11A38D959EC2FB3F84C0',
    //       ),
    //       numTxs: '0'),
    //   BlockModel(
    //       blockId: const BlockId(
    //         hash: '264C6F1DFB099342A5EB82A6C0DA0B58D3A840E3680D3085856CEC0FD62DCA3E',
    //       ),
    //       blockSize: '914',
    //       header: Header(
    //         appHash: 'E4FFCBC3400368DA958355F46EA7C99B5B2D5FC863383339379F731B834ACAC4',
    //         chainId: 'localnet-4',
    //         consensusHash: '048091BC7DDC283F77BFBF91D73C44DA58C3DF8A9CBC867405D8B7F3DAADA22F',
    //         dataHash: 'E3B0C44298FC1C149AFBF4C8996FB92427AE41E4649B934CA495991B7852B855',
    //         evidenceHash: 'E3B0C44298FC1C149AFBF4C8996FB92427AE41E4649B934CA495991B7852B855',
    //         height: '460584',
    //         proposerAddress: 'CF992A9CB5366E78177DB878CE5C9670B0C4F4FB',
    //         time: DateTime.parse('2023-07-20T13:08:04.435272419Z'),
    //         validatorsHash: '78E7F265D3BA68B8B8522AD6A33448A2E52A1CA06F7E11A38D959EC2FB3F84C0',
    //       ),
    //       numTxs: '0'),
    //   BlockModel(
    //       blockId: const BlockId(
    //         hash: '43A710B25F0F09284D33186BB6920B61B1D2EF96ABF740596C3369728A6F45C1',
    //       ),
    //       blockSize: '914',
    //       header: Header(
    //         appHash: 'FC67EE475388B641B1780662507FB7A20C38C1C5B8D813D247C67042EEBA5FA7',
    //         chainId: 'localnet-4',
    //         consensusHash: '048091BC7DDC283F77BFBF91D73C44DA58C3DF8A9CBC867405D8B7F3DAADA22F',
    //         dataHash: 'E3B0C44298FC1C149AFBF4C8996FB92427AE41E4649B934CA495991B7852B855',
    //         evidenceHash: 'E3B0C44298FC1C149AFBF4C8996FB92427AE41E4649B934CA495991B7852B855',
    //         height: '460582',
    //         proposerAddress: '463E25C36D575B4B10360776B7AE46CFBFF2E928',
    //         time: DateTime.parse('2023-07-20T13:07:43.81765596Z'),
    //         validatorsHash: '78E7F265D3BA68B8B8522AD6A33448A2E52A1CA06F7E11A38D959EC2FB3F84C0',
    //       ),
    //       numTxs: '0'),
    //   BlockModel(
    //       blockId: const BlockId(
    //         hash: '662198D5A0597BEF74C78DF20DA003A07B56D9D5598BE7EBC31167C64E46BDBB',
    //       ),
    //       blockSize: '914',
    //       header: Header(
    //         appHash: 'A3679BDA59E9212EC84D497481E89D3345226BDDAC7C942BBE2A7742B6430C5C',
    //         chainId: 'localnet-4',
    //         consensusHash: '048091BC7DDC283F77BFBF91D73C44DA58C3DF8A9CBC867405D8B7F3DAADA22F',
    //         dataHash: 'E3B0C44298FC1C149AFBF4C8996FB92427AE41E4649B934CA495991B7852B855',
    //         evidenceHash: 'E3B0C44298FC1C149AFBF4C8996FB92427AE41E4649B934CA495991B7852B855',
    //         height: '460581',
    //         proposerAddress: 'AAD2554628B4F2388756655CE26A7B33381BD9D3',
    //         time: DateTime.parse('2023-07-20T13:07:33.505376513Z'),
    //         validatorsHash: '78E7F265D3BA68B8B8522AD6A33448A2E52A1CA06F7E11A38D959EC2FB3F84C0',
    //       ),
    //       numTxs: '0'),
    //   BlockModel(
    //       blockId: const BlockId(
    //         hash: 'E2BFE7F840A395421954BCFC4AAA25CE66C78B60737D0B382BC3CACA53F865AB',
    //       ),
    //       blockSize: '909',
    //       header: Header(
    //         appHash: 'D5F434370BC7784F48928CD86DF007B504536864347A87FECCC6D4856551FA90',
    //         chainId: 'localnet-4',
    //         consensusHash: '048091BC7DDC283F77BFBF91D73C44DA58C3DF8A9CBC867405D8B7F3DAADA22F',
    //         dataHash: 'E3B0C44298FC1C149AFBF4C8996FB92427AE41E4649B934CA495991B7852B855',
    //         evidenceHash: 'E3B0C44298FC1C149AFBF4C8996FB92427AE41E4649B934CA495991B7852B855',
    //         height: '460580',
    //         proposerAddress: 'CF992A9CB5366E78177DB878CE5C9670B0C4F4FB',
    //         time: DateTime.parse('2023-07-20T13:07:23.197810645Z'),
    //         validatorsHash: '78E7F265D3BA68B8B8522AD6A33448A2E52A1CA06F7E11A38D959EC2FB3F84C0',
    //       ),
    //       numTxs: '0'),
    // ];
  }
}
