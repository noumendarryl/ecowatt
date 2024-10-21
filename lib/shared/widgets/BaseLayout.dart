import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../features/auth/ui/register.dart';
import '../../routing/app_router.gr.dart';
import 'bottom_navigation.dart';
import 'customAppBar.dart';
import 'floatingActionButton.dart';


class BaseLayout extends StatelessWidget {
  final Widget child;
  final PreferredSizeWidget? appBar;


  final bool showFloatingActionButton;
   // AppBar personnalisé
  final int currentIndex;
  final String title;


  const BaseLayout({
    Key? key,
    required this.child,


    this.showFloatingActionButton = false,

    required this.currentIndex,
    this.appBar, required this.title,

  }) : super(key: key);

  void _onTap(BuildContext context, int index) {
    // Logique de navigation pour toutes les pages
    if (index == 0) {
      context.router.push(HomeRoute());
    } else if (index == 1) {
      context.router.push(SearchDeviceRoute());
    } else if (index == 2) {
      context.router.push(AddDeviceRoute());
    } else if (index == 3) {
      context.router.push(RecommendationsRoute());
    } else if (index == 4) {
      context.router.push(DashboardRoute());
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
          ? BuildFloatingActionButton()
          : null,
    );
  }
}
