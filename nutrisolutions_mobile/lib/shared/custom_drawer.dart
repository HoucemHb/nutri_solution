import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:nutrisolutions_mobile/core/theme/app_colors.dart';

import '../data/providers/drawer_provider.dart';

class CustomDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: 210,
      child: Container(
        color: const Color(0xFF6D3A00),
        child: Column(
          children: [
            const SizedBox(height: 50),
            Image.asset('assets/images/nutri-logo.png', height: 150),
            const SizedBox(height: 15),
            Expanded(
              child: ListView(
                children: [
                  _DrawerItem(icon: Icons.home, title: 'Accueil', route: '/'),
                  _DrawerItem(
                      icon: Icons.person, title: 'Profil', route: '/profile/1'),
                  _DrawerItem(
                      icon: Icons.menu_book,
                      title: 'Recettes',
                      route: '/recipes'),
                  _DrawerItem(
                      icon: Icons.group,
                      title: 'Nutritionnistes',
                      route: '/nutritionists'),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              child: ElevatedButton(
                onPressed: () {
                  context.go('/login');
                },
                child: const Text("Logout"),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _DrawerItem extends ConsumerStatefulWidget {
  final IconData icon;
  final String title;
  final String route;

  const _DrawerItem({
    super.key,
    required this.icon,
    required this.title,
    required this.route,
  });

  @override
  ConsumerState<_DrawerItem> createState() => _DrawerItemState();
}

class _DrawerItemState extends ConsumerState<_DrawerItem> {
  bool isSelected = false;
  double width = 0;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 20), () {
      setState(() {
        width = 51;
      });
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Update isSelected whenever the route changes
    isSelected = GoRouterState.of(context).uri.toString() == widget.route;
  }

  @override
  Widget build(BuildContext context) {
    final drawerState = ref.watch(drawerStateProvider);
    print("drawerstate: $drawerState");
    return Stack(
      alignment: Alignment.centerLeft,
      children: [
        AnimatedContainer(
          duration: const Duration(milliseconds: 700),
          curve: Curves.easeInOut,
          width: width,
          height: 51,
          decoration: BoxDecoration(
            gradient: isSelected
                ? LinearGradient(
                    colors: [
                      AppColors.lightOrange.withOpacity(0.3),
                      AppColors.lightOrange.withOpacity(0.08),
                    ],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  )
                : null,
          ),
        ),
        Container(
          height: 51,
          width: double.infinity,
          child: ListTile(
            leading: Icon(widget.icon, color: Colors.white),
            title: Text(
              widget.title,
              style: TextStyle(
                color: Colors.white,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
            onTap: () {
              context.go(widget.route);
              Scaffold.of(context).closeDrawer(); // Close the drawer
            },
          ),
        ),
      ],
    );
  }
}
