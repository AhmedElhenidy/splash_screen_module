import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' as services;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/common-widgets/buttons/solid_button.dart';
import '../../../../core/common-widgets/images/image_widget.dart';
import '../../../../core/get_it_injection.dart';
import '../../../../core/utils/navigation_routes/navigation_utils.dart';
import '../../../../core/utils/style/asset_manager.dart';
import '../../../../core/utils/style/color_manager.dart';
import '../../../../core/utils/style/styles_manager.dart';
import '../../../../core/utils/style/text_manager.dart';
import 'onboarding_screen.dart';

class ChooseLangScreen extends StatelessWidget {
  final Function(BuildContext context) onIntroFinish;
  const ChooseLangScreen({required this.onIntroFinish,super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            flex: 3,
            child: Align(
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
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Directionality(
                  textDirection: services.TextDirection.rtl,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: languageButton(
                          text: 'العربية',
                          selected: context.locale.languageCode == 'ar',
                          onPressed: () {
                            context.setLocale(LanguageManager.arabicLocal);
                          },
                        ),
                      ),
                      12.horizontalSpace,
                      Expanded(
                        child: languageButton(
                          text: 'English',
                          selected: context.locale.languageCode == 'en',
                          onPressed: () {
                            context.setLocale(LanguageManager.englishLocal);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                20.verticalSpace,
                SolidButton(
                  text: 'Confirm'.tr(),
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (ctx)=>
                        OnBoardingScreen(
                          onIntroFinish: onIntroFinish,
                        )));
                  },
                ),
                16.verticalSpace,
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget languageButton({
    required String text,
    Function()? onPressed,
    bool selected = false,
  }) {
    return SolidButton(
      text: text,
      width: 166.w,
      onPressed: onPressed,
      textStyle: TextStyleManager.regular16Reg
          .copyWith(color: ColorManager.basicsBlack),
      buttonStyle: ButtonsStyleManager.solidButtonStyle.copyWith(
        backgroundColor: WidgetStateProperty.all<Color>(ColorManager.greyGrey1),
        shape: WidgetStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: selected
                ? const BorderSide(color: ColorManager.primaryPrimary6)
                : BorderSide.none,
          ),
        ),
      ),
    );
  }
}
