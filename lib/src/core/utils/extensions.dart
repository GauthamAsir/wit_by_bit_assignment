import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../sizes/font_sizes.dart';

extension UiThemeExtension on BuildContext {
  ThemeData get theme => Theme.of(this);

  TextTheme get style => theme.textTheme;

  //Display
  TextStyle get dl => style.displayLarge!;

  TextStyle get dm => style.displayMedium!;

  TextStyle get ds => style.displaySmall!;

  //Headline
  TextStyle get hl => style.headlineLarge!;

  TextStyle get hm => style.headlineMedium!;

  TextStyle get hs => style.headlineSmall!;

  //Title
  TextStyle get tl => style.titleLarge!;

  TextStyle get tm => style.titleMedium!;

  TextStyle get tm2 => style.titleMedium!.copyWith(fontSize: FontSizes.s18);

  TextStyle get ts => style.titleSmall!;

  //Body
  TextStyle get bl => style.bodyLarge!;

  TextStyle get bm => style.bodyMedium!;

  TextStyle get bs => style.bodySmall!;

  //Label
  TextStyle get ll => style.labelLarge!;

  TextStyle get lm => style.labelMedium!;

  TextStyle get ls => style.labelSmall!;

  ColorScheme get cs => theme.colorScheme;
}

extension TimeOfDayFormatting on TimeOfDay {
  String toFormattedString() {
    final int hours = hourOfPeriod == 0 ? 12 : hourOfPeriod;
    final String period = this.period == DayPeriod.am ? 'AM' : 'PM';
    final String minutes = minute.toString().padLeft(2, '0');
    return '${hours.toString().padLeft(2, '0')}:$minutes$period';
  }
}

extension CurrencyFormat on String {
  String toIndianCurrency({int? decimalDigits}) {
    final double? amount = double.tryParse(this);

    if (amount == null) {
      return this;
    }

    return NumberFormat.currency(
      locale: 'en_IN',
      symbol: '₹ ',
      decimalDigits: decimalDigits ?? 2,
    ).format(amount);
  }
}

extension DateFormatting on DateTime {
  String toShortDate() {
    // Define the date format
    final DateFormat dateFormat = DateFormat('MMM dd');

    // Format the DateTime object
    return dateFormat.format(this);
  }

  String toFormattedDateTime() {
    // Define the date format
    final DateFormat dateFormat = DateFormat('dd MMM yyyy, hh:mm a');

    // Format the DateTime object
    return dateFormat.format(this);
  }

  String toFormattedDayAndDate() {
    final DateFormat formatter = DateFormat('EEEE, MMMM d');
    return formatter.format(this);
  }

  String toFormattedTime() {
    // Define the time format
    final DateFormat timeFormat = DateFormat('hh:mm a');

    // Format the DateTime object
    return timeFormat.format(this);
  }

  String formatTimeAgo() {
    final DateTime now = DateTime.now();
    final Duration difference = now.difference(this);

    if (difference.inMinutes < 1) {
      return 'Just now';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes} min ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours}h';
    } else if (difference.inDays < 7) {
      return '${difference.inDays} day${difference.inDays > 1 ? 's' : ''} ago';
    } else if (difference.inDays < 30) {
      return '${(difference.inDays / 7).floor()} week${(difference.inDays / 7).floor() > 1 ? 's' : ''} ago';
    } else if (difference.inDays < 365) {
      return '${(difference.inDays / 30).floor()} month${(difference.inDays / 30).floor() > 1 ? 's' : ''} ago';
    } else {
      return '${(difference.inDays / 365).floor()} year${(difference.inDays / 365).floor() > 1 ? 's' : ''} ago';
    }
  }
}

extension ReadableStringFormat on String {
  String toTitleCase() {
    if (isEmpty) {
      return this;
    }
    return split(' ')
        .map(
          (word) =>
              word.isNotEmpty ? word[0].toUpperCase() + word.substring(1) : '',
        )
        .join(' ');
  }
}
