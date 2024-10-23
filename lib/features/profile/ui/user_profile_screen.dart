import 'package:auto_route/auto_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
      title: 'Error',
      message: errorMessage,
      type: SnackbarType.error,
    );
  }

  @override
  void initState() {
    super.initState();
    final FirebaseAuth _auth = FirebaseAuth.instance;
    User? user = _auth.currentUser;
    String userId = user!.uid;
    context.read<UserCubit>().fetchUser(userId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        centerTitle: true,
      ),
      body: BlocBuilder<UserCubit, UserState>(
        builder: (context, state) {
          return state.when(
            initial: () =>
                const Center(child: Text('Aucun utilisateur trouvé')),
            loading: () => const Center(child: CircularProgressIndicator()),
            success: (user) => _buildProfile(context, user),
            failure: (error) {
              handleError(context, error);
              return Center(child: Text('Erreur : $error'));
            },
          );
        },
      ),
    );
  }

  Widget _buildProfile(BuildContext context, UserModel user) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 20),
          CircleAvatar(
            radius: 60,
            backgroundImage: user.photoURL.isNotEmpty
                ? NetworkImage(user
                    .photoURL) // Afficher l'image si `photoURL` n'est pas vide
                : null, // Aucun image si l'URL est vide ou null
            child: user.photoURL.isEmpty
                ? Icon(
                    Icons.person,
                    size: 70,
                    color: Colors.grey[700],
                  ) // Afficher une icône si `photoURL` est vide
                : null,
          ),
          const SizedBox(height: 10),
          Text(
            user.displayName,
            style: const TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            '@${user.username}',
            style: const TextStyle(
              fontSize: 20,
            ),
          ),
          const SizedBox(height: 15),
          CustomElevatedButton(
            btnLabel: 'Edit Profile',
            btnColor: Colors.purple,
            onPressed: () {
              // Logique pour modifier le profil
            },
          ),
          const SizedBox(height: 30),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Settings'),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.devices),
            title: const Text('Devices Management'),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.info),
            title: const Text('Information'),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Log out'),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              context.read<AuthCubit>().signOut;
              context.pushRoute(const WelcomeRoute());
            },
          ),
        ],
      ),
    );
  }
}
