import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_builder_validators/localization/l10n.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:splash_screen_module/feature/intro_feature/presentation/screens/splash_screen.dart';
import 'core/common-widgets/app_layout.dart';
import 'core/get_it_injection.dart';
import 'core/utils/locale_info.dart';
import 'core/utils/extensions/screen_util_extensions.dart';
import 'core/utils/navigation_routes/navigation_utils.dart';
import 'core/utils/style/text_manager.dart';
import 'core/utils/style/theme_manager.dart';


class Tameeni extends StatefulWidget {
  final Function(BuildContext context) onIntroFinish;
  const Tameeni({required this.onIntroFinish,super.key});

  @override
  State<Tameeni> createState() => _TameeniState();
}

class _TameeniState extends State<Tameeni> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(seconds: 2));
    warmingUpTameeni();
  }
  Future<void> warmingUpTameeni() async {
    //* Setting system bar icons to be dark while application background is white
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);

    //* Widgets Binding Initialized
    WidgetsFlutterBinding.ensureInitialized();

    //* Initialize Localization
    await EasyLocalization.ensureInitialized();
    //* Initialize Get injection
    await init();
  }
  @override
  Widget build(BuildContext context) {
    //
    //* EasyLocalization
    //
    return EasyLocalization(
      supportedLocales: [
        LanguageManager.arabicLocal,
        LanguageManager.englishLocal,
      ],
      path: LanguageManager.assetsPathLocalisations,
      fallbackLocale: LanguageManager.arabicLocal,
      saveLocale: true,
      //
      //* OverlaySupport
      //
      child: OverlaySupport.global(
        //
        //* ScreenUtilInit
        //
        child: ScreenUtilInit(
          designSize: const Size(375, 812),
          minTextAdapt: true,
          useInheritedMediaQuery: true,
          enableScaleWH: () {
            if (ScreenUtil().deviceType(context) == DeviceType.mobile) {
              return false;
            }
            return true;
          },
          fontSizeResolver: (fontSize, instance) {
            double aspectRatio =
                ScreenUtil().screenWidth / ScreenUtil().screenHeight;
            if (aspectRatio > 1.5) {
              // For wider screens (e.g., foldable devices), reduce the font size slightly
              return fontSize * 0.95;
            } else if (ScreenUtil().isBiggerThanMobileScreen) {
              return fontSize * 1.5;
            } else {
              // For narrower screens, keep the font size as is or adjust as needed
              return fontSize.toDouble();
            }
          },

          // splitScreenMode: true,
          //
          //* MaterialApp
          //
          builder: (context, child) => MaterialApp(
            localizationsDelegates: [
              ...context.localizationDelegates,
              FormBuilderLocalizations.delegate,
            ],
            builder: (context, child) {
              AppLocaleInfo.instance.setLocale(context.locale);

              return MediaQuery(
                data: MediaQuery.of(context)
                    .copyWith(textScaler: TextScaler.noScaling),
                child: AppLayout(child: child!),
              );
            },
            supportedLocales: context.supportedLocales,
            locale: context.locale,
            title: 'Tameeni',
            debugShowCheckedModeBanner: false,
            theme: getTameeniTheme(),
            navigatorKey: getIt<NavUtils>().navigatorKey,
            home:  SplashScreen(onIntroFinish: widget.onIntroFinish),
          ),
        ),
      ),
    );
  }
}
