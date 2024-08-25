import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class TranslateTo extends StatefulWidget {
  final String translateText;
  const TranslateTo({super.key, required this.translateText});

  @override
  State<TranslateTo> createState() => _TranslateToState();
}

class _TranslateToState extends State<TranslateTo> {
  void _copyToClipBoard(String text) {
    Clipboard.setData(ClipboardData(text: text)).then((_) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Copied to clipboard")));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Text(
              widget.translateText.isEmpty
                  ? "Your results will show here"
                  : widget.translateText,
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: const Color(0xff000000),
              ),
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.only(
            top: 12,
          ),
          decoration: BoxDecoration(
            border: Border(
              top: BorderSide(
                color: const Color(0xff0063DB).withOpacity(0.8),
              ),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {
                  _copyToClipBoard(widget.translateText);
                },
                child: Icon(
                  Icons.copy_all_outlined,
                  color: const Color(0xff0063DB).withOpacity(0.8),
                ),
              ),
              Icon(
                Icons.volume_up_outlined,
                color: const Color(0xff0063DB).withOpacity(0.8),
              )
            ],
          ),
        )
      ],
    );
  }
}
