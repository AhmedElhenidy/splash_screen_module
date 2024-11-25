import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../../../core/common-widgets/images/image_widget.dart';
import '../../../../core/utils/style/asset_manager.dart';
import '../../../../core/utils/style/color_manager.dart';
import '../../../../core/utils/style/text_manager.dart';

class OnBoardingScreen extends StatefulWidget {
  final Function() onIntroFinish;
  const OnBoardingScreen({required this.onIntroFinish,super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final PageController indicatorController = PageController();

  final List<String> _onBoardingImages = [
    IconsAssets.onBoardingOne,
    IconsAssets.onBoardingTwo,
    IconsAssets.onBoardingThree,
  ];

  final List<String> _onBoardingHeaders = [
    'The Most Trusted Insurance Platform',
    'All Your Insurance Needs in One Place',
    'Start your insurance journey',
  ];

  final List<String> _onBoardingSubtitles = [
    'Compare top offers and get insured in just 90 seconds',
    'From Car and Health to Medical Malpractice, Travel, and more!',
    'Fast, Easy, and Secure—Get the Coverage You Need in Just a Few Taps',
  ];

  Future<void> goToNextStep() async {
    if (indicatorController.page!.round() >= _onBoardingHeaders.length - 1) {
      // go to Identity
      widget.onIntroFinish();
    } else {
      indicatorController.nextPage(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeIn,
      );
    }
  }

  Future<void> goToPreviousStep() async {
    if (indicatorController.page!.round() > 0) {
      indicatorController.previousPage(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeIn,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
            controller: indicatorController,
            itemCount: _onBoardingImages.length,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  Expanded(
                    flex: 2,
                    child: Stack(
                      children: [
                        ImageWidget(
                          imageUrl: _onBoardingImages[index],
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: double.infinity,
                        ),
                        SafeArea(
                          child: Align(
                            alignment: AlignmentDirectional.topEnd,
                            child: Padding(
                              padding: EdgeInsetsDirectional.only(
                                top: 16.h,
                                end: 16.w,
                              ),
                              child: Container(
                                height: 29.h,
                                width: 63.w,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(19),
                                  color:
                                      ColorManager.basicsBlack.withOpacity(0.6),
                                ),
                                child: InkWell(
                                  onTap: () {
                                    widget.onIntroFinish();
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'skip'.tr(),
                                        style: context.locale.languageCode ==
                                                'en'
                                            ? TextStyleManager.bold12Bold
                                                .copyWith(
                                                color: ColorManager.basicsWhite,
                                              )
                                            : TextStyleManager.bold12Bold
                                                .copyWith(
                                                color: ColorManager.basicsWhite,
                                              ),
                                      ),
                                      4.5.horizontalSpace,
                                      Transform(
                                        alignment: Alignment.center,
                                        transform:
                                            context.locale.languageCode == 'ar'
                                                ? Matrix4.rotationY(
                                                    3.14159,
                                                  ) // Rotate 180 degrees
                                                : Matrix4.identity(),
                                        child: ImageWidget(
                                          imageUrl: IconsAssets.rightIcon,
                                          width: 9.w,
                                          height: 12.h,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 20,
                        horizontal: 24,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            textAlign: TextAlign.center,
                            _onBoardingHeaders[index].tr(),
                            style: TextStyleManager.bold24Bold,
                          ),
                          8.verticalSpace,
                          Text(
                            textAlign: TextAlign.center,
                            _onBoardingSubtitles[index].tr(),
                            style: TextStyleManager.regular16Reg,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
          SafeArea(
            child: Column(
              children: [
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SmoothPageIndicator(
                        controller: indicatorController,
                        count: _onBoardingHeaders.length,
                        effect: ExpandingDotsEffect(
                          activeDotColor: ColorManager.primaryPrimary6,
                          dotColor:
                              ColorManager.primaryPrimary6.withOpacity(0.1),
                          dotHeight: 8.w,
                          dotWidth: 8.w,
                          radius: 32,
                        ),
                      ),
                      InkWell(
                        splashColor: Colors.transparent,
                        onTap: goToNextStep,
                        child: CircleAvatar(
                          radius: 21.h,
                          backgroundColor: ColorManager.primaryPrimary6,
                          child: Transform(
                            alignment: Alignment.center,
                            transform: context.locale.languageCode == 'ar'
                                ? Matrix4.rotationY(
                                    3.14159,
                                  ) // Rotate 180 degrees for Arabic
                                : Matrix4.identity(),
                            child: Icon(
                              context.locale.languageCode == 'ar'
                                  ? Icons.arrow_back_ios_new_rounded
                                  : Icons.arrow_forward_ios_rounded,
                              color: ColorManager.basicsWhite,
                              size: 16.sp,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                20.verticalSpace,
              ],
            ),
          ),
        ],
      ),
    );
  }
}
