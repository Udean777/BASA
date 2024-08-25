// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:translate_app/utils/language_dropdown.dart';
import 'package:translate_app/utils/translate_from.dart';
import 'package:translate_app/utils/translate_to.dart';

class PromptScreen extends StatefulWidget {
  const PromptScreen({super.key});

  @override
  State<PromptScreen> createState() => _PromptScreenState();
}

class _PromptScreenState extends State<PromptScreen> {
  String? selectedCountryFrom;
  String? selectedCountryTo;
  TextEditingController _textController = TextEditingController();
  String _translatedText = "";
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    _textController = TextEditingController();
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  void _handleChangeLanguageFrom(String? newCountry) {
    setState(() {
      selectedCountryFrom = newCountry;
    });
  }

  void _handleChangeLanguageTo(String? newCountry) {
    setState(() {
      selectedCountryTo = newCountry;
    });
  }

  Future<void> _translateText() async {
    final apiKey = dotenv.env["GEMINI_API_KEY"];
    if (!mounted) return;

    if (apiKey == null) {
      print("No api key env");
      return;
    }

    final inputText = _textController.text;
    final fromLang = selectedCountryFrom;
    final toLang = selectedCountryTo;

    if (inputText.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill the translate from form!')),
      );
      return;
    }

    if (fromLang == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Please select the language you want to translate!')),
      );
      return;
    }

    if (toLang == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content:
                Text('Please select the language you want to translate to!')),
      );
      return;
    }

    setState(() {
      _loading = true;
    });

    try {
      final model = GenerativeModel(model: "gemini-1.5-flash", apiKey: apiKey);
      final content = [
        Content.text('Translate only "$inputText" from $fromLang to $toLang')
      ];
      final res = await model.generateContent(content);

      setState(() {
        _translatedText = res.text!;
      });

      // print(res.text);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Failed to translate texts"),
        ),
      );
    } finally {
      setState(() {
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffffffff),
      body: DecoratedBox(
        decoration: const BoxDecoration(
            image: DecorationImage(
          image: AssetImage("assets/images/worldmap.png"),
          fit: BoxFit.cover,
        )),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _buildHeader(),
                  const SizedBox(height: 40),
                  _buildLanguageSelector(),
                  const SizedBox(height: 20),
                  _buildTranslateFrom(),
                  const SizedBox(height: 20),
                  _buildTranslateTo(),
                  const SizedBox(height: 20),
                  _buildTranslationResult(),
                  const SizedBox(height: 40),
                  _buildTranslateButton(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: const Color(0xFF6d1b7b).withOpacity(0.3),
            width: 0.5,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Text Translation",
            style: GoogleFonts.poppins(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: const Color(0xff000000),
            ),
          ),
          const Icon(
            Icons.text_fields,
            color: Color(0xff000000),
            size: 28,
          )
        ],
      ),
    );
  }

  Widget _buildLanguageSelector() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: LanguageDropdown(onLanguageChange: _handleChangeLanguageFrom),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Icon(
            Icons.swap_horiz_rounded,
            color: const Color(0xff0063DB).withOpacity(0.5),
            size: 28,
          ),
        ),
        Expanded(
          child: LanguageDropdown(onLanguageChange: _handleChangeLanguageTo),
        ),
      ],
    );
  }

  Widget _buildTranslateFrom() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            style: GoogleFonts.poppins(height: 1.6),
            children: <TextSpan>[
              TextSpan(
                text: "Translate from ",
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xff000000),
                ),
              ),
              if (selectedCountryFrom != null)
                TextSpan(
                  text: selectedCountryFrom,
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xff0063DB),
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        Container(
          width: MediaQuery.of(context).size.width,
          height: 220,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: const Color(0xffffffff),
            border: Border.all(
              color: const Color(0xff0063DB).withOpacity(0.8),
            ),
          ),
          child: TranslateFrom(
            controller: _textController,
          ),
        ),
      ],
    );
  }

  Widget _buildTranslateTo() {
    return Align(
      alignment: Alignment.centerLeft,
      child: RichText(
        text: TextSpan(
          style: GoogleFonts.poppins(height: 1.6),
          children: <TextSpan>[
            TextSpan(
              text: "Translate to ",
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: const Color(0xff000000),
              ),
            ),
            if (selectedCountryTo != null)
              TextSpan(
                text: selectedCountryTo,
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xff0063DB),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildTranslationResult() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 220,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: const Color(0xffffffff),
        border: Border.all(
          color: const Color(0xff0063DB).withOpacity(0.8),
        ),
      ),
      child: _loading
          ? Center(
              child: Container(
                padding: const EdgeInsets.all(12),
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  color: const Color(0xff0063DB).withOpacity(0.8),
                  shape: BoxShape.circle,
                ),
                child: CircularProgressIndicator(
                  color: const Color(0xffffffff).withOpacity(0.8),
                ),
              ),
            )
          : TranslateTo(translateText: _translatedText),
    );
  }

  Widget _buildTranslateButton() {
    return ElevatedButton(
      onPressed: _translateText,
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xff0063DB).withOpacity(0.8),
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 40),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      child: Center(
        child: Text(
          'Translate',
          style: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
