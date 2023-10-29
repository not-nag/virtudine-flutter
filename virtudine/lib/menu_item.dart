import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:virtudine/components/loading.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:virtudine/item_show.dart';

Future fetchMenu(id) async {
  final ref = FirebaseDatabase.instance.ref();
  final snapshot = await ref.child('users/$id/menu').get();
  if (snapshot.exists) {
    return snapshot.value;
  } else {
    debugPrint('No data available.');
  }
}

class MenuItem extends StatelessWidget {
  final String id;
  const MenuItem({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: fetchMenu(id),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final Map<Object?, Object?> data = snapshot.data;
            return Scaffold(
              backgroundColor: const Color(0xFFFF8600),
              body: SafeArea(
                child: ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    String item = data.keys.elementAt(index).toString();
                    String ingredients = (data as Map<dynamic, dynamic>)[item]
                            ['ingredients']
                        .toString();
                    String downloadURL = (data as Map<dynamic, dynamic>)[item]
                            ['downloadURL']
                        .toString();

                    return MenuList(
                        item: item,
                        ingredients: ingredients,
                        downloadURL: downloadURL);
                  },
                ),
              ),
            );
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return const Loading();
          } else {
            return Scaffold(
              backgroundColor: const Color(0xFFFF8600),
              body: SafeArea(
                child: Center(
                  child: Text(
                    'No Menu available',
                    style: GoogleFonts.poppins(
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 2.0,
                    ),
                  ),
                ),
              ),
            );
          }
        });
  }
}

class MenuList extends StatelessWidget {
  final String item;
  final String ingredients;
  final String downloadURL;

  const MenuList(
      {super.key,
      required this.item,
      required this.ingredients,
      required this.downloadURL});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: InkWell(
        onTap: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const ItemShow()));
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
                  Icons.dining,
                  size: 30,
                  color: Colors.black,
                ),
              ),
              TruncatedTextWidget(text: item),
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
        ? text.substring(0, maxCharacters) + "..."
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
