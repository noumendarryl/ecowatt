import 'package:auto_route/auto_route.dart';
import 'package:ecowatt/shared/constants/ui_helpers.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../exceptions/custom_dialog.dart';
import '../../../routing/app_router.gr.dart';
import '../../../shared/widgets/custom_elevated_button.dart';
import '../../auth/logic/auth_cubit.dart';
import '../logic/user_cubit.dart';
import '../logic/user_state.dart';
import '../models/user_model.dart';

@RoutePage()
class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({super.key});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  void handleError(BuildContext context, String errorMessage) {
    showCustomSnackbar(
      context,
      title: 'Unable to load user profile',
      message: errorMessage,
      type: SnackbarType.error,
    );
  }

  @override
  void initState() {
    super.initState();
    _fetchUserProfile();
  }

  // Method to fetch data for user
  Future<void> _fetchUserProfile() async {
    await Future.wait([
      context
          .read<UserCubit>()
          .fetchUser(FirebaseAuth.instance.currentUser!.uid)
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.onSurface,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.onSurface,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Theme.of(context).colorScheme.tertiary,
            size: smallSize + 10,
          ),
          onPressed: () {
            context.router.maybePop();
          },
        ),
        title: Text(
          'Profile',
          style: TextStyle(
            color: Theme.of(context).colorScheme.scrim,
            fontFamily: Theme.of(context).textTheme.titleLarge!.fontFamily,
            fontSize: Theme.of(context).textTheme.titleLarge!.fontSize,
            fontWeight: Theme.of(context).textTheme.titleLarge!.fontWeight,
          ),
          textAlign: TextAlign.center,
        ),
        centerTitle: true,
      ),
      body: BlocBuilder<UserCubit, UserState>(
        builder: (context, state) {
          return state.when(
            initial: () => const Center(child: Text('No user found !')),
            loading: () => const Center(child: CircularProgressIndicator()),
            success: (user) => RefreshIndicator(
                // Customize the color and background color of the refresh indicator
                backgroundColor: Theme.of(context).colorScheme.onSurface,
                color: Theme.of(context).colorScheme.primary,

                // Trigger data refresh when pulled
                onRefresh: () async {
                  // Call the method to fetch data
                  await _fetchUserProfile();
                },
                child: _buildProfile(context, user)),
            failure: (error) {
              handleError(context, error);
              return Center(child: Text('Error : $error'));
            },
          );
        },
      ),
    );
  }

  Widget _buildProfile(BuildContext context, UserModel user) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: smallSize, vertical: mediumSize),
      child: Column(
        children: [
          verticalSpaceSmall,
          CircleAvatar(
            radius: 60,
            backgroundImage: user.photoURL.isNotEmpty
                ? NetworkImage(user
                    .photoURL) // Afficher l'image si `photoURL` n'est pas vide
                : null, // Aucun image si l'URL est vide ou null
            child: user.photoURL.isEmpty
                ? Icon(
                    Icons.person,
                    size: largeSize,
                    color: Theme.of(context).colorScheme.onSurface,
                  ) // Afficher une icône si `photoURL` est vide
                : null,
          ),
          verticalSpaceSmall,
          Text(
            user.displayName,
            style: TextStyle(
              color: Theme.of(context).colorScheme.scrim,
              fontSize: Theme.of(context).textTheme.bodyLarge!.fontSize,
              fontWeight: Theme.of(context).textTheme.bodyLarge!.fontWeight,
            ),
          ),
          verticalSpaceTiny,
          Text(
            '@${user.username}',
            style: TextStyle(
              color: Theme.of(context).colorScheme.tertiary,
              fontSize: Theme.of(context).textTheme.bodySmall!.fontSize,
            ),
          ),
          verticalSpaceSmall,
          CustomElevatedButton(
            label: 'Edit Profile',
            labelColor: Theme.of(context).colorScheme.onSurface,
            color: Theme.of(context).colorScheme.primary,
            onPressed: () {
              context.pushRoute(const EditProfileRoute());
            },
          ),
          verticalSpaceMedium,
          ListTile(
            leading: Icon(
              Icons.devices,
              color: Theme.of(context).colorScheme.scrim,
              size: mediumSize,
            ),
            title: Text(
              'Device Management',
              style: TextStyle(
                  color: Theme.of(context).colorScheme.scrim,
                  fontFamily:
                  Theme.of(context).textTheme.bodyMedium!.fontFamily,
                  fontSize: Theme.of(context).textTheme.bodyMedium!.fontSize),
            ),
            trailing: Icon(
              Icons.arrow_forward_ios,
              color: Theme.of(context).colorScheme.scrim,
              size: smallSize + 5,
            ),
            onTap: () {
            	context.pushRoute(const VoiceCommandRoute());
            },
          ),
          ListTile(
            leading: Icon(
              Icons.info,
              color: Theme.of(context).colorScheme.scrim,
              size: mediumSize,
            ),
            title: Text(
              'About us',
              style: TextStyle(
                  color: Theme.of(context).colorScheme.scrim,
                  fontFamily:
                      Theme.of(context).textTheme.bodyMedium!.fontFamily,
                  fontSize: Theme.of(context).textTheme.bodyMedium!.fontSize),
            ),
            trailing: Icon(
              Icons.arrow_forward_ios,
              color: Theme.of(context).colorScheme.scrim,
              size: smallSize + 5,
            ),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(
              Icons.mic,
              color: Theme.of(context).colorScheme.scrim,
              size: mediumSize,
            ),
            title: Text(
              'Voice Command',
              style: TextStyle(
                  color: Theme.of(context).colorScheme.scrim,
                  fontFamily:
                  Theme.of(context).textTheme.bodyMedium!.fontFamily,
                  fontSize: Theme.of(context).textTheme.bodyMedium!.fontSize),
            ),
            trailing: Icon(
              Icons.arrow_forward_ios,
              color: Theme.of(context).colorScheme.scrim,
              size: smallSize + 5,
            ),
            onTap: () {
            	//context.pushRoute(const VoiceCommandRoute());
            },
          ),
          ListTile(
            leading: Icon(
              Icons.settings,
              color: Theme.of(context).colorScheme.scrim,
              size: mediumSize,
            ),
            title: Text(
              'Settings',
              style: TextStyle(
                  color: Theme.of(context).colorScheme.scrim,
                  fontFamily:
                      Theme.of(context).textTheme.bodyMedium!.fontFamily,
                  fontSize: Theme.of(context).textTheme.bodyMedium!.fontSize),
            ),
            trailing: Icon(
              Icons.arrow_forward_ios,
              color: Theme.of(context).colorScheme.scrim,
              size: smallSize + 5,
            ),
            onTap: () {},
          ),
          const Spacer(),
          ListTile(
            title: Text(
              'Logout',
              style: TextStyle(
                  color: Theme.of(context).colorScheme.scrim,
                  fontFamily:
                      Theme.of(context).textTheme.bodyMedium!.fontFamily,
                  fontSize: Theme.of(context).textTheme.bodyMedium!.fontSize),
            ),
            trailing: Icon(
              Icons.logout,
              color: Theme.of(context).colorScheme.scrim,
              size: mediumSize,
            ),
            onTap: () {
              context.read<AuthCubit>().signOut;
              context.pushRoute(const OnboardingRoute());
            },
          ),
        ],
      ),
    );
  }
}
