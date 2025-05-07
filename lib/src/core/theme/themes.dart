import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../sizes/font_sizes.dart';
import '../utils/shared_pref_provider.dart';
import 'app_colors.dart';

final ChangeNotifierProvider<ThemeNotifier> themeMode =
    ChangeNotifierProvider<ThemeNotifier>((Ref ref) {
      final ThemeNotifier t = ThemeNotifier(ref);
      t.init();
      return t;
    });

// final themeMode = StateProvider((ref) {
//   return ThemeMode.light;
// });

final Provider<ThemeData> lightTheme = Provider<ThemeData>(
  (Ref ref) => Themes.light,
);
final Provider<ThemeData> darkTheme = Provider<ThemeData>(
  (Ref ref) => Themes.dark,
);

extension CustomTheme on ThemeData {
  ThemeData get custom =>
      brightness == Brightness.dark ? Themes.dark : Themes.light;
}

class FontFamily {
  static const String poppins = 'Poppins';
}

class Themes {
  static ColorScheme get lightScheme => ColorScheme.fromSeed(
    seedColor: AppColors.primaryColor,
    surface: AppColors.backgroundColor,
    secondary: AppColors.secondaryColor,
    // primary: AppColors.primaryColor,
  );

  static ColorScheme get darkScheme => ColorScheme.fromSeed(
    seedColor: AppColors.primaryColor,
    brightness: Brightness.dark,
    surface: AppColors.darkBackgroundColor,
    secondary: AppColors.darkSecondaryColor,
    // primary: AppColors.primaryColor,
  );

  static ThemeData get base => ThemeData.light(useMaterial3: true);

