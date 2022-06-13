class EditIdentityRecordController {
  late String? Function() save;

  void setUpController({required String? Function() save}) {
    this.save = save;
  }
}
