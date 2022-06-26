import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_random_menu/components/GradientButton.dart';
import 'package:flutter_random_menu/components/MyCard.dart';
import 'package:flutter_random_menu/components/RoundedInput.dart';
import 'package:flutter_random_menu/models/menu.model.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hive/hive.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({Key? key}) : super(key: key);

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  TextEditingController menuNameController = TextEditingController();

  List<Menu> menuList = [];

  bool isLoading = true;

  @override
  void initState() {
    super.initState();
  }

  Future<void> openEditMenu(Menu? menu) async {
    menuNameController.text = '';
    if (menu != null) {
      menuNameController.text = menu.menuName;
    }
    Size size = MediaQuery.of(context).size;
    bool onSubmit = false;
    Future<String> bottomSheetCallback = await showModalBottomSheet(
        backgroundColor: Colors.transparent,
        context: context,
        builder: (context) {
          return StatefulBuilder(
              builder: (BuildContext bottomContext, StateSetter mystate) {
            return SingleChildScrollView(
              child: Stack(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 10),
                    padding: EdgeInsets.all(30),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      ),
                    ),
                    height: MediaQuery.of(context).size.height / 3 +
                        MediaQuery.of(context).viewInsets.bottom,
                    child: Wrap(
                      children: <Widget>[
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                child: Text(
                                  "ชื่อเมนู",
                                ),
                                padding:
                                    EdgeInsets.only(bottom: size.height * 0.02),
                              ),
                            ]),
                        RoundedInput(
                            textController: menuNameController,
                            hintText: 'ชื่อเมนูอาหาร',
                            icon: Icons.food_bank_outlined,
                            onChanged: (value) => {}),
                        Container(
                          margin: EdgeInsets.only(top: size.height * 0.04),
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Container(
                                color: Colors.green,
                                height: size.height * 0.08,
                                width: size.width * 0.9,
                                child: TextButton(
                                  onPressed: () async {
                                    onSubmit = true;
                                    Navigator.pop(context);
                                  },
                                  child: Text(
                                    "บันทึก",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              )),
                        )
                      ],
                    ),
                  ),
                  Positioned(
                    top: 0,
                    right: 10,
                    child: InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: Container(
                          color: Colors.white,
                          width: 32,
                          height: 32,
                          child: Icon(Icons.close, color: Colors.red[700]),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          });
        });
    if (onSubmit) {
      setState(() {
        if (menu == null) {
          menu = Menu(
            menuName: menuNameController.text,
          );
          menuList.add(menu!);
        } else {
          menu!.menuName = menuNameController.text;
        }
        Hive.box('menuBox')
            .put('menuList', menuList.map((e) => e.toJson()).toList());
      });
    }
  }

  Future<bool> getMenu() async {
    try {
      isLoading = true;
      menuList = [];
      var menuBox = await Hive.openBox('menuBox');
      await Future.delayed(Duration(seconds: 2));
      if (menuBox.get('menuList') == null) {
        menuBox.put('menuList', []);
      }
      for (var menu in menuBox.get('menuList')) {
        menuList.add(Menu(menuName: menu["menuName"]));
      }
      isLoading = false;
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.all(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'เมนูอาหาร',
                style: TextStyle(color: Colors.black, fontSize: 24),
              ),
              Spacer(),
              GradientButton(
                text: 'เพิ่มเมนู',
                onPressed: () {
                  openEditMenu(null);
                },
                width: 20,
                height: 12,
              )
            ],
          ),
        ),
        SizedBox(
          height: size.height * 0.05,
        ),
        FutureBuilder(
          future: getMenu(),
          builder: (context, snapshot) {
            if (isLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return menuList.isEmpty
                ? Expanded(
                    child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Center(
                        child: SvgPicture.asset(
                            'assets/vectors/Empty-amico.svg',
                            height: size.height * 0.35),
                      ),
                      Text('ไม่มีข้อมูลเมนูอาหาร',
                          style: TextStyle(fontSize: 18)),
                    ],
                  ))
                : Expanded(
                    child: GridView.count(
                        crossAxisCount: 2,
                        crossAxisSpacing: 8,
                        padding: EdgeInsets.all(16),
                        children: [
                          for (Menu menu in menuList)
                            MyCard(
                                text: menu.menuName,
                                imageUrl:
                                    'https://firebasestorage.googleapis.com/v0/b/flutterbricks-public.appspot.com/o/illustrations%2Fundraw_Working_late_re_0c3y%201.png?alt=media&token=7b880917-2390-4043-88e5-5d58a9d70555',
                                onRemovePressed: () {},
                                onEditPressed: () {
                                  openEditMenu(menu);
                                })
                        ]),
                  );
          },
        )
      ],
    );
  }
}
