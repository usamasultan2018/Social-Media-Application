import 'package:flutter/material.dart';
import 'package:social_media_app/widgets/listtile.dart';

class MyDrawer extends StatelessWidget {
  final  void Function()? onProfileTap;
   final void Function()? onLogoutTap;
  const MyDrawer({Key? key,required this.onProfileTap,required this.onLogoutTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.grey.shade900,
      child: Column(
        children: [
          // header
          const DrawerHeader(
              child: Icon(
            Icons.person,
            color: Colors.white,
            size: 70,
          )),
          MyListTile(
            icon: Icons.home,
            title: 'H O M E',
            onTap: () =>Navigator.pop(context),
          ),
          MyListTile(
            icon: Icons.person,
            title: 'P R O F I L E',
            onTap: onProfileTap,
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.only(bottom: 20.0),
            child: MyListTile(icon: Icons.logout, title: 'L O G O U T', onTap: onLogoutTap),
          ),
          //home list tile
          // Profile list tile
        ],
      ),
    );
  }
}
