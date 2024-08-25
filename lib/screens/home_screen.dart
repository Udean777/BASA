import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:translate_app/components/country_rectangle.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/worldmap.png"),
          fit: BoxFit.cover,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16.0, 80.0, 16.0, 0.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Expanded(
                child: Center(
              child: CountryRectangle(),
            )),
            Expanded(
              child: Column(
                children: [
                  _buildRichText(),
                  const SizedBox(height: 40.0),
                  _buildCircularButton(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRichText() {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        style: GoogleFonts.poppins(height: 1.6),
        children: <InlineSpan>[
          _buildTextSpan("Translate", FontWeight.bold, Colors.black, 32.0),
          _buildTextSpan(" Every \n", FontWeight.bold,
              const Color(0xFF0063DB).withOpacity(0.3), 32.0),
          _buildTextSpan(
              "Type of Word \n", FontWeight.bold, Colors.black, 32.0),
          const WidgetSpan(child: SizedBox(height: 35.0)),
          _buildTextSpan(
              "Help you communicate \n", FontWeight.w300, Colors.black, 14.0),
          _buildTextSpan(
              "in different languages", FontWeight.w300, Colors.black, 14.0),
        ],
      ),
    );
  }

  TextSpan _buildTextSpan(
      String text, FontWeight weight, Color color, double size) {
    return TextSpan(
      text: text,
      style: TextStyle(
        fontSize: size,
        fontWeight: weight,
        color: color,
      ),
    );
  }

  Widget _buildCircularButton() {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, "/prompt");
      },
      child: Container(
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: const Color(0xFF0063DB).withOpacity(0.3),
          shape: BoxShape.circle,
        ),
        child: Container(
          height: 50,
          width: 50,
          padding: const EdgeInsets.all(2.0),
          decoration: const BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
          ),
          child: Icon(
            Icons.arrow_forward,
            color: const Color(0xFF0063DB).withOpacity(0.3),
          ),
        ),
      ),
    );
  }
}
