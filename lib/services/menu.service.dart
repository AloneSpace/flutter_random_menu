import 'package:flutter_random_menu/models/menu.model.dart';
import 'package:hive/hive.dart';

class MenuService {
  static Future<List<Menu>> getMenu() async {
    try {
      List<Menu> menuList = [];
      var menuBox = await Hive.openBox('menuBox');
      if (menuBox.get('menuList') == null) {
        menuBox.put('menuList', []);
      }
      for (var menu in menuBox.get('menuList')) {
        menuList.add(Menu(menuName: menu["menuName"]));
      }
      return menuList;
    } catch (e) {
      return [];
    }
  }
}
