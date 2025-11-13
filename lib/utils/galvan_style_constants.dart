import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

abstract class GalvanColors {
  static const Color compilationBadgeGreenA = Color(0xFF22B9A6);

  static const Color compilationBadgeGreenB = Color(0xFF29C7B0);

  static const Color compilationBadgeRed = Color(0xFFF74070);

  static const Color compilationBadgePurpleA = Color(0xFF8888FA);

  static const Color compilationBadgePurpleB = Color(0xFF4A4AE2);

  ///#008384
  static const Color onBoardingGradientStart = Color(0xFF008384);

  ///#88B9B9
  static const Color onBoardingGradientEnd = Color(0xFF88B9B9);

  /// #001A2D
  static const Color mainGalvan = Color(0xFF001A2D);

  /// #002641
  static const Color lightPublicProfileGradient = Color(0xFF005593);

  /// #001A2D
  static const Color darkPublicProfileGradient = Color(0xFF001A2D);

  // #013559
  static const Color mainGalvanGradient = Color(0xFF013559);

  /// #002641
  static const Color darkGalvan = Color(0xFF002641);

  /// #809FB5

  static const Color lightGalvanGradient = Color(0xFF809FB5);

  static const Color galvanBlueAccent = darkGalvan;

  // #002E4E
  static const Color midGalvan = Color(0xFF002E4E);

  /// #003F6C
  static const Color lightGalvan = Color(0xFF003F6C);

  // #007DD8
  static const Color lightestGalvan = Color(0xFF007DD8);

  static const Color darkBlue = Color(0xFF001B4E);

  /// #119FA0
  static const Color mainTurqz = Color(0xFF119FA0);

  static const Color canaryResultMindCheck = Color(0xFF4F8DFF);

  /// #0adacd
  static const Color lightTurqz = Color(0xFF0adacd);

  /// #6666F0
  static const Color mainPurple = Color(0xff6666f0);

  /// #9e9eff
  static const Color lightPurple = Color(0xff9e9eff);

  /// #eb0047
  static const Color mainRed = Color(0xffeb0047);

  /// #ff6b8b
  static const Color lightRed = Color(0xffff6b8b);

  // #804966
  static const Color purpleRed = Color(0xFF804966);

  /// #c9e22f
  static const Color mainGreen = Color(0xffc9e22f);

  /// #729400
  static const Color darkGreen = Color(0xff729400);

  static const Color leaderboardGray = Color(0xffB1B1B1);

  static const Color leaderboardOrange = Color(0xffFFA34E);

  static const Color leaderboardYellow = Color(0xffFFC046);

  /// #cfd1d4
  static const Color mildGray = Color(0xffcfd1d4);

  /// #a8a8a8
  static const Color mediumGray = Color(0xffa8a8a8);

  /// #70747e
  static const Color spicyGray = Color(0xff70747e);
  static const Color disabledGray = Color(0xff9A9A9A);

  /// #ffffff
  static const Color white = Color(0xffffffff);

  static const Color black = Color(0xff000000);
  static const Color sharedGoal = Color(0xFF2264b5);

  //PERCENT WIDGET
  static const percentBackground = Color(0xFF2E5190);
  static const percentWeekColor = lightRed;
  static const percentDailyColor = mainRed;

  //GET GALVANIZED
  static const galvanPlusPrimary = lightTurqz;
  static const Color transparent = Colors.transparent;

  //WELLNESS CHECK IN INDICATORS
  static const Color energyStart = Color(0xffFFED48);
  static const Color energyEnd = Color(0xff24B121);
  static const Color energyNowWhatFill = Color(0xffF1FFAF);
  static const Color energyNowWhat = Color(0xffA1EB3A);

  static const Color moodStart = Color(0xff34A9FE);
  static const Color moodMiddle = Color(0xff9F68FF);
  static const Color moodEnd = Color(0xff9610FF);
  static const Color moodNowWhatFill = Color(0xffCBCBFF);
  static const Color moodNowWhat = Color(0xff7C7CF6);

