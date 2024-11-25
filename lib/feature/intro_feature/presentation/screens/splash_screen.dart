import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../core/common-widgets/images/image_widget.dart';
import '../../../../core/get_it_injection.dart';
import '../../../../core/utils/navigation_routes/navigation_utils.dart';
import '../../../../core/utils/style/asset_manager.dart';
import '../../../../core/utils/style/color_manager.dart';
import '../../../../core/utils/style/text_manager.dart';
import 'choose_lang_screen.dart';

class SplashScreen extends StatefulWidget {
  final Function(BuildContext context) onIntroFinish;
  const SplashScreen({required this.onIntroFinish,super.key});

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    _initializeApp();
  }

  Future<void> _initializeApp() async {
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      await warmingUpTameeni();
      await _setupApp(true);
    });
  }

  Future<void> _setupApp(bool isFirstRun) async {
    _navigateToChooseLangScreen();
  }

  void _navigateToChooseLangScreen() {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (c) => ChooseLangScreen(onIntroFinish: widget.onIntroFinish,)),
          (Route<dynamic> route) => false,
    );
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
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Stack(
          fit: StackFit.expand,
          children: [
            Align(
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    width: 80,
                    height: 80,
                    child: ImageWidget(
                      imageUrl: IconsAssets.newTameeniLogo,
                      // context.locale.languageCode == "en"
                      //     ? IconsAssets.tameeniLogen
                      //     : IconsAssets.tameeniLogar,
                    ),
                  ),
                  16.verticalSpace,
                  Text(
                    'Tameeni'.tr(),
                    style: TextStyleManager.bold16Bold,
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 5.h,
              right: 25.w,
              left: 25.w,
              child: Column(
                children: [
                  Text(
                    'Copyright'.tr(),
                    style: TextStyleManager.regular12Reg
                        .copyWith(color: ColorManager.greyGrey5),
                  ),
                  Text(
                    'PoweredBy'.tr(),
                    style: TextStyleManager.regular12Reg,
                  ),
                  5.verticalSpace,
                  SizedBox(
                    height: 10.h,
                    child: SvgPicture.asset(
                      IconsAssets.rasan,
                      height: 10.h,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
