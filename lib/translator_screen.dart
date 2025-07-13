// Make sure your Internet is Connected
import 'dart:io';
import 'package:lottie/lottie.dart';
import 'package:untitled1/signup_screen.dart';
import 'history_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:translator/translator.dart';

class TranslatorScreen extends StatefulWidget {
  const TranslatorScreen({super.key});


  @override
  State<TranslatorScreen> createState() => _TranslatorAppState();
}

class _TranslatorAppState extends State<TranslatorScreen> {
  List<String> languages = [
    'English',
    'Hindi',
    'Arabic	',
    'German',
    'Russian',
    'Spanish',
    'Urdu',
    'Japanese	',
    'Italian'
  ];
  List<String> languagescode = [
    'en',
    'hi',
    'ar',
    'de',
    'ru',
    'es',
    'ur',
    'ja',
    'it'
  ];
  final translator = GoogleTranslator();
  List<Map<String, String>> _history = [];

  String from = 'en';
  String to = 'hi';
  String data = 'आप कैसे हैं?';
  String selectedvalue = 'English';
  String selectedvalue2 = 'Hindi';
  TextEditingController controller =
  TextEditingController(text: 'How are you?');
  final formkey = GlobalKey<FormState>();
  bool isloading = false;
  translate() async {
    try {
      if (formkey.currentState!.validate()) {
        await translator
            .translate(controller.text, from: from, to: to)
            .then((value) {
          data = value.text;
          _history.add({'original': controller.text, 'translated': value.text});

          isloading = false;
          setState(() {});
          // print(value);
        });
      }
    } on SocketException catch (_) {
      isloading = true;
      SnackBar mysnackbar = const SnackBar(
        content: Text('Internet not Connected'),
        backgroundColor: Colors.red,
        duration: Duration(seconds: 5),
      );
      ScaffoldMessenger.of(context).showSnackBar(mysnackbar);
      setState(() {});
    }
  }


  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }
  void logout() async {
    try {
      await FirebaseAuth.instance.signOut();

      if (!mounted) return;

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => SignUpScreen()), // replace this with your login screen
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Logout failed: $e")),
      );
    }
  }

  // @override
  // void initState() {
  //   super.initState();
  //   translate();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        actions: [
          // Row(
          //   children: [Text("Logout"),
          //     IconButton(
          //       icon: const Icon(Icons.logout, color: Colors.black),
          //       onPressed: () {
          //         Navigator.pop(context); // Go back to login/signup screen
          //       },
          //     ),
          //
          //   ],
          // ),
        ],
        automaticallyImplyLeading: true,
        flexibleSpace: Container(
            decoration: const BoxDecoration(color: Colors.white,

            )),
        title: const Text(
          '',
          style: TextStyle(
              color: Colors.blue, fontWeight: FontWeight.bold, fontSize: 28),
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.indigo),
              child: Text('Menu', style: TextStyle(color: Colors.black, fontSize: 24)),
            ),
            ListTile(
              leading: const Icon(Icons.history),
              title: const Text('Translation History'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HistoryScreen(history: _history),
                  ),
                );
              },
            ),
        Spacer(),
        ListTile(
             leading: Icon(Icons.logout),
             title: Text('Logout'),
             onTap: () {
             Navigator.pop(context); // close drawer
            logout();},)
          ],
        ),
      ),

      backgroundColor: const Color.fromARGB(255, 255,255, 255),//bg color badme change
      body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 30,
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 40),
                decoration: BoxDecoration(
                    color: Colors.indigo.shade100,
                    borderRadius: BorderRadius.circular(10)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('From'),
                    const SizedBox(
                      width: 100,
                    ),
                    DropdownButton(
                      value: selectedvalue,
                      focusColor: Colors.transparent,
                      items: languages.map((lang) {
                        return DropdownMenuItem(
                          value: lang,
                          child: Text(lang),
                          onTap: () {
                            if (lang == languages[0]) {
                              from = languagescode[0];
                            } else if (lang == languages[1]) {
                              from = languagescode[1];
                            } else if (lang == languages[2]) {
                              from = languagescode[2];
                            } else if (lang == languages[3]) {
                              from = languagescode[3];
                            } else if (lang == languages[4]) {
                              from = languagescode[4];
                            } else if (lang == languages[5]) {
                              from = languagescode[5];
                            } else if (lang == languages[6]) {
                              from = languagescode[6];
                            } else if (lang == languages[7]) {
                              from = languagescode[7];
                            } else if (lang == languages[8]) {
                              from = languagescode[8];
                            }
                            setState(() {
                              // print(lang);
                              // print(from);
                            });
                          },
                        );
                      }).toList(),
                      onChanged: (value) {
                        selectedvalue = value!;
                      },
                    )
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(20),
                margin: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                    color: Colors.blueGrey.withOpacity(0.01),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.black)),
                child: Form(
                  key: formkey,
                  child: TextFormField(
                    controller: controller,
                    maxLines: null,
                    minLines: null,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                    textInputAction: TextInputAction.done,
                    decoration: const InputDecoration(
                        enabledBorder: InputBorder.none,
                        border: InputBorder.none,
                        errorBorder: InputBorder.none,
                        errorStyle: TextStyle(color: Colors.white)),
                    style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 40),
                decoration: BoxDecoration(
                    color: Colors.indigo.shade100,
                    borderRadius: BorderRadius.circular(10)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('To'),
                    const SizedBox(
                      width: 100,
                    ),
                    DropdownButton(
                      value: selectedvalue2,
                      focusColor: Colors.transparent,
                      items: languages.map((lang) {
                        return DropdownMenuItem(
                          value: lang,
                          child: Text(lang),
                          onTap: () {
                            if (lang == languages[0]) {
                              to = languagescode[0];
                            } else if (lang == languages[1]) {
                              to = languagescode[1];
                            } else if (lang == languages[2]) {
                              to = languagescode[2];
                            } else if (lang == languages[3]) {
                              to = languagescode[3];
                            } else if (lang == languages[4]) {
                              to = languagescode[4];
                            } else if (lang == languages[5]) {
                              to = languagescode[5];
                            } else if (lang == languages[6]) {
                              to = languagescode[6];
                            } else if (lang == languages[7]) {
                              to = languagescode[7];
                            } else if (lang == languages[8]) {
                              to = languagescode[8];
                            }
                            setState(() {
                              print(lang);
                              print(from);
                            });
                          },
                        );
                      }).toList(),
                      onChanged: (value) {
                        selectedvalue2 = value!;
                      },
                    )
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(20),
                margin: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                    color: Colors.blueGrey.withOpacity(0.01),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.black)),
                child: Center(
                  child: SelectableText(
                    data,
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              ElevatedButton(
                  onPressed: translate,
                  style: ButtonStyle(
                      backgroundColor:
                      WidgetStatePropertyAll(Colors.indigo.shade900),
                      fixedSize: const WidgetStatePropertyAll(Size(300, 45))),
                  child:isloading?const SizedBox.square(
                    dimension: 20,
                    child: CircularProgressIndicator(color: Colors.black,),
                  ): const Text('Translate',
                      style: TextStyle(color: Colors.white,fontSize: 20)) ),
              const SizedBox(height: 80),
              Lottie.asset(
                'assets/Laptop.json',
                height: 180,
                repeat: true,
              ),

            ],
          )),
    );
  }
}