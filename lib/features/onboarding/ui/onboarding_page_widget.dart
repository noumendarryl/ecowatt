import 'package:ecowatt/features/onboarding/ui/onboarding_page_content.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:ecowatt/features/onboarding/models/onboarding_page_model.dart';
import 'package:ecowatt/shared/constants/ui_helpers.dart';

class OnboardingPageWidget extends StatefulWidget {
  final List<OnboardingPageModel> pages;

  const OnboardingPageWidget({
    super.key,
    required this.pages,
  });

  @override
  State<OnboardingPageWidget> createState() => _OnboardingPageWidgetState();
}

class _OnboardingPageWidgetState extends State<OnboardingPageWidget> {
  late PageController _pageController;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onPageChanged(int index) {
    setState(() {
      _currentPage = index;
    });
  }

  void _skipToEnd() {
    _pageController.jumpToPage(widget.pages.length - 1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    backgroundColor: Theme.of(context).colorScheme.onSurface,
      body: Column(
        children: [
          Expanded(
            child: PageView(
              controller: _pageController,
              onPageChanged: _onPageChanged,
              children: [
                for (final page in widget.pages)
                  OnboardingPageContent(
                    image: page.image,
                    title: page.title,
                    description: page.description,
                    buttonText: page.buttonText,
                    onButtonPressed: page.onButtonPressed,
                  ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: smallSize + 6.0),
            child: SmoothPageIndicator(
              controller: _pageController,
              count: widget.pages.length,
              effect: WormEffect(
                dotColor: Theme.of(context).colorScheme.onTertiary,
                activeDotColor: Theme.of(context).colorScheme.primary,
                dotHeight: smallSize,
                dotWidth: smallSize,
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(smallSize + 6.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(
              onPressed:
                  _currentPage == widget.pages.length - 1 ? null : _skipToEnd,
              child: Text('Skip',  style: TextStyle(
              color: Theme.of(context).colorScheme.primary,
              fontFamily: Theme.of(context).textTheme.titleSmall!.fontFamily,
              fontSize: Theme.of(context).textTheme.bodyLarge!.fontSize,
              fontWeight: FontWeight.bold,
            ),),
            ),
            Text('${_currentPage + 1}/${widget.pages.length}', style: TextStyle(
              color: Theme.of(context).colorScheme.tertiary,
              fontFamily: Theme.of(context).textTheme.bodySmall!.fontFamily,
              fontSize: Theme.of(context).textTheme.bodySmall!.fontSize,
              fontWeight: Theme.of(context).textTheme.bodySmall!.fontWeight,
            ),),
          ],
        ),
      ),
    );
  }
}
