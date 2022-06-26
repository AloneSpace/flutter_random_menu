import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_random_menu/components/BottomNav.dart';
import 'package:flutter_random_menu/screens/home/home_page.dart';
import 'package:flutter_random_menu/screens/menu/menu_page.dart';
import 'package:get/state_manager.dart';

class MainScreenPage extends StatefulWidget {
  const MainScreenPage({Key? key}) : super(key: key);

  @override
  State<MainScreenPage> createState() => _MainScreenPageState();
}

class _MainScreenPageState extends State<MainScreenPage> {
  RxInt _selectedIndex = 0.obs;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // SizedBox(
            //   height: size.height * 0.2,
            // ),
            Expanded(
              child: Obx(
                () => IndexedStack(
                  index: _selectedIndex.toInt(),
                  children: const [
                    HomePage(),
                    MenuPage(),
                    HomePage(),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
      backgroundColor: Colors.grey[300],
      bottomNavigationBar: BottomNavBar(
        onClickNavBarItem: (index) => _selectedIndex.value = index,
      ),
    );
  }
}
