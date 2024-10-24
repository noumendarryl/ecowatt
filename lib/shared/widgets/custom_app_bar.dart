import 'package:auto_route/auto_route.dart';
import 'package:ecowatt/shared/constants/ui_helpers.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../features/profile/logic/user_cubit.dart';
import '../../features/profile/logic/user_state.dart';
import '../../features/weather/logic/weather_cubit.dart';
import '../../features/weather/logic/weather_state.dart';
import '../../routing/app_router.gr.dart';

class CustomAppbar extends StatefulWidget implements PreferredSizeWidget {
  final String title;

  const CustomAppbar({super.key, required this.title});

  @override
  _CustomAppbarState createState() => _CustomAppbarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _CustomAppbarState extends State<CustomAppbar> {
  @override
  void initState() {
    super.initState();
    // Récupérer l'utilisateur connecté via le UserCubit
    final userCubit = context.read<UserCubit>();
    final currentUserId = FirebaseAuth.instance.currentUser?.uid; // Obtenir l'ID de l'utilisateur connecté depuis FirebaseAuth
    if (currentUserId != null) {
      userCubit.fetchUser(currentUserId); // Charger les informations de l'utilisateur
    }
    context.read<WeatherCubit>().getWeather();
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      automaticallyImplyLeading: true,
      centerTitle: true,
      leading: BlocBuilder<WeatherCubit, WeatherState>(
          builder: (context,state) {
          
            if (state is WeatherLoaded)  {
              String iconUrl = "http://openweathermap.org/img/wn/${state.weather.icon}@2x.png"; // URL de l'icône
              return IconButton(
                icon: Row(
                  children: [
                    const Text('hello'),
                    Image.network(iconUrl, width: 30, height: 30), // Affichage de l'icône
                    const SizedBox(width: 5),
                    Text(
                      "${state.weather.temperature.toStringAsFixed(1)}°C",
                      style: const TextStyle(color: Colors.black), // Couleur du texte
                    ),
                  ],
                ),
                onPressed: (){
                  context.router.push(const WeatherRoute());
                },
              );
            }else if (state is WeatherLoading) {
              return const Center(child: CircularProgressIndicator()); // Afficher un indicateur de chargement si nécessaire
            }
            return const Text('hello'); // Retourner un conteneur vide si aucun état n'est chargé
          },
      ),
      title: Text(
        widget.title,
        style: TextStyle(
            color
                : Theme.of(context).colorScheme.scrim,
            fontFamily: Theme.of(context)
                .textTheme
                .titleLarge!
                .fontFamily,
            fontSize: Theme.of(context)
                .textTheme
                .titleLarge!
                .fontSize,
            fontWeight: Theme.of(context)
                .textTheme
                .titleLarge!
                .fontWeight) ),
      actions: [
        BlocBuilder<UserCubit, UserState>(
          builder: (context, state) {
            return state.when(
              initial: () => const Padding(
                padding: EdgeInsets.only(right: 15),
                child: Icon(Icons.person),
              ),
              loading: () => const Padding(
                padding: EdgeInsets.only(right: 15),
                child: CircularProgressIndicator(), // Afficher un indicateur de chargement
              ),
              success: (user) {
                return IconButton(
                  icon: Padding(
                    padding: const EdgeInsets.only(right: 15),
                    child: Stack(
                      children: [
                        CircleAvatar(
                          radius: 18,
                          backgroundImage: (user.photoURL.isNotEmpty)
                              ? NetworkImage(user.photoURL) // Utiliser la photoURL si disponible
                              : null,
                          child: (user.photoURL.isEmpty)
                              ? const Icon(Icons.person, size: mediumSize) // Icône par défaut si pas de photo
                              : null,
                        ),
                        Positioned(
                          right: 0,
                          bottom: 0,
                          child: Container(
                            width: 10,
                            height: 10,
                            decoration: BoxDecoration(
                              color: Colors.green, // Le point vert
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.white, width: 2),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  onPressed: () {
                    context.router.push(const UserProfileRoute());
                  },
                );
              },
              failure: (error) => const Padding(
                padding: EdgeInsets.only(right: 15),
                child: Icon(CupertinoIcons.exclamationmark_triangle_fill, color: Colors.red), // Afficher une icône d'erreur
              ),
            );
          },
        ),
      ],
    );
  }
}
