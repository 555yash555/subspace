import 'package:digital_health_stratup_assignment/views/favouritesdisplay.dart';
import 'package:digital_health_stratup_assignment/views/newsdisplay.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class PersistentNavbar extends StatelessWidget {
  const PersistentNavbar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = PersistentTabController(initialIndex: 0);

    return PersistentTabView(
      context,
      controller: controller,
      floatingActionButton: const SizedBox(),
      screens: _buildScreens(),
      items: _navBarsItems(),
      backgroundColor: Colors.grey.shade700,

      navBarStyle: NavBarStyle.style1, // Adjust the style as needed
      confineInSafeArea: true,
      handleAndroidBackButtonPress: true,
      resizeToAvoidBottomInset: true,
      stateManagement: true,
      hideNavigationBarWhenKeyboardShows: true,
      decoration: const NavBarDecoration(
          borderRadius: BorderRadius.only(
        topLeft: Radius.circular(15),
        topRight: Radius.circular(15),
      )),
    );
  }

  List<Widget> _buildScreens() {
    return [const MyHomePage(), const favouritesPage()];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
          icon: const Icon(Icons.newspaper),
          title: 'news',
          activeColorPrimary: Colors.white,
          inactiveColorPrimary: Colors.black26),
      PersistentBottomNavBarItem(
          icon: const Icon(
            Icons.favorite_outline,
          ),
          title: 'favourites',
          activeColorPrimary: Colors.white,
          inactiveColorPrimary: Colors.black26),
    ];
  }
}
