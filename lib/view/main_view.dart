
import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:language/controller/auth_controller.dart';
import 'package:language/view/content_card_list_view.dart';
import 'package:logger/logger.dart';

class MainView extends StatefulWidget {
  @override
  _MainViewState createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  final Logger logger = Logger();

  final AuthController authController = AuthController.to;


  int _selectedIndex = 0;
  final List<Widget> _widgetOptions = [
    ContentCardList(),
    Placeholder(),
    Placeholder(),
    Placeholder(),
    Placeholder(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("app_title").tr(),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text("drawer_menu_sign_out").tr(),
              onTap: () {
                authController.handleSignOut();
              },
            )
          ],
        ),
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
              icon: _selectedIndex == 0? Icon(Icons.home_filled, color: Colors.black,): Icon(Icons.home_outlined, color: Colors.black),
              label: 'home'
          ),
          BottomNavigationBarItem(
              icon: _selectedIndex == 1? Icon(Icons.search, color: Colors.black,):  Icon(Icons.search_off, color: Colors.black,),
              label: 'search'
          ),
          BottomNavigationBarItem(
              icon: _selectedIndex == 4? Icon(Icons.person, color: Colors.black): Icon(Icons.person_outline, color: Colors.black,),
              label: 'profile'
          )
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.black,
        onTap: _onItemTapped,
        showSelectedLabels: false, //(1)
        showUnselectedLabels: false, //(1)
        type: BottomNavigationBarType.fixed, //(2)
      ),
    );
  }

}