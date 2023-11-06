import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';
import 'package:virtudine/components/loading.dart' as LoadingIndicator;

class ItemShow extends StatelessWidget {
  final String item;
  final String ingredients;
  final String url;
  final String showURL;

  const ItemShow(
      {Key? key,
      required this.item,
      required this.ingredients,
      required this.url,
      required this.showURL})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFF8600),
      appBar: AppBar(
        title: Text(
          'Item view',
          style: GoogleFonts.poppins(
            fontSize: 22,
            fontWeight: FontWeight.w600,
            letterSpacing: 2.0,
          ),
        ),
        backgroundColor: Colors.black,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
                border: Border.all(
                    color: const Color.fromARGB(255, 0, 0, 0), width: 2.0),
                boxShadow: const [
                  BoxShadow(
                      color: Color.fromARGB(255, 0, 0, 0),
                      blurRadius: 5,
                      offset: Offset(0, 3))
                ],
              ),
              margin: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10.0),
                    width: double.infinity,
                    height: 350,
                    child: Image.network(
                      showURL,
                      loadingBuilder: (BuildContext context, Widget child,
                          ImageChunkEvent? loadingProgress) {
                        if (loadingProgress == null) {
                          return child;
                        }
                        return const Center(child: LoadingIndicator.Loading());
                      },
                    ),
                  ),
                  SizedBox(
                    height: 70,
                    child: ModelViewer(
                      backgroundColor: Colors.black,
                      src: url,
                      alt: item,
                      ar: true,
                      arModes: const ['scene-viewer', 'webxr', 'quick-look'],
                      autoRotate: true,
                      iosSrc: url,
                      disableZoom: true,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.all(16.0),
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
                            fontSize: 30,
                            fontWeight: FontWeight.w800,
                            letterSpacing: 2.0,
                            color: Colors.black),
                      ),
                      Text(
                        'Ingredients: $ingredients',
                        style: GoogleFonts.poppins(
                          fontSize: 15,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 2.0,
                          color: Colors.black,
                        ),
                      ),
                    ],
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
