import 'package:flutter/material.dart';
import 'package:virtudine/components/list_view.dart';

class RestaurantOptions extends StatelessWidget {
  final Map<Object?, Object?> data;

  const RestaurantOptions({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFF8600),
      body: SafeArea(
          child: ListView.builder(
        itemCount: data.length,
        itemBuilder: (context, index) {
          String userId = data.keys.elementAt(index).toString();
          String name = data[userId].toString();

          return Restaurants(
            name: name,
            userId: userId,
          );
        },
      )),
    );
  }
}
