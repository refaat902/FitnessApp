import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
                  children: [
                    Image.asset('assets/images/Ellipse4.png'),
                    Image.asset('assets/images/Ellipse3.png'),
                    Positioned(
                      left: MediaQuery.sizeOf(context).width * .04,
                      right: MediaQuery.sizeOf(context).width * .04,
                      top: MediaQuery.sizeOf(context).height * .15,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Your body. Our tech. Maximum results',
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.white, fontSize: 22),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
  }
}