import 'package:flutter/material.dart';

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
      emojiGrid[one][two],
      style: const TextStyle(fontSize: 35),
    ));
  }
}
