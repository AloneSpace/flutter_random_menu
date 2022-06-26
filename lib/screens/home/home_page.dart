import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_random_menu/components/GradientButton.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void openAboutDialog() {
    AwesomeDialog(
      context: context,
      animType: AnimType.SCALE,
      dialogType: DialogType.SUCCES,
      body: Center(
        child: Text(
          'If the body is specified, then title and description will be ignored, this allows to 											further customize the dialogue.',
          style: TextStyle(fontStyle: FontStyle.italic),
        ),
      ),
      btnOkOnPress: () {},
    ).show();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
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
                  openAboutDialog();
                }))
      ],
    );
    // return Center(
    //   child: InkWell(
    //     onTap: () {
    //       print('เข้า');
    //     },
    //     child: Container(
    //       width: 128,
    //       height: 128,
    //       alignment: Alignment.center,
    //       decoration: BoxDecoration(
    //         gradient: gradient4(),
    //         borderRadius: BorderRadius.circular(60),
    //       ),
    //       child: Text(
    //         'สุ่มเมนู',
    //         style: TextStyle(color: Colors.white, fontSize: 32),
    //       ),
    //     ),
    //   ),
    // );
  }

  gradient4() {
    return LinearGradient(colors: [Colors.blue, Colors.blue.shade900]);
  }
}
