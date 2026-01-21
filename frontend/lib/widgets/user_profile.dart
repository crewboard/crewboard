

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileIcon extends StatelessWidget {
  const ProfileIcon({super.key, this.image, this.name, this.color, required this.size, this.fontSize});
  final String? image;
  final String? name;
  final Color? color;
  final double size;
  final double? fontSize;
  @override
  Widget build(BuildContext context) {
    if (image == null) {
      return Container(
        width: size,
        height: size,
        decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(size)),
        child: Center(
          child: Text(name![0].toString().toUpperCase(),
              style: GoogleFonts.poppins(textStyle: TextStyle(color: Colors.white,fontSize: fontSize, fontWeight: FontWeight.w500))),
        ),
      );
    } else {
      return SizedBox(
        width: size,
        height: size,
        child: ClipRRect(
            borderRadius: BorderRadius.circular(size),
            // width: size,
            // height: size,
            // decoration: BoxDecoration(color: color, borderRadius: ),
            // child: Image.network(server.getAsssetUrl(image!))
            // child: Center(
            // child: Text(name![0].toString().toUpperCase(), style: GoogleFonts.poppins(textStyle: TextStyle(fontSize: fontSize, fontWeight: FontWeight.w500))),
            // ),
            ),
      );
    }
  }
}