  static const Color stressStart = Color(0xffFFC961);
  static const Color stressEnd = Color(0xffDA2828);
  static const Color stressNowWhatFill = Color(0xffFFBD8F);
  static const Color stressNowWhat = Color(0xffFF8D4F);

  static const Color challengeLeaderboardStart = Color(0x1AFFFFFF);
  static const Color challengeLeaderboardEnd = Color(0x33007DD8);

  static const Color activeChallengeColor = Color(0xFF027071);
  static const Color activeChallengeColorDark = Color(0xFF2C6668);
}

abstract class GalvanSpacers {
  //DEFAULT SPACERS
  static SizedBox minVerticalSpace = SizedBox(height: 1.5.h);
  static SizedBox verticalSpace = SizedBox(height: 3.h);
  static SizedBox maxVerticalSpace = SizedBox(height: 5.h);

  static SizedBox minHorizontalSpace = SizedBox(width: 1.5.w);
  static SizedBox horizontalSpace = SizedBox(width: 3.w);
  static SizedBox maxHorizontalSpace = SizedBox(width: 5.w);

  static SizedBox height2 = SizedBox(height: 2);
  static SizedBox height10 = SizedBox(height: 10);
  static SizedBox height15 = SizedBox(height: 15);
  static SizedBox height20 = SizedBox(height: 20);
  static SizedBox height25 = SizedBox(height: 25);
  static SizedBox height30 = SizedBox(height: 30);
  static SizedBox height35 = SizedBox(height: 35);
  static SizedBox height45 = SizedBox(height: 45);
  static SizedBox height65 = SizedBox(height: 65);

  static const dashboardVerticalSeparator = SizedBox(height: 10);
}

abstract class GalvanValues {
  //DEFAULTS
  //!Should start using this ones
  static const double defaultVerticalTextSpace = 10;
  static double defaultOnBoardingHorizontalPaddgingPages = 10.25.w;
  static double defaultHorizontalPaddgingPages = 5.w;
  static double defaultVerticalSpace = 2.36.w;
  static const double defaultDialogCornerRadius = 15;

  static const double cardBorderRadius = 13;
  static const double checkBoxBorderRadius = 4;
  static const double elevatedButtonPadding = 15;
  static const double defaultBorderRadius = 8;
  static const double defaultBorderWidth = 1;
  static double defaultAppBarTitlePadding = 1.5.h;
  static double defaultButtonBottomPadding = 3.h;

  static double defaultCardVerticalPadding = 3.h;
  static double defaultCardHorizontalPadding = 3.w;

  //CANARY BAR
  static const double thickCanaryBar = 16;
  static const double normalCanaryBar = 16;

  //CANARY
  static double canaryPromptSuggestionWidht = 61.5.w;

  //LOGIN
  static final loadingGalvanPadding = EdgeInsets.symmetric(horizontal: 75);

  //Animation
  static const Duration defaultAnimationDuration = Duration(
    milliseconds: 500,
  );

  static const Duration notificationSlideInDuration = Duration(
    milliseconds: 300,
  );

  static const Duration notificationFadeOutDuration = Duration(
    seconds: 1,
  );

  static const Duration notificationFadeOutDelay = Duration(
    seconds: 3,
  );

  static const Curve defaultAnimationCurve = Curves.easeIn;

  //TEXT
  static const String appFontName = GalvanFonts.gilroy;
  static const String customIconFont = 'Icomoon';
  static double displayLargeSize = 30.sp;
  static double displayMediumSize = 25.sp;
  static double displaySmallSize = 22.sp;
  static double headlineLargeSize = 24.sp;
  static double headlineMediumSize = 22.sp;
  static double headlineSmallSize = 20.sp;
  static double titleLargeSize = 18.sp;
  static double titleMediumSize = 16.sp;
  static double appBarTitle = 18.sp;
  static double labelSmallSize = 13.sp;
  static double bodyLargeSize = 16.sp;
  static double bodyMediumSize = 15.sp;
  static double bodySmallSize = 13.sp;

