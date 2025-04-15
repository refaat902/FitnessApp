import 'package:flutter/material.dart';
import 'package:flutter_application_1/views/category/widgets/shimmer_effect.dart';
import 'package:flutter_application_1/views/navigation/profile/data/cubit/profile_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<ProfileCubit>(context).emitGetProfile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      backgroundColor: const Color(0xffFCFCFC),
      body: BlocBuilder<ProfileCubit, ProfileState>(
        builder: (context, state) {
          if (state is GetProfileSuccessState) {
            return Padding(
              padding: EdgeInsets.symmetric(
                  vertical: MediaQuery.sizeOf(context).height * .03,
                  horizontal: MediaQuery.sizeOf(context).width * .02),
              child: _buildProfileContent(context, state),
            );
          } else {
            return const Center(child: ShimmerListTile());
          }
        },
      ),
    );
  }

  Widget _buildProfileContent(
      BuildContext context, GetProfileSuccessState state) {
    final profile = state.profileModel;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Personal Information",
          style:
              Theme.of(context).textTheme.titleMedium?.copyWith(fontSize: 18,color: const Color(0xff289004)),
        ),
        const SizedBox(height: 8),
        Padding(
          padding: EdgeInsets.symmetric(
              vertical: MediaQuery.sizeOf(context).height * .01,
              horizontal: MediaQuery.sizeOf(context).height * .03),
          child: Text(
            profile.fullName ?? "User Name",
          style:
              Theme.of(context).textTheme.labelLarge?.copyWith(color: Colors.black),
          ),
        ),
        _buildInfoCard(
          context: context,
          icon: Icons.email_outlined,
          title: "Email",
          value: profile.email ?? "Not provided",
        ),
      ],
    );
  }

  Widget _buildInfoCard({
    required BuildContext context,
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Container(
      padding:  EdgeInsets.symmetric(vertical: MediaQuery.sizeOf(context).height*.02,horizontal: MediaQuery.sizeOf(context).width*.02),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            // ignore: deprecated_member_use
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              // ignore: deprecated_member_use
              color: const Color(0xff289004).withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              icon,
              color: const Color(0xff289004),
              size: 24,
            ),
          ),
          SizedBox(width: MediaQuery.sizeOf(context).width*.02,),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
          style:
              Theme.of(context).textTheme.labelMedium,
                ),
                const SizedBox(height: 4),
                Text(
                  value,
          style:
              Theme.of(context).textTheme.labelMedium,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
