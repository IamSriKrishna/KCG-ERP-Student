import 'package:flutter/material.dart';
import 'package:kcgerp/Feature/Screen/Auth/Login.dart';
import 'package:kcgerp/Feature/Screen/Auth/SignUp.dart';
import 'package:kcgerp/Feature/Screen/Messenger/MessageScreen.dart';
import 'package:kcgerp/Feature/Screen/MyProfile/EditProfile.dart';
import 'package:kcgerp/Feature/Screen/MyProfile/MyProfile.dart';
import 'package:kcgerp/Feature/Screen/OnBoard/OnboardScreen.dart';
import 'package:kcgerp/Feature/Screen/OnBoard/Screen2.dart';
import 'package:kcgerp/Feature/Screen/OnBoard/Screen3.dart';
import 'package:kcgerp/Feature/Screen/OverScreen/Home/HomeScreen.dart';
import 'package:kcgerp/Feature/Screen/OverScreen/OverScreen.dart';
import 'package:kcgerp/Feature/Screen/OverScreen/Profile/Widget/About.dart';
import 'package:kcgerp/Feature/Screen/OverScreen/Request/GatePass/GatePass.dart';
import 'package:kcgerp/Feature/Screen/OverScreen/Request/GatePass/GatePassHistory.dart';
import 'package:kcgerp/Feature/Screen/OverScreen/Request/Leave/History.dart';
import 'package:kcgerp/Feature/Screen/OverScreen/Request/Leave/LeaveWidget/CustomSfCalendar.dart';
import 'package:kcgerp/Feature/Screen/OverScreen/Request/Leave/LeaveWidget/LeaveExpand.dart';
import 'package:kcgerp/Feature/Screen/OverScreen/Request/ODScreen/ODScreen.dart';
import 'package:kcgerp/Feature/Screen/OverScreen/Request/ODScreen/ODWidget/ODExpandWidget.dart';
import 'package:kcgerp/Feature/Screen/OverScreen/Request/Widget/ConfirmPage.dart';
import 'package:kcgerp/Feature/Screen/Search/Search.dart';
import 'package:kcgerp/SplashScreen.dart';
import 'package:kcgerp/Util/util.dart';
import 'package:lottie/lottie.dart';
import 'package:page_transition/page_transition.dart';

