class ApiCacheConfig {
  final Duration maxAge;
  final bool force;

  const ApiCacheConfig({
    this.force = false,
    this.maxAge = const Duration(minutes: 1),
  });
}
