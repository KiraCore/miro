import 'package:equatable/equatable.dart';
import 'package:miro/shared/models/generic/file_model.dart';

abstract class AKiraDropzoneState extends Equatable {
  final FileModel? fileModel;

  const AKiraDropzoneState({
    required this.fileModel,
  });

  const AKiraDropzoneState.empty() : fileModel = null;
  
  bool get hasFile => fileModel != null;
  
  @override
  List<Object?> get props => <Object?>[fileModel];
}
