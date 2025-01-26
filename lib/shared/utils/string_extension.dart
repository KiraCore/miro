extension StringExtension on String {
  bool isVersionLowerThan(String version) {
    List<String> versionCells = version.split('.');
    List<int> versionCellsInt = versionCells.map(int.parse).toList();
    int version1 = versionCellsInt[0] * 100000 + versionCellsInt[1] * 1000 + versionCellsInt[2];

    versionCells = split('.');
    versionCellsInt = versionCells.map(int.parse).toList();
    int version2 = versionCellsInt[0] * 100000 + versionCellsInt[1] * 1000 + versionCellsInt[2];

    return version2 < version1;
  }
}