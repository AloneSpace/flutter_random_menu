import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class MyCard extends StatelessWidget {
  final String text;
  final String imageUrl;
  final Function() onEditPressed;
  final Function() onRemovePressed;

  const MyCard(
      {required this.text,
      required this.imageUrl,
      required this.onRemovePressed,
      required this.onEditPressed,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      height: 150,
      padding: const EdgeInsets.all(15.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.5),
        boxShadow: [
          BoxShadow(
              offset: const Offset(10, 20),
              blurRadius: 10,
              spreadRadius: 0,
              color: Colors.grey.withOpacity(.05)),
        ],
      ),
      child: Column(
        children: [
          Image.network(imageUrl, height: 59, fit: BoxFit.cover),
          const Spacer(),
          AutoSizeText(text,
              textAlign: TextAlign.center,
              maxFontSize: 18,
              minFontSize: 12,
              maxLines: 1,
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              )),
          const SizedBox(
            height: 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                  onTap: onEditPressed,
                  child: Icon(Icons.edit, color: Colors.orange, size: 24)),
              InkWell(
                  onTap: onRemovePressed,
                  child: Icon(Icons.delete, color: Colors.red[500]!, size: 24)),
            ],
          ),
          // Text(
          //   subtitle,
          //   textAlign: TextAlign.center,
          //   style: const TextStyle(
          //       color: Colors.grey,
          //       fontWeight: FontWeight.normal,
          //       fontSize: 12),
          // ),
        ],
      ),
    );
  }
}
