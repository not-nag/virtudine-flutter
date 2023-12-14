import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class LoadingScreenEmoji extends StatelessWidget {
  final int one;
  final int two;
  final List<List<String>> emojiGrid = [
    ['🍔', '🥤', '🍪', '🍦', '🍕'],
    ['🍕', '🧁', '🍭', '🍩', '🌮'],
    ['🌮', '🍔', '🥤', '🍪', '🍦'],
    ['🍦', '🍕', '🧁', '🍭', '🍩'],
    ['🍩', '🌮', '🍔', '🥤', '🍪'],
    ['🍪', '🍦', '🍕', '🧁', '🍭'],
    ['🍭', '🍩', '🌮', '🍦', '🥤']
  ];

  LoadingScreenEmoji({Key? key, required this.one, required this.two})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Text(
      emojiGrid[one][two].toString(),
      style: const TextStyle(fontSize: 35),
    ));
  }
}

class Emojis extends StatelessWidget {
  const Emojis({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: List.generate(7, (rowIndex) {
            return Expanded(
              child: Row(
                children: List.generate(
                  5,
                  (colIndex) {
                    return Expanded(
                        child:
                            LoadingScreenEmoji(one: rowIndex, two: colIndex));
                  },
                ),
              ),
            );
          }),
        ),
        Center(
          child: Container(
            width: 300,
            height: 300,
            decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color.fromARGB(255, 239, 236, 236),
                boxShadow: [
                  BoxShadow(
                    color: Color.fromARGB(53, 0, 0, 0),
                    offset: Offset(0, 0),
                    blurRadius: 20,
                    spreadRadius: 3,
                  ),
                ]),
            child: Stack(
              children: [
                Center(
                  child: Text(
                    'VirtuDine',
                    style: GoogleFonts.poppins(
                      fontSize: 45,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 2.0,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 90),
                  child: Center(
                    child: Text(
                      'Loading Magic 🔮'.toString(),
                      style: GoogleFonts.poppins(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 1.0,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 120),
          child: Center(
              child:
                  Lottie.asset('assets/loading.json', width: 200, height: 200)),
        )
      ],
    );
  }
}
