import 'package:auto_route/auto_route.dart';
import 'package:ecowatt/features/profile/models/user_model.dart';
import 'package:ecowatt/shared/widgets/form_layout.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';


import '../../../shared/constants/ui_helpers.dart';
import '../logic/edit_profile_cubit.dart';
import '../logic/edit_profile_state.dart';

@RoutePage()
class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _displayNameController = TextEditingController();

  final TextEditingController _emailController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  File? _profileImage;

  Future<void> _pickImage() async {
    final pickedFile =
    await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _profileImage = File(pickedFile.path);
      });
    }
  }



  @override
  void initState() {
    super.initState();
    context.read<EditProfileCubit>().loadUser();
  }


  void _saveProfile() {
    if (_formKey.currentState!.validate()) {
      final FirebaseAuth _auth = FirebaseAuth.instance;
      User? user = _auth.currentUser;
      String uid = user!.uid;

      // Appeler la logique pour enregistrer le profil ici
      final updatedUser = UserModel(
        uid: uid,
        username: _usernameController.text,
        displayName: _displayNameController.text,
        email: _emailController.text,
        photoURL: _profileImage != null ? _profileImage!.path : '', // Utilisez le chemin ou une URL
      );

      // Appelez la méthode updateUser avec le UserModel et l'image
      context.read<EditProfileCubit>().updateUser(updatedUser, image: _profileImage);
    }
  }

  @override
  Widget build(BuildContext context) {

    return BlocListener<EditProfileCubit, EditProfileState>(
      listener: (context, state) {
        state.maybeWhen(
          updated: (user) {


            Navigator.of(context).pop();
          },
          error: (message) {

          },
          orElse: () {},
        );

      },
      child: BlocBuilder<EditProfileCubit, EditProfileState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: const Center(child: Text('Edit Profile')),
            ),
            body: Container(
              padding: const EdgeInsets.symmetric(horizontal: smallSize, vertical: largeSize),
              child: FormLayout(isPassword: false,formKey: _formKey, label: 'Save', onAction:_saveProfile, isAvatar: true,
                photoUrl: state.maybeWhen(
                  loaded: (user) => user.photoURL?.isNotEmpty == true ? user.photoURL : null,
                  orElse: () => null,
                ),
                avatar: _profileImage, // Image de profil locale
                isDisplayName: true,
                displayNameValue: state.maybeWhen(
                  loaded: (user) => user?.displayName,
                  orElse: () => '',
                ),
                displayNameController: _displayNameController,
                isUsername: true,
                usernameValue: state.maybeWhen(
                  loaded: (user) => user.username,
                  orElse: () => '',
                ),
                usernameController: _usernameController,
                isEmail: true,
                emailValue: state.maybeWhen(
                  loaded: (user) => user.email,
                  orElse: () => '',
                ),
                emailController: _emailController,
              ),
            ),
          );

        },
      ),
    );
  }
}
