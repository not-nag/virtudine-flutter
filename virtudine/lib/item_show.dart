import 'package:flutter/material.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';
import 'package:google_fonts/google_fonts.dart';

class ItemShow extends StatelessWidget {
  final String item;
  final String ingredients;
  final String url;

  const ItemShow({
    Key? key,
    required this.item,
    required this.ingredients,
    required this.url,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFF8600),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ModelViewer(
                backgroundColor: const Color.fromARGB(0xFF, 0xEE, 0xEE, 0xEE),
                src: url,
                alt: item,
                ar: true,
                autoRotate: true,
                iosSrc: url,
                disableZoom: true,
              ),
            ),
            ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(2)),
              child: SizedBox(
                height: 150,
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item,
                          style: GoogleFonts.poppins(
                            fontSize: 40,
                            fontWeight: FontWeight.w800,
                            letterSpacing: 2.0,
                          ),
                        ),
                        Text(
                          'Ingredients: $ingredients',
                          style: GoogleFonts.poppins(
                            fontSize: 25,
                            fontWeight: FontWeight.w800,
                            letterSpacing: 2.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
