import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../business_logic/cubit/phone_auth/phone_auth_cubit.dart';
import '../../constnats/my_colors.dart';
import '../../constnats/strings.dart';

class MyDrawer extends StatelessWidget {
  MyDrawer({Key? key}) : super(key: key);

  PhoneAuthCubit phoneAuthCubit = PhoneAuthCubit();

  Widget buildDrawerHeader(context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsetsDirectional.fromSTEB(70, 10, 70, 10),
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: Colors.blue[100],
          ),
          child: Image.asset(
            'assets/images/zamalek.jpg',
            fit: BoxFit.cover,
            height: 80,
          ),
        ),
        const Text(
          'Abdelrahman',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 5,
        ),
        BlocProvider(
          create: (context) => phoneAuthCubit,
          child: Text(
            '${phoneAuthCubit.getLoggedInUser().phoneNumber }',
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold) ,
          ),
        ),
      ],
    );
  }

  Widget buildDrawerListItem({required IconData leadingIcon,
    required String title,
    Widget? trailing,
    Function()? onTap,
    Color? color}) {
    return ListTile(
      leading: Icon(
        leadingIcon,
        color: color ?? MyColors.blue,
      ),
      title: Text(title),
      trailing: trailing ??= const Icon(
        Icons.arrow_right,
        color: MyColors.blue,
      ),
      onTap: onTap,
    );
  }

  Widget buildDrawerListItemsDivider() {
    return const Divider(
      height: 0,
      thickness: 1,
      indent: 18,
      endIndent: 24,
    );
  }

  void _launchURL(String url) async {
    await canLaunch(url) ? await launch(url) : throw 'could not launch url ';
  }

  Widget buildIcon(IconData icon, String url) {
    return InkWell(
      onTap: () => _launchURL(url),
      child: Icon(
        icon,
        color: MyColors.blue,
        size: 35,
      ),
    );
  }

  Widget buildSocialMediaIcons() {
    return Padding(
      padding: const EdgeInsetsDirectional.only(start: 16),
      child: Row(
        children: [
          buildIcon(FontAwesomeIcons.facebook, AutofillHints.addressCity),
          const SizedBox(width: 15),
          buildIcon(FontAwesomeIcons.telegram, AutofillHints.addressCity),
        ],
      ),
    );
  }

  Widget buildLogoutBlocProvider(BuildContext context) {
    return BlocProvider<PhoneAuthCubit>(
      create: (context) => phoneAuthCubit,
      child: buildDrawerListItem(
        leadingIcon: Icons.logout,
        title: 'Logout',
        onTap: () {
          phoneAuthCubit.logOut();
          Navigator.of(context).pushReplacementNamed(loginScreen);
        },
        color: Colors.red,
        trailing: const SizedBox(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          SizedBox(
            height: 280,
            child: DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue[100]),
              child: buildDrawerHeader(context),
            ),
          ),
          buildDrawerListItem(leadingIcon: Icons.person, title: 'My Profile'),
          buildDrawerListItemsDivider(),
          buildDrawerListItem(
              leadingIcon: Icons.history,
              title: 'Places History',
              onTap: () {}),
          buildDrawerListItemsDivider(),
          buildDrawerListItem(
              leadingIcon: Icons.settings, title: 'Settings', onTap: () {}),
          buildDrawerListItemsDivider(),
          buildDrawerListItem(
              leadingIcon: Icons.help, title: 'Help', onTap: () {}),
          buildDrawerListItemsDivider(),
          buildLogoutBlocProvider(context),
          const SizedBox(
            height: 140,
          ),
          ListTile(
            leading: Text(
              'Follow us',
              style: TextStyle(color: Colors.grey[600]),
            ),
          ),
          buildSocialMediaIcons(),
        ],
      ),
    );
  }
}
