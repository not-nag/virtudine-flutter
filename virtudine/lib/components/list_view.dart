import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:virtudine/menu_item.dart';

class Restaurants extends StatelessWidget {
  final String name;
  final String userId;

  const Restaurants({super.key, required this.name, required this.userId});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: InkWell(
        onTap: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => MenuItem(id: userId)));
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: const Color.fromARGB(255, 255, 255, 255),
            border: Border.all(
                color: const Color.fromARGB(255, 0, 0, 0), width: 2.0),
            boxShadow: const [
              BoxShadow(
                  color: Color.fromARGB(255, 0, 0, 0),
                  blurRadius: 5,
                  offset: Offset(0, 3))
            ],
          ),
          width: double.infinity,
          height: 80,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(
                  Icons.restaurant_rounded,
                  size: 30,
                  color: Colors.black,
                ),
              ),
              TruncatedTextWidget(text: name),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(Icons.arrow_forward_ios),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class TruncatedTextWidget extends StatelessWidget {
  final String text;
  static const int maxCharacters = 20;

  const TruncatedTextWidget({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    String truncatedText = text.length > maxCharacters
        ? "${text.substring(0, maxCharacters)}..."
        : text;

    return Text(
      truncatedText,
      style: GoogleFonts.poppins(
        fontSize: 25,
        fontWeight: FontWeight.w700,
        letterSpacing: 1.0,
      ),
      overflow: TextOverflow.ellipsis,
      maxLines: 1,
    );
  }
}
