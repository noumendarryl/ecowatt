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
      currentIndex: currentIndex,
      onTap: onTap,
      type: BottomNavigationBarType.fixed,
      items: [
        BottomNavigationBarItem(
          label: '',
          icon: Icon(
            CupertinoIcons.home,
            color: currentIndex == 0 ? Theme.of(context).colorScheme.primary : Theme.of(context).colorScheme.tertiary,
          ),
        ),
        BottomNavigationBarItem(
          label: '',
          icon: Icon(
            CupertinoIcons.search,
            color: currentIndex == 1 ? Theme.of(context).colorScheme.primary : Theme.of(context).colorScheme.tertiary,
          ),
        ),
        BottomNavigationBarItem(
          label: '',
          icon: Icon(
            CupertinoIcons.add_circled,
            color: currentIndex == 2 ? Theme.of(context).colorScheme.primary : Theme.of(context).colorScheme.tertiary,
          ),
        ),
        BottomNavigationBarItem(
          label: '',
          icon: Icon(
            CupertinoIcons.star,
            color: currentIndex == 3 ? Theme.of(context).colorScheme.primary : Theme.of(context).colorScheme.tertiary,
          ),
        ),
        BottomNavigationBarItem(
          label: '',
          icon: Icon(
            CupertinoIcons.graph_square,
            color: currentIndex == 4 ? Theme.of(context).colorScheme.primary : Theme.of(context).colorScheme.tertiary,
          ),
        ),
      ],
    );
  }
}
