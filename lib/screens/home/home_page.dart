import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_random_menu/components/GradientButton.dart';
import 'package:flutter_random_menu/models/menu.model.dart';
import 'package:flutter_random_menu/services/menu.service.dart';
import 'package:get/route_manager.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Menu> menuList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  Future<bool> initMenuList() async {
    try {
      menuList = await MenuService.getMenu();
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<void> openRandomDialog() async {
    await initMenuList();
    if (menuList.isEmpty) {
      return AwesomeDialog(
              context: context,
              animType: AnimType.SCALE,
              dialogType: DialogType.ERROR,
              body: Center(
                child: Column(
                  children: const [
                    SizedBox(
                      height: 16,
                    ),
                    AutoSizeText('ไม่เจอเมนูอาหารเลย :(',
                        textAlign: TextAlign.center,
                        maxFontSize: 24,
                        minFontSize: 16,
                        maxLines: 2,
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        )),
                  ],
                ),
              ),
              btnOkOnPress: () {},
              btnOkText: 'เพิ่มเมนูอาหารกันเถอะ')
          .show();
    }
    int random = Random().nextInt(menuList.length);
    AwesomeDialog(
            context: context,
            animType: AnimType.SCALE,
            dialogType: DialogType.SUCCES,
            body: Center(
              child: Column(
                children: [
                  SizedBox(
                    height: 16,
                  ),
                  Image.network(
                      'https://cdn-icons-png.flaticon.com/512/2927/2927347.png',
                      height: 100,
                      fit: BoxFit.cover),
                  SizedBox(
                    height: 24,
                  ),
                  AutoSizeText(menuList[random].menuName,
                      textAlign: TextAlign.center,
                      maxFontSize: 24,
                      minFontSize: 16,
                      maxLines: 2,
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      )),
                ],
              ),
            ),
            btnOkOnPress: () {},
            btnOkText: 'ไปกินอาหารกันเถอะะ')
        .show();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return FutureBuilder(
      future: initMenuList(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // SizedBox(
            //   height: size.height * 0.2,
            // ),
            Center(
                child: GradientButton(
                    text: 'สุ่มเมนูอาหาร',
                    onPressed: () {
                      openRandomDialog();
                    }))
          ],
        );
      },
    );
  }

  gradient4() {
    return LinearGradient(colors: [Colors.blue, Colors.blue.shade900]);
  }
}
