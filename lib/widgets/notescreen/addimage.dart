import "package:flutter/material.dart";

class ImageTypeBox extends StatelessWidget {
  var color;
  var onTap;
  var icon;
  var text;

  ImageTypeBox({required this.onTap, required this.icon, required this.text, required this.color});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
          decoration: BoxDecoration(color: color, border: Border.all(color: Colors.black, width: 3)),
          child: InkWell(
              onTap: onTap,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [Icon(icon), Text(text, style: const TextStyle(fontWeight: FontWeight.w600))],
              ))),
    );
  }
}