Route<dynamic> onGenerator(RouteSettings settings,String locale) {
  switch (settings.name) {
    case ODEXpandWidget.route:
      return PageTransition(
        duration: Duration(milliseconds: duration.fadeMilliseconds),
        child: ODEXpandWidget(),
        type: PageTransitionType.fade,
        settings: settings,
      );
    case ODScreen.route:
      return PageTransition(
        duration: Duration(milliseconds: duration.fadeMilliseconds),
        child: ODScreen(),
        type: PageTransitionType.fade,
        settings: settings,
      );
    case SearchScreen.route:
      return PageTransition(
        duration: Duration(milliseconds: duration.fadeMilliseconds),
        child: SearchScreen(),
        type: PageTransitionType.fade,
        settings: settings,
      );
    case GatePassHistory.route:
      return PageTransition(
        duration: Duration(milliseconds: duration.fadeMilliseconds),
        child: GatePassHistory(),
        type: PageTransitionType.fade,
        settings: settings,
      );
    case GatePassScreen.route:
      return PageTransition(
        duration: Duration(milliseconds: duration.fadeMilliseconds),
        child: GatePassScreen(locale: locale,),
        type: PageTransitionType.fade,
        settings: settings,
      );
    case LeaveExpand.route:
      return PageTransition(
        duration: Duration(milliseconds: duration.fadeMilliseconds),
        child: LeaveExpand(),
        type: PageTransitionType.fade,
        settings: settings,
      );
    case CustomSFCalendar.route:
      return PageTransition(
        duration: Duration(milliseconds: duration.fadeMilliseconds),
        child: CustomSFCalendar(),
        type: PageTransitionType.fade,
        settings: settings,
      );
    case SplashScreen.route:
      return PageTransition(
        duration: Duration(milliseconds: duration.fadeMilliseconds),
        child: SplashScreen(),
        type: PageTransitionType.fade,
        settings: settings,
      );
    case AboutWebviewScreen.route:
      return PageTransition(
        duration: Duration(milliseconds: duration.fadeMilliseconds),
        child: AboutWebviewScreen(),
        type: PageTransitionType.fade,
        settings: settings,
      );
    case Login.route:
      return PageTransition(
        duration: Duration(milliseconds: duration.fadeMilliseconds),
        child: Login(),
        type: PageTransitionType.fade,
        settings: settings,
      );
    case History.route:
      return PageTransition(
        duration: Duration(milliseconds: duration.fadeMilliseconds),
        child: History(),
        type: PageTransitionType.fade,
        settings: settings,
      );
    case SignUp.route:
      return PageTransition(
        duration: Duration(milliseconds: duration.fadeMilliseconds),
        child: SignUp(),
        type: PageTransitionType.fade,
        settings: settings,
      );
    case ScreenThree.route:
      return PageTransition(
        duration: Duration(milliseconds: duration.fadeMilliseconds),
        child: ScreenThree(),
        type: PageTransitionType.fade,
        settings: settings,
      );
    case ScreenTwo.route:
      return PageTransition(
        duration: Duration(milliseconds: duration.fadeMilliseconds),
        child: ScreenTwo(),
        type: PageTransitionType.fade,
        settings: settings,
      );
    case OnBoardScreen.route:
      return PageTransition(
        duration: Duration(milliseconds: duration.fadeMilliseconds),
        child: OnBoardScreen(),
        type: PageTransitionType.fade,
        settings: settings,
      );
    case ConfirmationPage.route:
      return PageTransition(
        duration: Duration(milliseconds: duration.fadeMilliseconds),
        child: ConfirmationPage(),
        type: PageTransitionType.fade,
        settings: settings,
      );
    case OverScreen.route:
      return PageTransition(
        duration: Duration(milliseconds: duration.fadeMilliseconds),
        child: const OverScreen(),
        type: PageTransitionType.fade,
        settings: settings,
      );
    // case ChatScreen.route:
    // final arg = settings.arguments as String;
    //   return PageTransition(
    //     duration: Duration(milliseconds: duration.fadeMilliseconds),
    //     child: ChatScreen(title: arg, profile: arg, id: arg,user: [arg],),
    //     type: PageTransitionType.fade,
    //     settings: settings,
    //   );
    case HomeScreen.route:
      return PageTransition(
        duration: Duration(milliseconds: duration.fadeMilliseconds),
        child: const HomeScreen(),
        type: PageTransitionType.fade,
        settings: settings,
      );
    case MessageScreen.route:
      return PageTransition(
        duration: Duration(milliseconds: duration.fadeMilliseconds),
        child: MessageScreen(),
        type: PageTransitionType.fade,
        settings: settings,
      );
    case MyProfile.route:
      return PageTransition(
        duration: Duration(milliseconds: duration.fadeMilliseconds),
        child: MyProfile(),
        type: PageTransitionType.fade,
        settings: settings,
      );
    // case ThirdUserProfile.route:
    //   return PageTransition(
    //     duration: Duration(milliseconds: duration.fadeMilliseconds),
    //     child: ThirdUserProfile(),
    //     type: PageTransitionType.fade,
    //     settings: settings,
    //   );
    case EditProfile.route:
      return PageTransition(
        duration: Duration(milliseconds: duration.fadeMilliseconds),
        child: EditProfile(),
        type: PageTransitionType.fade,
        settings: settings,
      );
    default:
      return PageTransition(
        duration: const Duration(seconds: 1),
        child: Scaffold(
          body: Center(
            child: Lottie.asset('asset/lottie/404.json'),
          ),
        ),
        type: PageTransitionType.fade,
        settings: settings,
      );
  }
}
