import 'package:flutter/material.dart';
import 'package:miro/generated/l10n.dart';

extension DateTimeExtension on DateTime {
  String toShortAge(BuildContext context) {
    DateTime now = DateTime.now();
    Duration difference = now.difference(this);

    if (difference.inDays > 0) {
      return difference.inDays == 1 ? S.of(context).ageShortDay : S.of(context).ageShortDays(difference.inDays);
    } else if (difference.inHours > 0) {
      return difference.inHours == 1 ? S.of(context).ageShortHour : S.of(context).ageShortHours(difference.inHours);
    } else if (difference.inMinutes > 0) {
      return difference.inMinutes == 1
          ? S.of(context).ageShortMinute
          : S.of(context).ageShortMinutes(difference.inMinutes);
    } else {
      return difference.inSeconds == 1
          ? S.of(context).ageShortSecond
          : S.of(context).ageShortSeconds(difference.inSeconds);
    }
  }

  String toAgeAgo(BuildContext context) {
    DateTime now = DateTime.now();
    Duration difference = now.difference(this);

    if (difference.inDays > 0) {
      return difference.inDays == 1 ? S.of(context).ageShortDay : S.of(context).ageDaysAgo(difference.inDays);
    } else if (difference.inHours > 0) {
      return difference.inHours == 1 ? S.of(context).ageShortHour : S.of(context).ageHoursAgo(difference.inHours);
    } else if (difference.inMinutes > 0) {
      return difference.inMinutes == 1
          ? S.of(context).ageShortMinute
          : S.of(context).ageMinutesAgo(difference.inMinutes);
    } else {
      return difference.inSeconds == 1
          ? S.of(context).ageShortSecond
          : S.of(context).ageSecondsAgo(difference.inSeconds);
    }
  }
}
