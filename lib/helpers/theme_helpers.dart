import 'package:adawat_provider_app/helpers/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class ThemeHelpers {

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
  ).copyWith(
    bottomAppBarTheme: BottomAppBarTheme(
      shadowColor: lightModeShadowGrey,
      padding: const EdgeInsets.all(15),
      elevation: 10,
      color: backgroundWhite
    ),
    shadowColor: lightModeTextGreyAndShadow,
      primaryColor: primaryYellow,
      splashFactory: NoSplash.splashFactory,
      brightness: Brightness.light,
      scaffoldBackgroundColor: backgroundWhite,
      textTheme: TextThemes.textTheme(color: primaryBlack),
      colorScheme: ColorScheme.fromSeed(
          seedColor: backgroundWhite,
          primaryContainer: backgroundWhite,
          onPrimaryFixedVariant: primaryWhite,
          primary: primaryYellow, /// Primary is used as the variant of yellow used in this theme
          secondary: lightThemeBorderGrey, /// Secondary is the second most used color. This is used as border color, description text color and shadow color
          tertiaryContainer: lightModeShimmerBaseGrey, /// Tertiary Container is used as the base color for shimmer effect
          tertiaryFixedDim: lightModeShimmerHighGrey, /// Tertiary Fixed Dim is used as the high color for shimmer effect
          secondaryContainer: lightModeShimmerBaseGrey.withOpacity(0.4), /// This color is used as the color for shimmer container. Change this color when changing tertiaryContainer with opacity set to 0.4.
        ),
      iconButtonTheme: IconButtonThemeData(style: IconButton.styleFrom(
          foregroundColor: primaryBlack, iconSize: 20)),
      iconTheme: const IconThemeData(color: primaryBlack, size: 20,),
      appBarTheme: const AppBarTheme(
          centerTitle: true,
          backgroundColor: backgroundWhite,
          surfaceTintColor: backgroundWhite,
          scrolledUnderElevation: 0.0,
          systemOverlayStyle: SystemUiOverlayStyle(
              statusBarColor: Colors.transparent,
              statusBarBrightness: Brightness.light,
              statusBarIconBrightness: Brightness.dark,
              systemNavigationBarColor: Colors.transparent,
              systemNavigationBarIconBrightness: Brightness.dark
          )
        // titleTextStyle:
      ),
      inputDecorationTheme: InputDecorationTheme(
          suffixIconColor: primaryBlack,
          contentPadding: const EdgeInsets.symmetric(
              vertical: 5, horizontal: 15),
          prefixIconColor: primaryBlack,
          filled: true,
          fillColor: Colors.transparent,
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(kContainerRadius),
              borderSide: const BorderSide(
                  color: lightThemeBorderGrey, width: 1.2)
          ),
          disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(kContainerRadius),
              borderSide: BorderSide(
                  color: lightThemeBorderGrey.withOpacity(0.5), width: 1
              )
          ),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(kContainerRadius),
              borderSide: const BorderSide(
                  color: lightThemeBorderGrey, width: 2)
          ),
          errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: errorRed, width: 1.2),
            borderRadius: BorderRadius.circular(kContainerRadius),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: errorRed, width: 2),
            borderRadius: BorderRadius.circular(kContainerRadius),
          )
      ),
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: primaryYellow,
      ),
      datePickerTheme: DatePickerThemeData(
          yearBackgroundColor: WidgetStateProperty.resolveWith((Set<WidgetState> states) {
            if(states.contains(WidgetState.focused) || states.contains(WidgetState.pressed) || states.contains(WidgetState.selected)) {
              return primaryYellow;
            }
            return Colors.transparent;
          }),
          yearForegroundColor: WidgetStateProperty.resolveWith((Set<WidgetState> states) {
            if(states.contains(WidgetState.disabled)) {
              return Colors.grey;
            }
            return primaryBlack;
          }),
          yearStyle: TextThemes.textTheme(color: primaryBlack).labelLarge,
          backgroundColor: backgroundWhite,
          dayBackgroundColor: WidgetStateProperty.resolveWith((Set<WidgetState> states) {
            if(states.contains(WidgetState.focused) || states.contains(WidgetState.pressed) || states.contains(WidgetState.selected)) {
              return primaryYellow;
            }
            return Colors.transparent;
          }),
          todayBorder: BorderSide.none,
          headerForegroundColor: primaryBlack,
          todayForegroundColor: WidgetStateProperty.resolveWith((Set<WidgetState> states) {
            if(states.isEmpty) {
              return primaryYellow;
            } else if(states.contains(WidgetState.selected)) {
              return backgroundWhite;
            }
            return backgroundWhite;
          }),
          todayBackgroundColor: WidgetStateProperty.resolveWith((Set<WidgetState> states) {
            if(states.contains(WidgetState.selected) || states.contains(WidgetState.pressed) || states.contains(WidgetState.focused)) {
              return primaryYellow;
            }
            return Colors.transparent;
          }),
          dayForegroundColor: WidgetStateProperty.resolveWith((Set<WidgetState> states) {
            if(states.contains(WidgetState.disabled)) {
              return Colors.grey;
            }
            return primaryBlack;
          }),
          confirmButtonStyle: ButtonStyle(
              textStyle: WidgetStatePropertyAll<TextStyle>(TextThemes.textTheme(color: primaryWhite).labelMedium!.copyWith(fontWeight: FontWeight.w600)),
              foregroundColor: const WidgetStatePropertyAll<Color>(primaryYellow)
          ),
          cancelButtonStyle: ButtonStyle(
              textStyle: WidgetStatePropertyAll<TextStyle>(TextThemes.textTheme(color: primaryWhite).labelMedium!.copyWith(fontWeight: FontWeight.w600)),
              foregroundColor: const WidgetStatePropertyAll<Color>(primaryYellow)
          ),
          headerHeadlineStyle: TextThemes.textTheme(color: primaryBlack).bodySmall,
          dayStyle: TextThemes.textTheme(color: primaryBlack).labelMedium,
          weekdayStyle: TextThemes.textTheme(color: primaryBlack).labelLarge?.copyWith(fontWeight: FontWeight.w600)
      ),
      timePickerTheme: TimePickerThemeData(
          backgroundColor: backgroundWhite,
          dialHandColor: primaryYellow,
          hourMinuteTextStyle: TextThemes.textTheme(color: primaryWhite).bodyLarge,
          confirmButtonStyle: ButtonStyle(
              textStyle: WidgetStatePropertyAll<TextStyle>(TextThemes.textTheme(color: primaryWhite).labelMedium!.copyWith(fontWeight: FontWeight.w600)),
              foregroundColor: const WidgetStatePropertyAll<Color>(primaryYellow)
          ),
          cancelButtonStyle: ButtonStyle(
              textStyle: WidgetStatePropertyAll<TextStyle>(TextThemes.textTheme(color: primaryWhite).labelMedium!.copyWith(fontWeight: FontWeight.w600)),
              foregroundColor: const WidgetStatePropertyAll<Color>(primaryYellow)
          ),
          dayPeriodTextStyle: TextThemes.textTheme(color: darkThemeLightGrey).bodySmall?.copyWith(
            fontWeight: FontWeight.w400
          ),
          timeSelectorSeparatorTextStyle: WidgetStatePropertyAll<TextStyle>(TextThemes.textTheme(color: primaryBlack).titleLarge!),
          dayPeriodColor: primaryYellow
      )
  );

  static ThemeData darkTheme = ThemeData(
      useMaterial3: true
  ).copyWith(
      bottomAppBarTheme: const BottomAppBarTheme(
        elevation: 0,
          padding: EdgeInsets.all(15)
      ),
    shadowColor: primaryBlack,
      textTheme: TextThemes.textTheme(color: darkThemeLightGrey),
      splashFactory: NoSplash.splashFactory,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: primaryBlack,
      iconButtonTheme: IconButtonThemeData(style: IconButton.styleFrom(
          foregroundColor: darkThemeLightGrey, iconSize: 20)),
      colorScheme: ColorScheme.fromSeed(
          seedColor: darkThemeLightGrey,
        primaryContainer: primaryGrey,
        onPrimaryFixedVariant: primaryGrey,
        primary: primaryDullYellow, /// Primary is used as the variant of yellow used in this theme
        secondary: darkThemeLightGrey, /// Secondary is the second most used color. This is used as border color, description text color and shadow color
          tertiaryContainer: lightModeShimmerBaseGrey, /// Tertiary Container is used as the base color for shimmer effect
          tertiaryFixedDim: lightModeShimmerHighGrey, /// Tertiary Fixed Dim is used as the high color for shimmer effect
        secondaryContainer: lightModeShimmerBaseGrey.withOpacity(0.4) /// This color is used as the color for shimmer container. Change this color when changing tertiaryContainer with opacity set to 0.4
      ),
      iconTheme: const IconThemeData(color: darkThemeLightGrey, size: 20,),
      appBarTheme: const AppBarTheme(
          centerTitle: true,
          backgroundColor: primaryBlack,
          surfaceTintColor: primaryBlack,
          scrolledUnderElevation: 0.0,
          systemOverlayStyle: SystemUiOverlayStyle(
              statusBarColor: Colors.transparent,
              statusBarBrightness: Brightness.dark,
              statusBarIconBrightness: Brightness.light,
              systemNavigationBarColor: Colors.transparent,
              systemNavigationBarIconBrightness: Brightness.light
          )
        // titleTextStyle:
      ),
      inputDecorationTheme: InputDecorationTheme(
          suffixIconColor: darkThemeLightGrey,
          contentPadding: const EdgeInsets.symmetric(
              vertical: 5, horizontal: 15),
          prefixIconColor: darkThemeLightGrey,
          filled: true,
          fillColor: Colors.transparent,
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(kContainerRadius),
              borderSide: const BorderSide(
                  color: darkThemeLightGrey, width: 1.2)
          ),
          disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(kContainerRadius),
              borderSide: BorderSide(
                  color: darkThemeLightGrey.withOpacity(0.5), width: 1
              )
          ),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(kContainerRadius),
              borderSide: const BorderSide(color: darkThemeLightGrey, width: 2)
          ),
          errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: errorRed, width: 1.2),
            borderRadius: BorderRadius.circular(kContainerRadius),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: errorRed, width: 2),
            borderRadius: BorderRadius.circular(kContainerRadius),
          )
      ),
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: darkThemeLightGrey,
      ),
      datePickerTheme: DatePickerThemeData(
        rangePickerHeaderForegroundColor: primaryWhite,
        yearBackgroundColor: WidgetStateProperty.resolveWith((Set<WidgetState> states) {
          if(states.contains(WidgetState.focused) || states.contains(WidgetState.pressed) || states.contains(WidgetState.selected)) {
            return primaryDullYellow;
          }
          return Colors.transparent;
        }),
        yearForegroundColor: WidgetStateProperty.resolveWith((Set<WidgetState> states) {
          if(states.contains(WidgetState.disabled)) {
            return Colors.grey;
          }
          return Colors.white;
        }),
        yearStyle: TextThemes.textTheme(color: primaryWhite).labelLarge,
          backgroundColor: primaryGrey,
          dayBackgroundColor: WidgetStateProperty.resolveWith((Set<WidgetState> states) {
            if(states.contains(WidgetState.focused) || states.contains(WidgetState.pressed) || states.contains(WidgetState.selected)) {
              return primaryDullYellow;
            }
            return Colors.transparent;
          }),
          todayBorder: BorderSide.none,
          headerForegroundColor: primaryWhite,
          todayForegroundColor: WidgetStateProperty.resolveWith((Set<WidgetState> states) {
            if(states.isEmpty) {
              return primaryDullYellow;
            } else if(states.contains(WidgetState.selected)) {
              return Colors.white;
            }
            return Colors.white;
          }),
          todayBackgroundColor: WidgetStateProperty.resolveWith((Set<WidgetState> states) {
            if(states.contains(WidgetState.selected) || states.contains(WidgetState.pressed) || states.contains(WidgetState.focused)) {
              return primaryDullYellow;
            }
            return Colors.transparent;
          }),
          dayForegroundColor: WidgetStateProperty.resolveWith((Set<WidgetState> states) {
            if(states.contains(WidgetState.disabled)) {
              return Colors.grey;
            }
            return primaryWhite;
          }),
          confirmButtonStyle: ButtonStyle(
            textStyle: WidgetStatePropertyAll<TextStyle>(TextThemes.textTheme(color: primaryWhite).labelMedium!.copyWith(fontWeight: FontWeight.w600)),
            foregroundColor: const WidgetStatePropertyAll<Color>(Colors.white)
          ),
          cancelButtonStyle: ButtonStyle(
              textStyle: WidgetStatePropertyAll<TextStyle>(TextThemes.textTheme(color: primaryWhite).labelMedium!.copyWith(fontWeight: FontWeight.w600)),
              foregroundColor: const WidgetStatePropertyAll<Color>(primaryWhite)
          ),
          headerHeadlineStyle: TextThemes.textTheme(color: primaryWhite).bodySmall,
          dayStyle: TextThemes.textTheme(color: primaryWhite).labelMedium,
          weekdayStyle: TextThemes.textTheme(color: primaryWhite).labelLarge?.copyWith(fontWeight: FontWeight.w600)
      ),
    timePickerTheme: TimePickerThemeData(
      backgroundColor: primaryGrey,
      dialTextStyle: TextThemes.textTheme(color: primaryWhite).bodySmall?.copyWith(
          fontWeight: FontWeight.w400
      ),
      dayPeriodTextStyle: TextThemes.textTheme(color: primaryWhite).bodySmall?.copyWith(
        fontWeight: FontWeight.w400
      ),
      dialHandColor: primaryDullYellow,
      hourMinuteTextStyle: TextThemes.textTheme(color: primaryWhite).bodyLarge,
      confirmButtonStyle: ButtonStyle(
          textStyle: WidgetStatePropertyAll<TextStyle>(TextThemes.textTheme(color: primaryWhite).labelMedium!.copyWith(fontWeight: FontWeight.w600)),
          foregroundColor: const WidgetStatePropertyAll<Color>(Colors.white)
      ),
      cancelButtonStyle: ButtonStyle(
          textStyle: WidgetStatePropertyAll<TextStyle>(TextThemes.textTheme(color: primaryWhite).labelMedium!.copyWith(fontWeight: FontWeight.w600)),
          foregroundColor: const WidgetStatePropertyAll<Color>(primaryWhite)
      ),
      timeSelectorSeparatorTextStyle: WidgetStatePropertyAll<TextStyle>(TextThemes.textTheme(color: primaryWhite).titleLarge!),
      dayPeriodColor: primaryDullYellow
    )
  );
}

