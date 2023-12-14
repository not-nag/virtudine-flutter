import 'package:flutter/material.dart';
import 'package:virtudine/components/list_view.dart';
import 'package:google_fonts/google_fonts.dart';

class RestaurantOptions extends StatefulWidget {
  final Map<Object?, Object?> data;

  const RestaurantOptions({Key? key, required this.data}) : super(key: key);

  @override
  State<RestaurantOptions> createState() => _RestaurantOptionsState();
}

class _RestaurantOptionsState extends State<RestaurantOptions> {
  List<MapEntry<Object?, Object?>> filteredData = [];
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    filterData('');
  }

  void filterData(String query) {
    setState(() {
      filteredData = widget.data.entries.where((entry) {
        String name = entry.value.toString().toLowerCase();
        return name.contains(query.toLowerCase());
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFF8600),
      appBar: AppBar(
        title: Text(
          'Restaurants',
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
                    filterData(value);
                  },
                  cursorColor: Colors.black,
                  style: GoogleFonts.poppins(
                      // Set the text style for the typed text
                      fontSize: 20.0, // Adjust the font size as needed
                      color: Colors.black,
                      fontWeight: FontWeight.w700),
                  decoration: InputDecoration(
                    hintText: 'Search Restaurants here',
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
                      fontSize: 22.0,
                    ),
                  ),
                ),
              ),
            ),
            if (filteredData.isEmpty)
              Expanded(
                child: Center(
                  child: Text(
                    'No matching restaurants.',
                    style: GoogleFonts.poppins(
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 2.0,
                    ),
                  ),
                ),
              )
            else
              Expanded(
                child: ListView.builder(
                  itemCount: filteredData.length,
                  itemBuilder: (context, index) {
                    String userId = filteredData[index].key.toString();
                    String name = filteredData[index].value.toString();

                    return Restaurants(
                      name: name,
                      userId: userId,
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}
