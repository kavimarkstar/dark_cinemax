import 'package:flutter/material.dart';

@override
Widget loginButtonbuild(
  BuildContext context,
  String icon,
  String text, {
  bool isdarks = false,
  Function()? onPressed,
}) {
  bool isdark = Theme.of(context).brightness == Brightness.dark;
  return SizedBox(
    width: double.infinity,
    height: MediaQuery.of(context).size.height * 0.06,
    child: ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.white,
        side: BorderSide(
          width: 1.5,
          color: isdark ? Colors.white : Colors.grey.withOpacity(0.3),
        ),
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        shadowColor: Colors.transparent,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.asset(
            icon,
            color: isdarks
                ? isdark
                      ? Colors.white
                      : Colors.black
                : null,
          ),

          Text(
            text,
            style: TextStyle(color: isdark ? Colors.white : Colors.black),
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(width: 10),
        ],
      ),
    ),
  );
}
