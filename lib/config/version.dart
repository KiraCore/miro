class Version {
  final int major;
  final int minor;
  final int patch;
  final String? preRelease;
  final String? build;

  const Version({
    required this.major,
    required this.minor,
    this.patch = 0,
    this.preRelease,
    this.build,
  });

  static Version parse(String version) {
    // Remove leading 'v' if present
    String versionText = version.startsWith('v') ? version.substring(1) : version;

    // Extract build metadata (after '+')
    String? build;
    if (versionText.contains('+')) {
      final List<String> buildSplit = versionText.split('+');
      versionText = buildSplit[0];
      build = buildSplit[1];
    }

    // Extract pre-release (after '-')
    String? preRelease;
    if (versionText.contains('-')) {
      final List<String> preSplit = versionText.split('-');
      versionText = preSplit[0];
      preRelease = preSplit[1];
    }

    // Split by dots
    final List<String> parts = versionText.split('.');

    if (parts.isEmpty) {
      throw FormatException('Invalid version format: $versionText');
    }

    final int major = int.parse(parts[0]);
    final int minor = parts.length > 1 ? int.parse(parts[1]) : 0;
    final int patch = parts.length > 2 ? int.parse(parts[2]) : 0;

    return Version(
      major: major,
      minor: minor,
      patch: patch,
      preRelease: preRelease,
      build: build,
    );
  }

  int compareTo(Version other) {
    if (major != other.major) {
      return major.compareTo(other.major);
    }
    if (minor != other.minor) {
      return minor.compareTo(other.minor);
    }
    if (patch != other.patch) {
      return patch.compareTo(other.patch);
    }

    // Handle pre-release versions (null = release > pre-release)
    if (preRelease == null && other.preRelease != null) {
      return 1;
    }
    if (preRelease != null && other.preRelease == null) {
      return -1;
    }
    if (preRelease != null && other.preRelease != null) {
      return preRelease!.compareTo(other.preRelease!);
    }

    return 0;
  }

  int compareByMinor(Version other) {
    if (major != other.major) {
      return major.compareTo(other.major);
    }
    return minor.compareTo(other.minor);
  }

  @override
  String toString() {
    String result = '$major.$minor.$patch';
    if (preRelease != null) {
      result += '-$preRelease';
    }
    if (build != null) {
      result += '+$build';
    }
    return result;
  }

  @override
  bool operator ==(Object other) =>
      other is Version &&
      major == other.major &&
      minor == other.minor &&
      patch == other.patch &&
      preRelease == other.preRelease &&
      build == other.build;

  @override
  int get hashCode => Object.hash(major, minor, patch, preRelease, build);
}
