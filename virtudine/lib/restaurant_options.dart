import 'package:flutter/material.dart';

class RestaurantOptions extends StatelessWidget {
  final Map<dynamic, dynamic> data;

  const RestaurantOptions({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    debugPrint(data.toString());
    return const Scaffold(
      body: SafeArea(
        child: Text('I am cafe'),
      ),
    );
  }
}