  static ThemeData get light => ThemeData(
    colorScheme: lightScheme,
    useMaterial3: true,
    textTheme: GoogleFonts.poppinsTextTheme(base.textTheme)
        .copyWith(
          headlineLarge: TextStyle(fontSize: FontSizes.s32),
          headlineMedium: TextStyle(fontSize: FontSizes.s28),
          headlineSmall: TextStyle(
            fontSize: FontSizes.s24,
            fontWeight: FontWeight.w700,
          ),
          titleLarge: TextStyle(
            fontSize: FontSizes.s22,
            fontWeight: FontWeight.w600,
          ),
          titleMedium: TextStyle(
            fontSize: FontSizes.s16,
            fontWeight: FontWeight.w500,
          ),
          //TextFormFieldTextStyle
          titleSmall: TextStyle(
            fontSize: FontSizes.s14,
            fontWeight: FontWeight.w600,
          ),
          bodyLarge: TextStyle(
            fontSize: FontSizes.s16,
            fontWeight: FontWeight.w400,
          ),
          bodyMedium: TextStyle(fontSize: FontSizes.s14),
          bodySmall: TextStyle(fontSize: FontSizes.s12),
          labelLarge: TextStyle(fontSize: FontSizes.s14),
          labelMedium: TextStyle(
            fontSize: FontSizes.s12,
            fontWeight: FontWeight.w400,
          ),
          labelSmall: TextStyle(
            fontSize: FontSizes.s11,
            fontWeight: FontWeight.w400,
          ),
        )
        .apply(fontFamily: FontFamily.poppins),
    appBarTheme: AppBarTheme(
      backgroundColor: lightScheme.surface,
      elevation: 1,
      titleTextStyle: TextStyle(
        color: AppColors.textColor,
        fontSize: FontSizes.s15,
        fontWeight: FontWeight.w700,
        fontFamily: FontFamily.poppins,
      ),
      iconTheme: const IconThemeData(color: AppColors.textColor),
    ),
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      hintStyle: TextStyle(
        fontSize: FontSizes.s14,
        fontWeight: FontWeight.w400,
        fontFamily: FontFamily.poppins,
      ),
      labelStyle: TextStyle(
        fontSize: FontSizes.s14,
        fontWeight: FontWeight.w400,
        fontFamily: FontFamily.poppins,
        color: AppColors.secondaryColor,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.r),
        borderSide: const BorderSide(
          color: AppColors.borderColor,
          width: 1.5,
        ),
      ),
      // errorBorder: OutlineInputBorder(
      //   borderRadius: BorderRadius.circular(8),
      //   borderSide: const BorderSide(color: Colors.redAccent, width: 2),
      // ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.r),
        borderSide: const BorderSide(
          color: AppColors.secondaryColor,
          width: 1.5,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.r),
        borderSide: const BorderSide(
          color: AppColors.borderColor,
          width: 1.5,
        ),
      ),
    ),
    buttonTheme: const ButtonThemeData(
      textTheme: ButtonTextTheme.primary,
      shape: StadiumBorder(),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: ButtonStyle(
        minimumSize: WidgetStateProperty.all(const Size.fromHeight(48)),
        side: WidgetStateProperty.all(
          BorderSide(color: lightScheme.primary, width: 1.5),
        ),
        textStyle: WidgetStateProperty.all(
          TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: FontSizes.s14,
            color: lightScheme.primary,
            fontFamily: FontFamily.poppins,
          ),
        ),
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        minimumSize: WidgetStateProperty.all(const Size.fromHeight(48)),
        textStyle: WidgetStateProperty.all(
          TextStyle(
            fontSize: FontSizes.s14,
            fontWeight: FontWeight.bold,
            fontFamily: FontFamily.poppins,
          ),
        ),
        // foregroundColor: const WidgetStatePropertyAll(Colors.white),
        // backgroundColor: WidgetStateProperty.all(scheme.primary),
        foregroundColor: WidgetStateProperty.resolveWith<Color>((
          Set<WidgetState> states,
        ) {
          if (states.contains(WidgetState.disabled)) {
            return Colors.grey.shade400; // Text color when disabled
          }
          return Colors.white; // Text color when enabled
        }),
        backgroundColor: WidgetStateProperty.resolveWith<Color>((
          Set<WidgetState> states,
        ) {
          if (states.contains(WidgetState.disabled)) {
            return Colors.grey.shade300; // Background color when disabled
          }
          return lightScheme.primary; // Background color when enabled
        }),
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
    ),
    cardTheme: CardTheme(color: AppColors.backgroundColor.withAlpha(200)),
  );

  static ThemeData get dark => ThemeData(
    cardTheme: CardTheme(color: AppColors.backgroundColor.withAlpha(40)),
    colorScheme: darkScheme,
    useMaterial3: true,
    // brightness: Brightness.light,
    textTheme: GoogleFonts.poppinsTextTheme(base.textTheme)
        .copyWith(
          headlineLarge: TextStyle(fontSize: FontSizes.s32),
          headlineMedium: TextStyle(fontSize: FontSizes.s28),
          headlineSmall: TextStyle(
            fontSize: FontSizes.s24,
            fontWeight: FontWeight.w700,
          ),
          titleLarge: TextStyle(
            fontSize: FontSizes.s22,
            fontWeight: FontWeight.w600,
          ),
          titleMedium: TextStyle(
            fontSize: FontSizes.s16,
            fontWeight: FontWeight.w500,
          ),
          //TextFormFieldTextStyle
          titleSmall: TextStyle(
            fontSize: FontSizes.s14,
            fontWeight: FontWeight.w600,
          ),
          bodyLarge: TextStyle(
            fontSize: FontSizes.s16,
            fontWeight: FontWeight.w400,
          ),
          bodyMedium: TextStyle(fontSize: FontSizes.s14),
          bodySmall: TextStyle(fontSize: FontSizes.s12),
          labelLarge: TextStyle(fontSize: FontSizes.s14),
          labelMedium: TextStyle(
            fontSize: FontSizes.s12,
            fontWeight: FontWeight.w400,
          ),
          labelSmall: TextStyle(
            fontSize: FontSizes.s11,
            fontWeight: FontWeight.w400,
          ),
        )
        .apply(
          fontFamily: FontFamily.poppins,
          bodyColor: AppColors.darkTextColor,
        ),
    appBarTheme: AppBarTheme(
      backgroundColor: darkScheme.surface,
      elevation: 1,
      titleTextStyle: TextStyle(
        color: AppColors.darkTextColor,
        fontSize: FontSizes.s15,
        fontWeight: FontWeight.w700,
        fontFamily: FontFamily.poppins,
      ),
      iconTheme: const IconThemeData(color: AppColors.textColor),
    ),
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      hintStyle: TextStyle(
        fontSize: FontSizes.s14,
        fontWeight: FontWeight.w400,
        fontFamily: FontFamily.poppins,
        color: AppColors.darkTextColor,
      ),
      labelStyle: TextStyle(
        fontSize: FontSizes.s14,
        fontWeight: FontWeight.w400,
        fontFamily: FontFamily.poppins,
        color: AppColors.darkTextColor,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(
          color: AppColors.darkSecondaryColor,
          width: 1.5,
        ),
      ),
      // errorBorder: OutlineInputBorder(
      //   borderRadius: BorderRadius.circular(8),
      //   borderSide: const BorderSide(color: Colors.redAccent, width: 2),
      // ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(
          color: AppColors.darkSecondaryColor,
          width: 1.5,
        ),
      ),
      // enabledBorder: OutlineInputBorder(
      //   borderRadius: BorderRadius.circular(8),
      //   borderSide: const BorderSide(color: Colors.transparent, width: 2),
      // ),
    ),
    buttonTheme: const ButtonThemeData(
      textTheme: ButtonTextTheme.primary,
      shape: StadiumBorder(),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: ButtonStyle(
        minimumSize: WidgetStateProperty.all(const Size.fromHeight(48)),
        side: WidgetStateProperty.all(
          BorderSide(color: darkScheme.primary, width: 1.5),
        ),
        textStyle: WidgetStateProperty.all(
          TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: FontSizes.s14,
            color: darkScheme.primary,
            fontFamily: FontFamily.poppins,
          ),
        ),
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        minimumSize: WidgetStateProperty.all(const Size.fromHeight(48)),
        textStyle: WidgetStateProperty.all(
          TextStyle(
            fontSize: FontSizes.s14,
            fontWeight: FontWeight.bold,
            fontFamily: FontFamily.poppins,
            color: AppColors.darkTextColor,
          ),
        ),
        // foregroundColor: const WidgetStatePropertyAll(Colors.white),
        // backgroundColor: WidgetStateProperty.all(scheme.primary),
        foregroundColor: WidgetStateProperty.resolveWith<Color>((
          Set<WidgetState> states,
        ) {
          if (states.contains(WidgetState.disabled)) {
            return Colors.grey.shade400; // Text color when disabled
          }
          return Colors.white; // Text color when enabled
        }),
        backgroundColor: WidgetStateProperty.resolveWith<Color>((
          Set<WidgetState> states,
        ) {
          if (states.contains(WidgetState.disabled)) {
            return Colors.grey.shade300; // Background color when disabled
          }
          return lightScheme.primary; // Background color when enabled
        }),
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
    ),
  );
}

class ThemeNotifier extends ChangeNotifier {
  final Ref ref;

  Future<SharedPreferences> get sharedPref =>
      ref.read(sharedPrefProvider.future);

  Future<void> changeTheme() async {
    if (themeMode == ThemeMode.light) {
      themeMode = ThemeMode.dark;
    } else {
      themeMode = ThemeMode.light;
    }
    final SharedPreferences pref = await sharedPref;
    pref.setInt('theme_mode', themeMode.index);
  }

  ThemeMode _getThemeFromIndex(int index) {
    ThemeMode? mode;
    for (final ThemeMode item in ThemeMode.values) {
      if (item.index == index) {
        mode = item;
        break;
      }
    }
    return mode ?? ThemeMode.light;
  }

  Future<void> init() async {
    final SharedPreferences pref = await sharedPref;
    themeMode = _getThemeFromIndex(pref.getInt('theme_mode') ?? 1);
  }

  ThemeMode _themeMode = ThemeMode.light;

  ThemeNotifier(this.ref);

  ThemeMode get themeMode => _themeMode;

  set themeMode(ThemeMode value) {
    _themeMode = value;
    notifyListeners();
  }
}
