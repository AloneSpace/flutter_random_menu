import 'package:flutter/material.dart';

class RoundedInput extends StatelessWidget {
  final TextEditingController textController;
  final String hintText;
  final IconData icon;
  final Function(String value) onChanged;

  const RoundedInput(
      {required this.textController,
      required this.hintText,
      this.icon = Icons.search,
      required this.onChanged,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
            offset: const Offset(12, 26),
            blurRadius: 50,
            spreadRadius: 0,
            color: Colors.grey.withOpacity(.1)),
      ]),
      child: TextField(
        controller: textController,
        onChanged: (value) {
          onChanged(value);
        },
        decoration: InputDecoration(
          prefixIcon: Icon(
            icon,
            color: Colors.grey[500]!,
          ),
          filled: true,
          fillColor: Colors.white,
          hintText: hintText,
          hintStyle:
              const TextStyle(color: Colors.grey, fontWeight: FontWeight.w300),
          contentPadding:
              EdgeInsets.symmetric(vertical: 12.0, horizontal: 12.0),
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(45.0)),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey[300]!, width: 1.0),
            borderRadius: BorderRadius.all(Radius.circular(45.0)),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey[400]!, width: 1.5),
            borderRadius: BorderRadius.all(Radius.circular(45.0)),
          ),
        ),
      ),
    );
  }
}
