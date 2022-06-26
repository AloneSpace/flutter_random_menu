class Menu {
  String menuName;

  Menu({required this.menuName});

  factory Menu.fromJson(Map<String, dynamic> json) {
    print(json["menuName"]);
    return Menu(
      menuName: json['menuName'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'menuName': menuName,
    };
  }
}
