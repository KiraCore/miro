void testPrint(String message) {
  // ignore: avoid_print
  print('\x1B[34m$message\x1B[0m');
}

void testPrintError(String message) {
  // ignore: avoid_print
  print('\x1B[31m$message\x1B[0m');
}