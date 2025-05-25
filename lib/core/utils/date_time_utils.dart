import 'package:intl/intl.dart';

import '../constants/app_constants.dart';

class DateTimeUtils {
  // Date formatters
  static final DateFormat _dayMonthYear = DateFormat('dd/MM/yyyy');
  static final DateFormat _monthDayYear = DateFormat('MM/dd/yyyy');
  static final DateFormat _yearMonthDay = DateFormat('yyyy-MM-dd');
  static final DateFormat _dayMonthYearWithTime = DateFormat('dd/MM/yyyy HH:mm');
  static final DateFormat _time24Hour = DateFormat('HH:mm');
  static final DateFormat _time12Hour = DateFormat('hh:mm a');
  static final DateFormat _dayName = DateFormat('EEEE');
  static final DateFormat _shortDayName = DateFormat('EEE');
  static final DateFormat _monthName = DateFormat('MMMM');
  static final DateFormat _shortMonthName = DateFormat('MMM');
  static final DateFormat _dayMonthName = DateFormat('dd MMMM');
  static final DateFormat _dayShortMonthName = DateFormat('dd MMM');
  static final DateFormat _dayMonthNameYear = DateFormat('dd MMMM yyyy');
  static final DateFormat _dayShortMonthNameYear = DateFormat('dd MMM yyyy');
  static final DateFormat _iso8601 = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'");
  static final DateFormat _apiFormat = DateFormat('yyyy-MM-dd HH:mm:ss');
  
  // Current date and time
  static DateTime get now => DateTime.now();
  static DateTime get today => DateTime(now.year, now.month, now.day);
  static DateTime get tomorrow => today.add(const Duration(days: 1));
  static DateTime get yesterday => today.subtract(const Duration(days: 1));
  
  // Format date to string
  static String formatDate(DateTime date, {String? format}) {
    switch (format) {
      case 'dd/MM/yyyy':
        return _dayMonthYear.format(date);
      case 'MM/dd/yyyy':
        return _monthDayYear.format(date);
      case 'yyyy-MM-dd':
        return _yearMonthDay.format(date);
      case 'dd/MM/yyyy HH:mm':
        return _dayMonthYearWithTime.format(date);
      case 'HH:mm':
        return _time24Hour.format(date);
      case 'hh:mm a':
        return _time12Hour.format(date);
      case 'EEEE':
        return _dayName.format(date);
      case 'EEE':
        return _shortDayName.format(date);
      case 'MMMM':
        return _monthName.format(date);
      case 'MMM':
        return _shortMonthName.format(date);
      case 'dd MMMM':
        return _dayMonthName.format(date);
      case 'dd MMM':
        return _dayShortMonthName.format(date);
      case 'dd MMMM yyyy':
        return _dayMonthNameYear.format(date);
      case 'dd MMM yyyy':
        return _dayShortMonthNameYear.format(date);
      case 'iso8601':
        return _iso8601.format(date.toUtc());
      case 'api':
        return _apiFormat.format(date);
      default:
        return _dayMonthYear.format(date);
    }
  }
  
  // Parse string to date
  static DateTime? parseDate(String dateString, {String? format}) {
    try {
      switch (format) {
        case 'dd/MM/yyyy':
          return _dayMonthYear.parse(dateString);
        case 'MM/dd/yyyy':
          return _monthDayYear.parse(dateString);
        case 'yyyy-MM-dd':
          return _yearMonthDay.parse(dateString);
        case 'dd/MM/yyyy HH:mm':
          return _dayMonthYearWithTime.parse(dateString);
        case 'iso8601':
          return _iso8601.parse(dateString);
        case 'api':
          return _apiFormat.parse(dateString);
        default:
          return DateTime.tryParse(dateString);
      }
    } catch (e) {
      return null;
    }
  }
  
  // Format time to string
  static String formatTime(DateTime time, {bool is24Hour = true}) {
    return is24Hour ? _time24Hour.format(time) : _time12Hour.format(time);
  }
  
  // Parse time string to DateTime (today's date with given time)
  static DateTime? parseTime(String timeString, {bool is24Hour = true}) {
    try {
      final format = is24Hour ? _time24Hour : _time12Hour;
      final time = format.parse(timeString);
      return DateTime(today.year, today.month, today.day, time.hour, time.minute);
    } catch (e) {
      return null;
    }
  }
  
  // Get relative time (e.g., "2 hours ago", "in 3 days")
  static String getRelativeTime(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);
    
