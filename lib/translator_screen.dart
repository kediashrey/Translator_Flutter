import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'signup_screen.dart';

class TranslatorScreen extends StatefulWidget {
  @override
  _TranslatorScreenState createState() => _TranslatorScreenState();
}

class _TranslatorScreenState extends State<TranslatorScreen> {
  final TextEditingController _controller = TextEditingController();
  String translatedText = '';
  bool isLoading = false;

  // Supported languages (ISO 639-1 codes)
  final List<Map<String, String>> languages = [
    {'code': 'en', 'label': 'English'},
    {'code': 'hi', 'label': 'Hindi'},
    {'code': 'es', 'label': 'Spanish'},
    {'code': 'fr', 'label': 'French'},
    {'code': 'de', 'label': 'German'},
    {'code': 'bn', 'label': 'Bengali'},
  ];

  String sourceLang = 'en';
  String targetLang = 'hi';

  Future<void> translateText(String input) async {
    setState(() {
      isLoading = true;
      translatedText = '';
    });

    final response = await http.post(
      Uri.parse('https://libretranslate.de/translate'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'q': input,
        'source': sourceLang,
        'target': targetLang,
        'format': 'text'
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        translatedText = data['translatedText'];
        isLoading = false;
      });
    } else {
      setState(() => isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Translation failed')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Translator"),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              // Add Firebase logout here if needed
              Navigator.pop(context);
            },
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(

          children: [
            // Language selection
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                DropdownButton<String>(
                  value: sourceLang,
                  onChanged: (value) {
                    setState(() => sourceLang = value!);
                  },
                  items: languages.map((lang) {
                    return DropdownMenuItem<String>(
                      value: lang['code'],
                      child: Text('From: ${lang['label']}'),
                    );
                  }).toList(),
                ),
                DropdownButton<String>(
                  value: targetLang,
                  onChanged: (value) {
                    setState(() => targetLang = value!);
                  },
                  items: languages.map((lang) {
                    return DropdownMenuItem<String>(
                      value: lang['code'],
                      child: Text('To: ${lang['label']}'),
                    );
                  }).toList(),
                ),
              ],
            ),
            SizedBox(height: 16),
            TextField(
              controller: _controller,
              maxLines: 4,
              decoration: InputDecoration(
                hintText: 'Enter text',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                if (_controller.text.trim().isNotEmpty) {
                  translateText(_controller.text.trim());
                }
              },
              child: Text("Translate"),
            ),
            SizedBox(height: 24),
            isLoading
                ? CircularProgressIndicator()
                : Text(
              translatedText,
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
