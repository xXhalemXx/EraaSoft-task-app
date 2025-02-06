import 'package:task_app/src/core/constants/app_strings.dart';

class DateTimeManger {
  /// Function to check the date of task and return delivery time
  /// today, tomorrow, in_30_days, in_1_year
  /// if the date is in the future return outDated
  static String dateComparison(DateTime inputDate) {
    final DateTime currentDate = DateTime.now();
    final Duration difference = inputDate.difference(currentDate);

    if (difference.inDays == 0) {
      return AppStrings.today;
    } else if (difference.inDays == 1) {
      return AppStrings.tomorrow;
    } else if (difference.inDays > 1 && difference.inDays <= 30) {
      return '${AppStrings.in_} ${difference.inDays} ${AppStrings.days}';
    } else if (difference.inDays > 30 && difference.inDays <= 360) {
      final int months = (difference.inDays / 30).ceil();
      return '${AppStrings.in_} $months ${months > 1 ? AppStrings.months : AppStrings.month}';
    } else if (difference.inDays > 360) {
      final int years = (difference.inDays / 365).ceil();
      return '${AppStrings.in_} $years ${years > 1 ? AppStrings.years : AppStrings.year}';
    } else {
      return AppStrings.outDated;
    }
  }

  static String formatTime(DateTime dateTime) {
    // Format the current time in 12-hour format with AM/PM
    String formattedTime = formatTo12Hour(dateTime);

    // Add one hour to the current time
    DateTime oneHourLater = dateTime.add(const Duration(hours: 1));
    String formattedTimePlusOne = formatTo12Hour(oneHourLater);

    return "$formattedTime - $formattedTimePlusOne";
  }

  static String formatTo12Hour(DateTime dateTime) {
    int hour = dateTime.hour;
    String period = hour >= 12 ? 'PM' : 'AM';
    hour = hour % 12;
    if (hour == 0) hour = 12; // Handle midnight and noon
    String minute = dateTime.minute.toString().padLeft(2, '0');

    return "$hour:$minute $period";
  }
}
