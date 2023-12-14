import 'package:flutter/material.dart';
import 'package:virtudine/components/loading.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:virtudine/item_show.dart';

Future fetchMenu(id) async {
  final ref = FirebaseDatabase.instance.ref();
  final snapshot = await ref.child('users/$id/menu').get();
  if (snapshot.exists) {
    debugPrint(snapshot.toString());
    return snapshot.value;
  } else {
    debugPrint('No data available.');
  }
}

class MenuItem extends StatefulWidget {
  final String id;
  const MenuItem({super.key, required this.id});

  @override
  State<MenuItem> createState() => _MenuItemState();
}

class _MenuItemState extends State<MenuItem> {
  List<MapEntry<Object?, Object?>> filteredMenu = [];
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchAndFilterMenu('');
  }

  void fetchAndFilterMenu(String query) async {
    final snapshot = await fetchMenu(widget.id);

    if (snapshot != null) {
      final Map<Object?, Object?> data = snapshot;

      setState(() {
        if (query.isEmpty) {
          filteredMenu = data.entries.toList();
        } else {
          filteredMenu = data.entries.where((entry) {
            String item = entry.key.toString().toLowerCase();
            return item.contains(query.toLowerCase());
          }).toList();
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: fetchMenu(widget.id),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Scaffold(
              backgroundColor: const Color(0xFFFF8600),
              appBar: AppBar(
                title: Text(
                  'Menu',
                  style: GoogleFonts.poppins(
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 2.0,
                      color: Colors.white),
                ),
                backgroundColor: Colors.black,
                iconTheme: const IconThemeData(color: Colors.white),
              ),
              body: SafeArea(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 20,
                      width: double.infinity,
                    ),
                    Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          controller: searchController,
                          onChanged: (value) {
                            fetchAndFilterMenu(value);
                          },
                          cursorColor: Colors.black,
                          style: GoogleFonts.poppins(
                              // Set the text style for the typed text
                              fontSize: 20.0, // Adjust the font size as needed
                              color: Colors.black,
                              fontWeight: FontWeight.w700),
                          decoration: InputDecoration(
                            hintText: 'Search Item here',
                            prefixIcon: const Icon(
                              Icons.search,
                              color: Colors.black,
                            ),
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                color: Colors.black,
                                width: 2.0,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: const BorderSide(
                                color: Colors.black,
                                width: 2.0,
                              ), // Set the focused border color to black
                            ),
                            // Customize the border color when not focused (enabled)
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: const BorderSide(
                                color: Colors.black,
                                width: 2.0,
                              ), // Set the enabled border color to black
                            ),

                            hintStyle: GoogleFonts.poppins(
                              color: Colors.black,
                              fontSize: 22.0, // Increase font size
                            ),
                          ),
                        ),
                      ),
                    ),
                    if (filteredMenu.isEmpty)
                      Expanded(
                        child: Center(
                          child: Text(
                            'No matching items.',
                            style: GoogleFonts.poppins(
                              fontSize: 22,
                              fontWeight: FontWeight.w800,
                              letterSpacing: 2.0,
                            ),
                          ),
                        ),
                      )
                    else
                      Expanded(
                        child: ListView.builder(
                          itemCount: filteredMenu.length,
                          itemBuilder: (context, index) {
                            String item = filteredMenu[index].key.toString();
                            String ingredients = (filteredMenu[index].value
                                    as Map)['ingredients']
                                .toString();
                            String downloadURL = (filteredMenu[index].value
                                    as Map)['downloadURL']
                                .toString();
                            String showURL =
                                (filteredMenu[index].value as Map)['showURL']
                                    .toString();

                            return MenuList(
                              item: item,
                              ingredients: ingredients,
                              downloadURL: downloadURL,
                              showURL: showURL,
                            );
                          },
                        ),
                      ),
                  ],
                ),
              ),
            );
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return const Loading();
          } else {
            return Scaffold(
              appBar: AppBar(
                title: Text(
                  'Menu',
                  style: GoogleFonts.poppins(
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 2.0,
                  ),
                ),
                backgroundColor: Colors.black,
              ),
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
  final String showURL;

  const MenuList({
    super.key,
    required this.item,
    required this.ingredients,
    required this.downloadURL,
    required this.showURL,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ItemShow(
                item: item,
                ingredients: ingredients,
                url: downloadURL,
                showURL: showURL,
              ),
            ),
          );
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