  //GREETING SCREEN
  static const double defaultBottomMargin = 50;

  static double htmlFontSize = 16.sp;
  static double htmlListItemVerticalMargin = 0.5.h;

  //INPUT
  static const double inputVerticalPadding = 15;
  static const double inputHorizontalPadding = 20;

  //ANON SCAFFOLD
  static const double anonScaffoldHorizontalPadding = 50;
  static const double anonScaffoldVerticalPadding = 10;

  static const double verticalSpace = 20;

  //LINK DEVICES
  static const double linkDevicesIntegrationsListPadding = 30;

  //GET GALVANIZED
  static double getGalvanizedRestorePadding = 5.w;
  static double getGalvanizedFeatVerticalMargin = 1.h;
  static double getGalvanizedMembershipVerticalPadding = 1.5.h;
  static double getGalvanizedMembershipHorizontalPadding = 3.w;

  static const double getGalvanizedTrialBadgeHeight = 20;
  static const double getGalvanizedTrialBadgeWidth = 100;
  static const double getGalvanizedTrialBadgeXAlign = 0.8;
  static const double getGalvanizedTrialBadgeYAlign = 0.0;
  static const double getGalvanizedTrialBadgeBorderRadius = 5;
  static const double getGalvanizedCardVerticalPadding = 10;

  static double galvanPlusHeaderImageHeight = 5.h;

  //HOME
  static double homeBottomNavBarIconSize = 6.w;

  //WELLNESS
  static double wellnessCardsHorizontalPadding = 4.w;
  static double wellnessCardsVerticalPadding = 4.w;
  static double wellnessBannerReminder = 5.h;
  static double wellnessBannerPadding = 0.5.h;

  //HOW TO SYNC
  static double howToSyncImageHeight = 13.h;
  static double howToSyncImageVerticalPadding = 2.h;

  //DOT INDICATOR
  static const double indicatorDotInactive = 8.0;
  static const double indicatorDotActive = 28.0;
  static const double borderRadius = 8.0;

  //GPillButton
  static const double gPillButtonBorderRadius = 20.0;
  static const FontWeight gPillButtonFontWeight = FontWeight.w600;
  static const double gPillButtonVerticalPadding = 5;
  static const double gPillButtonHorizontalPadding = 10;

  //VERTICAL SHADER
  static const double shaderDelta = 20;

  //REWARDS
  static double rewardInfoButtonSize = 7.5.w;
  static double iconsSize = 21.sp;
  static double izeBalanceBackgroundSize = 15.h;

  static double defaultScreenMargin = 6.w;

  //SHARE
  static double shareIconsSize = 19.sp;
  static double moodIconSize = 18.sp;

  static const FontWeight boldFontWeight = FontWeight.w800;
  static const FontWeight lightBoldFontWeight = FontWeight.w700;
  static const FontWeight normalFontWeight = FontWeight.w400;
  static const FontWeight lightFontWeight = FontWeight.w300;

  //WELLNESS TOOLTIPS
  static const double tooltipWidth = 40;
  static const double graphBarsWidth = 10;
  static double tooltipHeight = 3.h;

  //Gradient Decoration
  static const BoxDecoration defaultGradientDecoration = BoxDecoration(
    borderRadius: BorderRadius.only(
      topLeft: Radius.circular(15),
      topRight: Radius.circular(15),
    ),
    gradient: LinearGradient(
      begin: Alignment(0.00, -1.00),
      end: Alignment(0, 1),
      stops: [0.0, 0.8, 1.0],
      colors: [
        GalvanColors.mainGalvan,
        Color(0xFF163b4a),
        GalvanColors.mainGalvan,
      ],
    ),
  );
}

abstract class GalvanFonts {
  static const String gilroy = 'Gilroy';
  static const String lato = 'Lato';
}