import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({Key? key, required this.onClickNavBarItem})
      : super(key: key);

  final Function onClickNavBarItem;

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  final primaryColor = const Color(0xff4338CA);

  final secondaryColor = const Color(0xff6D28D9);

  final accentColor = const Color(0xffffffff);

  final backgroundColor = const Color(0xffffffff);

  final errorColor = const Color(0xffEF4444);

  RxInt _selectedIndex = 0.obs;

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: Colors.white,
      elevation: 10,
      child: Container(
        height: 56,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: const EdgeInsets.only(left: 25.0, right: 25.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconBottomBar(
                  icon: Icons.home,
                  selected: _selectedIndex.value == 0,
                  onPressed: () {
                    setState(() {
                      _selectedIndex.value = 0;
                      widget.onClickNavBarItem(0);
                    });
                  }),
              IconBottomBar(
                  icon: Icons.receipt,
                  selected: _selectedIndex.value == 1,
                  onPressed: () {
                    setState(() {
                      _selectedIndex.value = 1;
                      widget.onClickNavBarItem(1);
                    });
                  }),
              IconBottomBar(
                  icon: Icons.settings,
                  selected: _selectedIndex.value == 2,
                  onPressed: () {
                    setState(() {
                      _selectedIndex.value = 2;
                      widget.onClickNavBarItem(2);
                    });
                  })
            ],
          ),
        ),
      ),
    );
  }
}

class IconBottomBar extends StatelessWidget {
  const IconBottomBar(
      {Key? key,
      required this.icon,
      required this.selected,
      required this.onPressed})
      : super(key: key);
  final IconData icon;
  final bool selected;
  final Function() onPressed;

  final primaryColor = const Color(0xff4338CA);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          onPressed: onPressed,
          icon: Icon(
            icon,
            size: 25,
            color: selected ? primaryColor : Colors.black54,
          ),
        ),
      ],
    );
  }
}
