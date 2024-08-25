import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LanguageDropdown extends StatefulWidget {
  final Function(String?) onLanguageChange;
  const LanguageDropdown({super.key, required this.onLanguageChange});

  @override
  State<LanguageDropdown> createState() => _LanguageDropdownState();
}

class _LanguageDropdownState extends State<LanguageDropdown> {
  final List<Map<String, String>> languageData = [
    {
      'countryLanguage': 'Indonesia',
      'countryImage': 'assets/images/indonesia.png'
    },
    {
      'countryLanguage': 'English - US',
      'countryImage': 'assets/images/usa.png'
    },
    {
      'countryLanguage': 'English - UK',
      'countryImage': 'assets/images/britain.png'
    },
    {'countryLanguage': 'Russian', 'countryImage': 'assets/images/russia.png'},
    {'countryLanguage': 'Italian', 'countryImage': 'assets/images/italy.png'},
    {'countryLanguage': 'German', 'countryImage': 'assets/images/germany.png'},
    {'countryLanguage': 'French', 'countryImage': 'assets/images/france.png'},
    {'countryLanguage': 'Spanish', 'countryImage': 'assets/images/spain.png'},
  ];

  String? selectedCountry;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
        border: Border.all(
          width: 1,
          color: const Color(0xff0063DB).withOpacity(0.8),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 2,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: selectedCountry,
          hint: Text(
            "Select Language",
            style: GoogleFonts.poppins(
              fontSize: 14,
              color: Colors.grey[600],
            ),
          ),
          icon: Icon(
            Icons.keyboard_arrow_down_rounded,
            color: const Color(0xff0063DB).withOpacity(0.8),
          ),
          isExpanded: true,
          dropdownColor: Colors.white,
          elevation: 3,
          style: GoogleFonts.poppins(
            fontSize: 14,
            color: Colors.black,
          ),
          items: languageData.map((country) {
            return DropdownMenuItem<String>(
              value: country["countryLanguage"],
              child: Row(
                children: [
                  ClipOval(
                    child: Image.asset(
                      country["countryImage"]!,
                      width: 24,
                      height: 24,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Flexible(
                    child: Text(
                      country["countryLanguage"]!,
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        color: selectedCountry == country["countryLanguage"]
                            ? const Color(0xff6d1b78)
                            : Colors.black87,
                        fontWeight:
                            selectedCountry == country["countryLanguage"]
                                ? FontWeight.w600
                                : FontWeight.normal,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
          onChanged: (newVal) {
            setState(() {
              selectedCountry = newVal;
            });
            widget.onLanguageChange(newVal!);
          },
        ),
      ),
    );
  }
}
