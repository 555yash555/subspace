import 'package:digital_health_stratup_assignment/views/cartdisplay.dart';
import 'package:digital_health_stratup_assignment/views/checkout.dart';
import 'package:digital_health_stratup_assignment/views/productdisplay.dart';
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
    return [const MyHomePage(), const CartPage(), const CheckoutPage()];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
          icon: const Icon(Icons.home),
          title: 'Home',
          activeColorPrimary: Colors.teal.shade900,
          inactiveColorPrimary: Colors.teal),
      PersistentBottomNavBarItem(
          icon: const Icon(
            Icons.shopping_cart,
          ),
          title: 'cart',
          activeColorPrimary: Colors.teal.shade900,
          inactiveColorPrimary: Colors.teal),
      PersistentBottomNavBarItem(
          icon: const Icon(
            Icons.local_shipping,
          ),
          title: 'checkout',
          activeColorPrimary: Colors.teal.shade900,
          inactiveColorPrimary: Colors.teal),
    ];
  }
}
