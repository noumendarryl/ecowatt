import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../routing/app_router.gr.dart';
import 'bottom_navigation.dart';
import 'custom_app_bar.dart';
import 'floating_action_button.dart';


class BaseLayout extends StatelessWidget {
  final Widget child;
  final PreferredSizeWidget? appBar;


  final bool showFloatingActionButton;
   // AppBar personnalisé
  final int currentIndex;
  final String title;


  const BaseLayout({
    super.key,
    required this.child,


    this.showFloatingActionButton = false,

    required this.currentIndex,
    this.appBar, required this.title,

  });

  void _onTap(BuildContext context, int index) {
    // Logique de navigation pour toutes les pages
    if (index == 0) {
      context.router.push(const HomeRoute());
    } else if (index == 1) {
      context.router.push(const SearchDeviceRoute());
    } else if (index == 2) {
      context.router.push(const AddDeviceRoute());
    } else if (index == 3) {
      context.router.push(const RecommendationsRoute());
    } else if (index == 4) {
      context.router.push(const DashboardRoute());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar ?? CustomAppbar(title: title),

      backgroundColor: Theme.of(context).colorScheme.onTertiary,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: child,
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: currentIndex,
        onTap:  (index) => _onTap(context, index),
      ),
      floatingActionButton: showFloatingActionButton
          ? const BuildFloatingActionButton()
          : null,
    );
  }
}
