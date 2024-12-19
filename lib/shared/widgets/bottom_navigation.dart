import 'package:ecowatt/shared/constants/ui_helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CustomBottomNavigationBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Theme.of(context).colorScheme.onSurface,
      currentIndex: currentIndex,
      onTap: onTap,
      type: BottomNavigationBarType.fixed,
      items: [
        BottomNavigationBarItem(
          label: '',
          icon: Icon(
            currentIndex == 0
                ? Icons.toggle_on_outlined
                : Icons.toggle_off_outlined,
            color: currentIndex == 0
                ? Theme.of(context).colorScheme.primary
                : Theme.of(context).colorScheme.tertiary,
            size: smallSize + 10,
          ),
        ),
        BottomNavigationBarItem(
          label: '',
          icon: Icon(
            CupertinoIcons.search,
            color: currentIndex == 1
                ? Theme.of(context).colorScheme.primary
                : Theme.of(context).colorScheme.tertiary,
            size: smallSize + 10,
          ),
        ),
        BottomNavigationBarItem(
          label: '',
          icon: Container(
            width: largeSize,
            height: largeSize,
            decoration: BoxDecoration(
              color: currentIndex == 2
                  ? Theme.of(context).colorScheme.primary
                  : Theme.of(context).colorScheme.tertiary.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              CupertinoIcons.add,
              color: currentIndex == 2
                  ? Theme.of(context).colorScheme.onSurface
                  : Theme.of(context).colorScheme.tertiary,
              size: smallSize + 10,
            ),
          ),
        ),
        BottomNavigationBarItem(
          label: '',
          icon: Icon(
            CupertinoIcons.square_favorites,
            color: currentIndex == 3
                ? Theme.of(context).colorScheme.primary
                : Theme.of(context).colorScheme.tertiary,
            size: smallSize + 10,
          ),
        ),
        BottomNavigationBarItem(
          label: '',
          icon: Icon(
            CupertinoIcons.chart_bar_square,
            color: currentIndex == 4
                ? Theme.of(context).colorScheme.primary
                : Theme.of(context).colorScheme.tertiary,
            size: smallSize + 10,
          ),
        ),
      ],
    );
  }
}