class TextThemes {

  static TextTheme textTheme({required Color color}) => TextTheme(
    titleLarge: TextStyle(
      fontSize: 34,
      color: color,
      fontWeight: FontWeight.bold
    ),
    titleMedium: TextStyle(
        fontSize: 32,
        color: color,
        fontWeight: FontWeight.bold
    ),
    titleSmall: TextStyle(
        fontSize: 30,
        color: color,
        fontWeight: FontWeight.bold
    ),
    bodyLarge: TextStyle(
        fontSize: 24,
        color: color,
        fontWeight: FontWeight.w600
    ),
    bodyMedium: TextStyle(
        fontSize: 22,
        color: color,
        fontWeight: FontWeight.w600
    ),
    bodySmall: TextStyle(
        fontSize: 20,
        color: color,
        fontWeight: FontWeight.w600
    ),
    labelLarge: TextStyle(
        fontSize: 16,
        color: color,
        fontWeight: FontWeight.w400
    ),
    labelMedium: TextStyle(
        fontSize: 14,
        color: color,
        fontWeight: FontWeight.w400
    ),
    labelSmall: TextStyle(
        fontSize: 12,
        color: color,
        fontWeight: FontWeight.w400
    ),
  ).apply(
    fontFamily: GoogleFonts.ubuntu().fontFamily
  );
}