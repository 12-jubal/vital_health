/// A stateless widget that represents an onboarding page.
///
/// The [OnboardingPage] widget displays an image, a description, and navigation controls
/// for an onboarding flow. It includes a "Skip" button, a back button, a next button,
/// and indicators to show the current page index.
///
/// The widget requires the following parameters:
/// - [description]: A string that describes the content of the onboarding page.
/// - [imagePath]: The path to the image asset to be displayed on the onboarding page.
/// - [currentIndex]: The current index of the onboarding page.
/// - [onSkip]: A callback function to be executed when the "Skip" button is pressed.
/// - [onNext]: A callback function to be executed when the "Next" button is pressed.
/// - [onBack]: A callback function to be executed when the "Back" button is pressed.
///
/// The [OnboardingPage] widget uses the `flutter_screenutil` package for responsive
/// design, ensuring that the UI elements scale appropriately on different screen sizes.
library;

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OnboardingPage extends StatelessWidget {
  // final String title;
  final String description;
  final String imagePath;
  final int currentIndex;
  final void Function()? onSkip, onNext, onBack;

  const OnboardingPage({
    super.key,
    // required this.title,
    required this.description,
    required this.imagePath,
    required this.currentIndex,
    required this.onSkip,
    required this.onNext,
    required this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Align(
            alignment: Alignment.topRight,
            child: TextButton(
              onPressed: onSkip,
              child: Text(
                'Skip',
                style: TextStyle(
                  color: Colors.blueAccent,
                  fontSize: 16.sp,
                ),
              ),
            ),
          ),
          // Image
          Expanded(
            flex: 2,
            child: Image.asset(imagePath, fit: BoxFit.contain),
          ),
          SizedBox(height: 30.h),
          Text(
            description,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontSize: 16.sp,
                  color: Colors.black54,
                ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 40.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: onBack,
                child: Container(
                  padding: EdgeInsets.all(8.r),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30.r),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        offset: Offset(0, 4),
                        blurRadius: 4,
                      ),
                    ],
                  ),
                  child: Icon(
                    Icons.arrow_back,
                    color: currentIndex == 0 ? Colors.grey : Colors.blueAccent,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(3, (index) {
                  return Container(
                    margin: EdgeInsets.symmetric(horizontal: 2.w),
                    width: index == currentIndex ? 24.w : 6.w,
                    height: 6.h,
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(8.r),
                      color: index == currentIndex
                          ? Colors.blueAccent
                          : Colors.grey.shade400,
                    ),
                  );
                }),
              ),
              GestureDetector(
                onTap: onNext,
                child:
                    // currentIndex == 2
                    //     ? TextButton(
                    //         onPressed: onNext,
                    //         child: Text(
                    //           'Start',
                    //           style: TextStyle(
                    //             color: Colors.blueAccent,
                    //             fontSize: 16.sp,
                    //           ),
                    //         ),
                    //       )
                    // :
                    Container(
                  padding: EdgeInsets.all(8.r),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30.r),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        offset: Offset(0, 4),
                        blurRadius: 4,
                      ),
                    ],
                  ),
                  child: Icon(
                    Icons.arrow_forward,
                    color: Colors.blueAccent,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
