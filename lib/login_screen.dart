import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'translator_screen.dart';
import 'package:lottie/lottie.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  String email = '', password = '';
  bool isLoading = false;

  void _login() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => isLoading = true);

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => TranslatorScreen()),
      );
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Login successful!')),
      );
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.message ?? 'Login failed')),
      );
    } finally {
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Login")),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Lottie.asset('assets/Login.json',
                height: 370,
                repeat: true,),
              SizedBox(height: 20),
              TextFormField(
                decoration: InputDecoration(labelText: "Email", border: OutlineInputBorder(borderRadius: BorderRadius.circular(24))),
                keyboardType: TextInputType.emailAddress,
                onChanged: (val) => email = val,
                validator: (val) =>
                val != null && val.contains('@') ? null : 'Enter a valid email',
              ),
              SizedBox(height: 16),
              TextFormField(
                decoration: InputDecoration(labelText: "Password", border: OutlineInputBorder(borderRadius: BorderRadius.circular(24))),
                obscureText: true,
                onChanged: (val) => password = val,
                validator: (val) =>
                val != null && val.length >= 6 ? null : 'Min 6 characters required',
              ),
              SizedBox(height: 30),
              isLoading
                  ? CircularProgressIndicator()
                  : ElevatedButton(
                style: ElevatedButton.styleFrom(

                  minimumSize: Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: _login,
                child: Text("Login"),
              ),


            ],

          ),
        ),
      ),
    );
  }
}
