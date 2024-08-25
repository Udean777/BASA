import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CountryRectangle extends StatefulWidget {
  const CountryRectangle({super.key});

  @override
  State<CountryRectangle> createState() => _CountryRectangleState();
}

class _CountryRectangleState extends State<CountryRectangle> {
  final Random random = Random();

  final List<Map<String, String>> countryData = [
    {'countryName': 'Indonesia', 'countryImage': 'assets/images/indonesia.png'},
    {'countryName': 'USA', 'countryImage': 'assets/images/usa.png'},
    {'countryName': 'Russia', 'countryImage': 'assets/images/russia.png'},
    {'countryName': 'Italy', 'countryImage': 'assets/images/italy.png'},
    {'countryName': 'Germany', 'countryImage': 'assets/images/germany.png'},
    {'countryName': 'France', 'countryImage': 'assets/images/france.png'},
    {'countryName': 'China', 'countryImage': 'assets/images/china.png'},
    {'countryName': 'England', 'countryImage': 'assets/images/britain.png'},
    {'countryName': 'Saudi', 'countryImage': 'assets/images/arabic.png'},
  ];

  String? selectedCountry;
  Color? backgroundColor;

  @override
  void initState() {
    super.initState();
    _randomize();
  }

  void _randomize() {
    setState(() {
      selectedCountry =
          countryData[random.nextInt(countryData.length)]["countryName"];
    });
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      child: GridView.builder(
        padding: const EdgeInsets.all(8.0),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 2.5,
          crossAxisSpacing: 8.0,
          mainAxisSpacing: 8.0,
        ),
        itemCount: countryData.length,
        itemBuilder: (context, index) {
          final country = countryData[index];

          return Card(
            elevation: 2.0,
            color: const Color(0xFFF9F9F9),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
              side: BorderSide(
                color: const Color(0xff0063DB).withOpacity(0.8),
                width: 0.4,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    country["countryImage"]!,
                    height: 20,
                    fit: BoxFit.cover,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      country["countryName"]!,
                      style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xff000000)),
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
      onRefresh: () async {
        _randomize();
      },
    );
  }
}
