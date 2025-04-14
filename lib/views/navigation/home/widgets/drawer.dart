import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/di/injection.dart';
import 'package:flutter_application_1/core/helpers/shared_pref_helper.dart';
import 'package:flutter_application_1/core/transitions/transitions_class.dart';
import 'package:flutter_application_1/views/aimeal/data/cubit/ai_meal_cubit.dart';
import 'package:flutter_application_1/views/pageview/pageview.dart';
import 'package:flutter_application_1/views/userprofile/user_profile_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(color: Color(0xff289004)),
            child: Text(
              'Menu',
              style: TextStyle(color: Colors.white, fontSize: 24),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Logout'),
            onTap: () async {
              await SharedPrefService.setUserLoggedIn(false);
              await SharedPrefService.saveToken('');
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                    builder: (context) => const PageViewWithSlider()),
                (route) => false,
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Ai Meals Recommendations'),
            onTap: () {
              Navigator.push(
                context,
                CustomPageRoute(
                  page: BlocProvider(
                    create: (context) => getIt<AiMealCubit>(),
                    child: const UserProfilePage(),
                  ),
                  transitionType: TransitionType.slide,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
