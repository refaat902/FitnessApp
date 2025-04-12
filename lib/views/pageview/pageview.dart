import 'package:auto_size_text/auto_size_text.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/di/injection.dart';
import 'package:flutter_application_1/core/transitions/transitions_class.dart';
import 'package:flutter_application_1/views/Login/data/cubit/login_cubit.dart';
import 'package:flutter_application_1/views/Login/login_page.dart';
import 'package:flutter_application_1/views/questions/age/age_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PageViewWithSlider extends StatefulWidget {
  const PageViewWithSlider({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _PageViewWithSliderState createState() => _PageViewWithSliderState();
}

class _PageViewWithSliderState extends State<PageViewWithSlider> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  final List<Widget> onBoardings = [
    const OnBoarding1(),
    const OnBoarding2(),
    const OnBoarding3(),
    const OnBoarding4(),
  ];

  void _onNext() {
    if (_currentIndex < onBoardings.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    }
  }

  void _onBack() {
    if (_currentIndex > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffE7FAFE),
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          PageView.builder(
            controller: _pageController,
            itemCount: onBoardings.length,
            onPageChanged: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            itemBuilder: (context, index) {
              return onBoardings[index];
            },
          ),
          Positioned(
            right: 0,
            child: Image.asset('assets/images/onBoardingBackGround.png'),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: MediaQuery.sizeOf(context).height * .06,
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.sizeOf(context).width * .06),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  // Back button (only visible if not on the first page)
                  if (_currentIndex > 0)
                    TextButton(
                      onPressed: _onBack,
                      child: const Text(
                        "Back",
                        style:
                            TextStyle(color: Color(0xff289004), fontSize: 17),
                      ),
                    ),
                  // Next or Finished button
                  if (_currentIndex < onBoardings.length - 1)
                    ElevatedButton(
                      style: ButtonStyle(
                        padding: WidgetStatePropertyAll(
                          EdgeInsets.symmetric(
                            vertical: MediaQuery.sizeOf(context).height * .016,
                            horizontal: MediaQuery.sizeOf(context).width * .018,
                          ),
                        ),
                        shape: const WidgetStatePropertyAll(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                          ),
                        ),
                      ),
                      onPressed: _onNext,
                      child: const Text(
                        "Next",
                        // style:
                        //     TextStyle(fontSize: 17),
                      ),
                    ),
                  if (_currentIndex == onBoardings.length - 1)
                    ElevatedButton(
                      style: ButtonStyle(
                        padding: WidgetStatePropertyAll(
                          EdgeInsets.symmetric(
                            vertical: MediaQuery.sizeOf(context).height * .016,
                            horizontal: MediaQuery.sizeOf(context).width * .018,
                          ),
                        ),
                        shape: const WidgetStatePropertyAll(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                          ),
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            CustomPageRoute(
                                page: BlocProvider(
                                  create: (context) => getIt<LoginCubit>(),
                                  child: const LoginPage(),
                                ),
                                transitionType: TransitionType.fade));
                      },
                      child: const Text(
                        "Finished",
                        // style:
                        //     TextStyle(color: Color(0xff289004), fontSize: 17),
                      ),
                    ),
                ],
              ),
            ),
          ),
          Positioned(
            right: 0,
            left: 0,
            bottom: MediaQuery.sizeOf(context).height * .02,
            child: DotsIndicator(
              dotsCount: onBoardings.length,
              position: _currentIndex,
              decorator: const DotsDecorator(
                activeColor: Color(0xff289004),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class OnBoarding4 extends StatelessWidget {
  const OnBoarding4({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/OnBoarding1.png'),
          ],
        ),
        const AutoSizeText.rich(
          TextSpan(
            text: 'Healthy Muscular ',
            style: TextStyle(
              color: Colors.black,
              fontSize: 40,
            ),
            children: [
              TextSpan(
                text: 'Sportswoman',
                style: TextStyle(
                  color: Color(0xff289004),
                  fontSize: 40,
                ),
              ),
              TextSpan(
                text: ' Standing',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 40,
                ),
              ),
            ],
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(
          height: MediaQuery.sizeOf(context).height * .04,
        ),
      ],
    );
  }
}

class OnBoarding2 extends StatelessWidget {
  const OnBoarding2({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/OnBoarding2.png'),
          ],
        ),
        SizedBox(
          height: MediaQuery.sizeOf(context).height * .02,
        ),
        const AutoSizeText.rich(
          TextSpan(
            text: 'PERFECT BODY ',
            style: TextStyle(
              color: Colors.black,
              fontSize: 40,
            ),
            children: [
              TextSpan(
                text: 'DOING',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 40,
                ),
              ),
              TextSpan(
                text: ' CROSSFIT',
                style: TextStyle(
                  color: Color(0xff289004),
                  fontSize: 40,
                ),
              ),
              TextSpan(
                text: ' EXERCISES',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 40,
                ),
              ),
            ],
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(
          height: MediaQuery.sizeOf(context).height * .04,
        ),
      ],
    );
  }
}

class OnBoarding3 extends StatelessWidget {
  const OnBoarding3({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/OnBoarding3.png'),
          ],
        ),
        SizedBox(
          height: MediaQuery.sizeOf(context).height * .02,
        ),
        const AutoSizeText.rich(
          TextSpan(
            text: 'PERFECT BODY ',
            style: TextStyle(
              color: Colors.black,
              fontSize: 40,
            ),
            children: [
              TextSpan(
                text: 'DOING',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 40,
                ),
              ),
              TextSpan(
                text: ' CROSSFIT',
                style: TextStyle(
                  color: Color(0xff289004),
                  fontSize: 40,
                ),
              ),
              TextSpan(
                text: ' EXERCISES',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 40,
                ),
              ),
            ],
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(
          height: MediaQuery.sizeOf(context).height * .04,
        ),
      ],
    );
  }
}

class OnBoarding1 extends StatelessWidget {
  const OnBoarding1({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/OnBoarding4.png'),
          ],
        ),
        SizedBox(
          height: MediaQuery.sizeOf(context).height * .02,
        ),
        const AutoSizeText.rich(
          TextSpan(
            text: 'PERFECT BODY ',
            style: TextStyle(
              color: Colors.black,
              fontSize: 40,
            ),
            children: [
              TextSpan(
                text: 'DOING',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 40,
                ),
              ),
              TextSpan(
                text: ' CROSSFIT',
                style: TextStyle(
                  color: Color(0xff289004),
                  fontSize: 40,
                ),
              ),
              TextSpan(
                text: ' EXERCISES',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 40,
                ),
              ),
            ],
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(
          height: MediaQuery.sizeOf(context).height * .04,
        ),
      ],
    );
  }
}
