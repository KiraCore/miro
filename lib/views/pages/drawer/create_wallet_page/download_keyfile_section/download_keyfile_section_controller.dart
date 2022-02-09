class DownloadKeyfileSectionController {
  late void Function() clear;

  void initController({
    required void Function() clear,
  }) {
    this.clear = clear;
  }
}
