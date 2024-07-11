import 'package:flutter/material.dart';
import 'package:gamerconnect/pages/contact_page.dart';
import 'package:gamerconnect/pages/messages_page.dart';
import 'package:gamerconnect/pages/teams_page.dart';
import 'package:gamerconnect/themes/theme.dart';
import 'package:gamerconnect/views/profile_view.dart';
import 'package:gamerconnect/widgets/widgets.dart';

class HomeView extends StatelessWidget {
  static Route get route => MaterialPageRoute(
        builder: (context) => HomeView(),
      );
  HomeView({Key? key}) : super(key: key);

  final ValueNotifier<int> selectedIndex = ValueNotifier(0);
  final ValueNotifier<String> selectedTitle = ValueNotifier('Messages');

  final pages = const [
    MessagesPage(),
    TeamsPage(),
    ProfileView(),
    ContactPage(),
  ];

  final pageTitles = const ['Messages', 'Teams', 'Profile', 'Contacts'];

  void _onNavigationItemSelected(index) {
    selectedTitle.value = pageTitles[index];
    selectedIndex.value = index;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: ValueListenableBuilder(
          valueListenable: selectedTitle,
          builder: (BuildContext context, String value, _) => Text(value),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: IconBackground(
              icon: Icons.search,
              onTap: () {
                showDialog(
                  context: context, 
                  builder: (BuildContext context) => const Dialog(
                    child: AspectRatio(
                      aspectRatio: 4 / 7,
                      child: ContactPage(),
                    ),
                  ),
                );
              }
            ),
          ),
        ],
      ),
      body: ValueListenableBuilder(
        valueListenable: selectedIndex,
        builder: (BuildContext context, int value, _) {
          return pages[value];
        },
      ),
      bottomNavigationBar: _BottomNavigationBar(
        onItemSelected: _onNavigationItemSelected,
      ),
    );
  }
}

class _BottomNavigationBar extends StatefulWidget {
  const _BottomNavigationBar({
    Key? key,
    required this.onItemSelected,
  }) : super(key: key);

  final ValueChanged<int> onItemSelected;

  @override
  State<_BottomNavigationBar> createState() => _BottomNavigationBarState();
}

class _BottomNavigationBarState extends State<_BottomNavigationBar> {
  var selectedIndex = 0;

  void handleSelectedItems(int index) {
    setState(() {
      selectedIndex = index;
      widget.onItemSelected(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(0),
      elevation: 0,
      child: SafeArea(
        top: false,
        bottom: true,
        child: Padding(
          padding: const EdgeInsets.only(top: 16, left: 8, right: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _NavigationBarItem(
                index: 0,
                lable: 'Messages',
                icon: Icons.message_rounded,
                isSelected: (selectedIndex == 0),
                onTap: handleSelectedItems,
              ),
              _NavigationBarItem(
                index: 1,
                lable: 'Teams',
                icon: Icons.groups_2_rounded,
                isSelected: (selectedIndex == 1),
                onTap: handleSelectedItems,
              ),
              _NavigationBarItem(
                index: 2,
                lable: 'Profile',
                icon: Icons.person_rounded,
                isSelected: (selectedIndex == 2),
                onTap: (handleSelectedItems),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NavigationBarItem extends StatelessWidget {
  const _NavigationBarItem({
    Key? key,
    required this.index,
    required this.lable,
    required this.icon,
    this.isSelected = false,
    required this.onTap,
  }) : super(key: key);

  final int index;
  final String lable;
  final IconData icon;
  final bool isSelected;
  final ValueChanged<int> onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          onTap(index);
        },
        child: SizedBox(
            height: 60,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  icon,
                  size: 30,
                  color: isSelected ? AppColors.primaryDark : null,
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  lable,
                  style: isSelected ? const TextStyle(fontSize: 11, color: AppColors.primaryDark) : const TextStyle(fontSize: 11),
                ),
              ],
            )
          )
        );
  }
}
