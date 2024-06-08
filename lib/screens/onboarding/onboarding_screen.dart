import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:travelguide/screens/home/home_screen.dart';
import 'package:travelguide/screens/onboarding/onboarding_items.dart';
import 'onboarding_page.dart';

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  final controller = OnboardingItems();
  int _currentPage = 0;
  bool isLastPage = false;

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(
      context,
      designSize: Size(375, 812),
      minTextAdapt: true,
    );
    return Scaffold(
      backgroundColor: Colors.white,
      bottomSheet: Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        color: Colors.white,
        child: isLastPage
            ? getStarted()
            : Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () => _pageController.previousPage(
                        duration: Duration(milliseconds: 300),
                        curve: Curves.easeIn),
                    child: Text("Prev"),
                  ),
                  SmoothPageIndicator(
                    controller: _pageController,
                    count: controller.items.length,
                    effect: const ExpandingDotsEffect(
                      dotHeight: 7,
                      dotWidth: 10,
                      activeDotColor: Colors.blueAccent,
                    ),
                    onDotClicked: (index) => _pageController.animateToPage(
                        index,
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeIn),
                  ),
                  TextButton(
                    onPressed: () => _pageController.nextPage(
                        duration: Duration(milliseconds: 300),
                        curve: Curves.easeIn),
                    child: Text("Next"),
                  ),
                  // List.generate(3, (index) {
                  //   return AnimatedContainer(
                  //     duration: Duration(milliseconds: 300),
                  //     width: _currentPage == index ? 30.w : 10.w,
                  //     height: 5.h,
                  //     margin: EdgeInsets.symmetric(horizontal: 5.w),
                  //     decoration: BoxDecoration(
                  //       color: _currentPage == index ? Colors.blue : Colors.grey,
                  //       borderRadius: BorderRadius.circular(5),
                  //     ),
                  //   );
                  // }
                  // ),
                ],
              ),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 15),
        child: PageView.builder(
          onPageChanged: (index) =>
              setState(() => isLastPage = controller.items.length - 1 == index),
          itemCount: controller.items.length,
          controller: _pageController,
          itemBuilder: (context, index) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(controller.items[index].imagePath),
                const SizedBox(height: 15),
                Text(controller.items[index].title,
                    style: GoogleFonts.poppins(
                        fontSize: 30, fontWeight: FontWeight.bold)),
                const SizedBox(height: 15),
                Text(controller.items[index].subtitle,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(fontSize: 16)),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget getStarted() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.lightBlue,
      ),
      width: MediaQuery.of(context).size.width,
      height: 55,
      child: TextButton(
        onPressed: () async {
          final pres = await SharedPreferences.getInstance();
          pres.setBool("onboarding", true);

          if (!mounted) return;
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => HomeScreen()));
        },
        child: Text(
          "Get Started",
          style: GoogleFonts.poppins(color: Colors.white, fontSize: 14),
        ),
      ),
    );
  }
}