    if (difference.isNegative) {
      // Future time
      final futureDifference = dateTime.difference(now);
      
      if (futureDifference.inDays > 0) {
        return 'in ${futureDifference.inDays} day${futureDifference.inDays == 1 ? '' : 's'}';
      } else if (futureDifference.inHours > 0) {
        return 'in ${futureDifference.inHours} hour${futureDifference.inHours == 1 ? '' : 's'}';
      } else if (futureDifference.inMinutes > 0) {
        return 'in ${futureDifference.inMinutes} minute${futureDifference.inMinutes == 1 ? '' : 's'}';
      } else {
        return 'in a few seconds';
      }
    } else {
      // Past time
      if (difference.inDays > 0) {
        return '${difference.inDays} day${difference.inDays == 1 ? '' : 's'} ago';
      } else if (difference.inHours > 0) {
        return '${difference.inHours} hour${difference.inHours == 1 ? '' : 's'} ago';
      } else if (difference.inMinutes > 0) {
        return '${difference.inMinutes} minute${difference.inMinutes == 1 ? '' : 's'} ago';
      } else {
        return 'just now';
      }
    }
  }
  
  // Get friendly date (e.g., "Today", "Tomorrow", "Yesterday", or formatted date)
  static String getFriendlyDate(DateTime date) {
    final today = DateTime.now();
    final dateOnly = DateTime(date.year, date.month, date.day);
    final todayOnly = DateTime(today.year, today.month, today.day);
    
    final difference = dateOnly.difference(todayOnly).inDays;
    
    switch (difference) {
      case 0:
        return 'Today';
      case 1:
        return 'Tomorrow';
      case -1:
        return 'Yesterday';
      default:
        if (difference > 1 && difference <= 7) {
          return _dayName.format(date);
        } else {
          return _dayShortMonthNameYear.format(date);
        }
    }
  }
  
  // Get friendly date with time
  static String getFriendlyDateTime(DateTime dateTime) {
    final friendlyDate = getFriendlyDate(dateTime);
    final time = formatTime(dateTime, is24Hour: false);
    
    if (friendlyDate == 'Today' || friendlyDate == 'Tomorrow' || friendlyDate == 'Yesterday') {
      return '$friendlyDate at $time';
    } else {
      return '$friendlyDate, $time';
    }
  }
  
  // Check if date is today
  static bool isToday(DateTime date) {
    final today = DateTime.now();
    return date.year == today.year && date.month == today.month && date.day == today.day;
  }
  
  // Check if date is tomorrow
  static bool isTomorrow(DateTime date) {
    final tomorrow = DateTime.now().add(const Duration(days: 1));
    return date.year == tomorrow.year && date.month == tomorrow.month && date.day == tomorrow.day;
  }
  
  // Check if date is yesterday
  static bool isYesterday(DateTime date) {
    final yesterday = DateTime.now().subtract(const Duration(days: 1));
    return date.year == yesterday.year && date.month == yesterday.month && date.day == yesterday.day;
  }
  
  // Check if date is in the past
  static bool isPast(DateTime date) {
    return date.isBefore(DateTime.now());
  }
  
  // Check if date is in the future
  static bool isFuture(DateTime date) {
    return date.isAfter(DateTime.now());
  }
  
  // Check if date is weekend
  static bool isWeekend(DateTime date) {
    return date.weekday == DateTime.saturday || date.weekday == DateTime.sunday;
  }
  
  // Check if date is weekday
  static bool isWeekday(DateTime date) {
    return !isWeekend(date);
  }
  
  // Get start of day
  static DateTime startOfDay(DateTime date) {
    return DateTime(date.year, date.month, date.day);
  }
  
  // Get end of day
  static DateTime endOfDay(DateTime date) {
    return DateTime(date.year, date.month, date.day, 23, 59, 59, 999);
  }
  
  // Get start of week (Monday)
  static DateTime startOfWeek(DateTime date) {
    final daysFromMonday = date.weekday - 1;
    return startOfDay(date.subtract(Duration(days: daysFromMonday)));
  }
  
  // Get end of week (Sunday)
  static DateTime endOfWeek(DateTime date) {
    final daysToSunday = 7 - date.weekday;
    return endOfDay(date.add(Duration(days: daysToSunday)));
  }
  
  // Get start of month
  static DateTime startOfMonth(DateTime date) {
    return DateTime(date.year, date.month, 1);
  }
  
  // Get end of month
  static DateTime endOfMonth(DateTime date) {
    return DateTime(date.year, date.month + 1, 0, 23, 59, 59, 999);
  }
  
  // Get start of year
  static DateTime startOfYear(DateTime date) {
    return DateTime(date.year, 1, 1);
  }
  
  // Get end of year
  static DateTime endOfYear(DateTime date) {
    return DateTime(date.year, 12, 31, 23, 59, 59, 999);
  }
  
  // Get days in month
  static int getDaysInMonth(int year, int month) {
    return DateTime(year, month + 1, 0).day;
  }
  
  // Get age from birth date
  static int getAge(DateTime birthDate) {
    final today = DateTime.now();
    int age = today.year - birthDate.year;
    
    if (today.month < birthDate.month || 
        (today.month == birthDate.month && today.day < birthDate.day)) {
      age--;
    }
    
    return age;
  }
  
  // Add business days (excluding weekends)
  static DateTime addBusinessDays(DateTime date, int days) {
    DateTime result = date;
    int addedDays = 0;
    
    while (addedDays < days) {
      result = result.add(const Duration(days: 1));
      if (isWeekday(result)) {
        addedDays++;
      }
    }
    
    return result;
  }
  
  // Get business days between two dates
  static int getBusinessDaysBetween(DateTime start, DateTime end) {
    if (start.isAfter(end)) {
      return 0;
    }
    
    int businessDays = 0;
    DateTime current = start;
    
    while (current.isBefore(end) || current.isAtSameMomentAs(end)) {
      if (isWeekday(current)) {
        businessDays++;
      }
      current = current.add(const Duration(days: 1));
    }
    
    return businessDays;
  }
  
  // Get time slots for a day
  static List<String> getTimeSlots({
    int startHour = 6,
    int endHour = 23,
    int intervalMinutes = 60,
    bool is24Hour = true,
  }) {
    final slots = <String>[];
    
    for (int hour = startHour; hour < endHour; hour++) {
      for (int minute = 0; minute < 60; minute += intervalMinutes) {
        final time = DateTime(2023, 1, 1, hour, minute);
        slots.add(formatTime(time, is24Hour: is24Hour));
      }
    }
    
    return slots;
  }
  
  // Get available booking slots for turf
  static List<String> getAvailableSlots({
    DateTime? date,
    List<String>? bookedSlots,
    int startHour = 6,
    int endHour = 23,
    int intervalMinutes = 60,
  }) {
    date ??= DateTime.now();
    bookedSlots ??= [];
    
    final allSlots = getTimeSlots(
      startHour: startHour,
      endHour: endHour,
      intervalMinutes: intervalMinutes,
    );
    
    // If the date is today, filter out past slots
    if (isToday(date)) {
      final now = DateTime.now();
      final currentTime = formatTime(now);
      
      return allSlots.where((slot) {
        return slot.compareTo(currentTime) > 0 && !bookedSlots!.contains(slot);
      }).toList();
    }
    
    // For future dates, just filter out booked slots
    return allSlots.where((slot) => !bookedSlots!.contains(slot)).toList();
  }
  
  // Check if time slot is available
  static bool isSlotAvailable(String slot, DateTime date, List<String> bookedSlots) {
    if (bookedSlots.contains(slot)) {
      return false;
    }
    
    if (isToday(date)) {
      final now = DateTime.now();
      final currentTime = formatTime(now);
      return slot.compareTo(currentTime) > 0;
    }
    
    return true;
  }
  
  // Get duration between two times
  static Duration getDurationBetween(String startTime, String endTime) {
    final start = parseTime(startTime);
    final end = parseTime(endTime);
    
    if (start == null || end == null) {
      return Duration.zero;
    }
    
    return end.difference(start);
  }
  
  // Format duration to human readable string
  static String formatDuration(Duration duration) {
    final hours = duration.inHours;
    final minutes = duration.inMinutes.remainder(60);
    
    if (hours > 0) {
      return '${hours}h ${minutes}m';
    } else {
      return '${minutes}m';
    }
  }
  
  // Get time zone offset
  static String getTimeZoneOffset() {
    final now = DateTime.now();
    final offset = now.timeZoneOffset;
    final hours = offset.inHours;
    final minutes = offset.inMinutes.remainder(60);
    
    final sign = offset.isNegative ? '-' : '+';
    return '$sign${hours.abs().toString().padLeft(2, '0')}:${minutes.abs().toString().padLeft(2, '0')}';
  }
  
  // Convert to UTC
  static DateTime toUtc(DateTime dateTime) {
    return dateTime.toUtc();
  }
  
  // Convert from UTC to local
  static DateTime fromUtc(DateTime utcDateTime) {
    return utcDateTime.toLocal();
  }
  
  // Get business hours for a day
  static Map<String, String> getBusinessHours(DateTime date) {
    if (isWeekend(date)) {
      return {
        'open': AppConstants.weekendOpenTime,
        'close': AppConstants.weekendCloseTime,
      };
    } else {
      return {
        'open': AppConstants.weekdayOpenTime,
        'close': AppConstants.weekdayCloseTime,
      };
    }
  }
  
  // Check if current time is within business hours
  static bool isWithinBusinessHours([DateTime? dateTime]) {
    dateTime ??= DateTime.now();
    final businessHours = getBusinessHours(dateTime);
    final openTime = parseTime(businessHours['open']!);
    final closeTime = parseTime(businessHours['close']!);
    
    if (openTime == null || closeTime == null) {
      return false;
    }
    
    final currentTime = DateTime(
      dateTime.year,
      dateTime.month,
      dateTime.day,
      dateTime.hour,
      dateTime.minute,
    );
    
    return currentTime.isAfter(openTime) && currentTime.isBefore(closeTime);
  }
  
  // Get next business day
  static DateTime getNextBusinessDay([DateTime? date]) {
    date ??= DateTime.now();
    DateTime nextDay = date.add(const Duration(days: 1));
    
    while (isWeekend(nextDay)) {
      nextDay = nextDay.add(const Duration(days: 1));
    }
    
    return nextDay;
  }
  
  // Get previous business day
  static DateTime getPreviousBusinessDay([DateTime? date]) {
    date ??= DateTime.now();
    DateTime previousDay = date.subtract(const Duration(days: 1));
    
    while (isWeekend(previousDay)) {
      previousDay = previousDay.subtract(const Duration(days: 1));
    }
    
    return previousDay;
  }
}