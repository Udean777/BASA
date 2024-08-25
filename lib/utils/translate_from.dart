import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TranslateFrom extends StatefulWidget {
  final TextEditingController controller;
  const TranslateFrom({super.key, required this.controller});

  @override
  State<TranslateFrom> createState() => _TranslateFromState();
}

class _TranslateFromState extends State<TranslateFrom> {
  int _wordCount = 0;
  final int _wordLimit = 50;

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_updateCount);
  }

  void _updateCount() {
    final text = widget.controller.text;

    setState(() {
      _wordCount = _countWord(text);
      if (_wordCount > _wordLimit) {
        widget.controller.value = widget.controller.value.copyWith(
          text: _truncateTextToWordLimit(text, _wordLimit),
          selection: TextSelection.fromPosition(
            TextPosition(
              offset: widget.controller.text.length,
            ),
          ),
        );
        _wordCount = _wordLimit;
      }
    });
  }

  int _countWord(String text) {
    if (text.isEmpty) {
      return 0;
    }

    final words = text.trim().split(RegExp(r'\s+'));

    return words.length;
  }

  String _truncateTextToWordLimit(String text, int wordLimit) {
    final words = text.trim().split(RegExp(r'\s+'));

    if (words.length <= wordLimit) {
      return text;
    }

    return words.take(wordLimit).join(" ");
  }

  @override
  void dispose() {
    widget.controller.removeListener(_updateCount);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: TextFormField(
            controller: widget.controller,
            maxLines: null,
            expands: true,
            decoration: InputDecoration(
              hintText: "What's word you want to translate?",
              hintStyle: GoogleFonts.poppins(
                fontSize: 20,
                color: const Color(0xff0063DB).withOpacity(0.2),
              ),
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              labelStyle: GoogleFonts.poppins(
                color: const Color(0xff000000),
                fontSize: 16,
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
              Text(
                "$_wordCount/$_wordLimit words",
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  color: const Color(0xff000000),
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
