import 'package:miro/shared/models/blocks/block_model.dart';

class Blocks {
  final List<BlockModel> blockModels;

  Blocks({required this.blockModels});

  factory Blocks.fromJson(Map<String, dynamic> json) => Blocks(
        blockModels: (json['block_metas'] as List<dynamic>)
            .map((dynamic e) => BlockModel.fromJson(
                  e as Map<String, dynamic>,
                ))
            .toList(),
      );
}
