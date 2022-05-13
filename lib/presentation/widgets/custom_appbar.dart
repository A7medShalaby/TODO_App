import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

PreferredSizeWidget customAppBar() {
  return PreferredSize(
    preferredSize: const Size.fromHeight(55),
    child: AppBar(
      elevation: 1,
      backgroundColor: Colors.red,
      centerTitle: true,
      title: Text(
        "2-DO",
        style: GoogleFonts.quicksand(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 24,
        ),
      ),
    ),
  );
}
