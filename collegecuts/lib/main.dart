import 'package:collegecuts/Pages/firebase_options.dart';
import 'package:flutter/material.dart';
import 'Pages/HomePage.dart';
import 'Pages/RegisterPage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'dart:core';
import 'package:firebase_auth/firebase_auth.dart';

void main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(LoginApp());
}

class LoginApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login Page',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colors.blueGrey[900], // Background color
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.teal, // Primary color for the app
        ),
      ),
      home: const LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // Text editing controllers for email and password fields
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  bool showError = false;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void login() async {
    var email = _emailController.text;
    var password = _passwordController.text;

    try {
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // If authentication succeeds, navigate to the home page
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
      );
    } catch (e) {
      // If authentication fails, show error message
      setState(() {
        showError = true;
      });
      print('Failed to login: $e');
    }
  }

  void navigateToRegisterPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const RegisterPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('COBC Barber Shop'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Welcome!',
              style: TextStyle(
                fontSize: 30.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 10.0),
            Container(
              width: 200.0,
              height: 2.0,
              color: Colors.teal, // Line color
            ),
            const SizedBox(height: 30.0),
            _buildEmailField(), // Call _buildEmailField
            const SizedBox(height: 20.0),
            _buildPasswordField(), // Call _buildPasswordField
            const SizedBox(height: 20.0),
            _buildLoginButton(),
            const SizedBox(height: 10.0),
            _buildRegisterButton(context),
            Visibility(
              visible: showError, // Display error text if showError is true
              child: const Text(
                'Login failed',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        ),
      ),
    );
  }

// Widget for email text field
  Widget _buildEmailField() {
    final emailFocusNode =
    FocusNode(); // Create a focus node for the email field
    bool isEmailFocused = false; // Track if the email field is focused

    return SizedBox(
      width: 300.0,
      child: TextField(
        focusNode: emailFocusNode,
        // Assign the focus node to the email field
        controller: _emailController,
        style: const TextStyle(color: Colors.black),
        // Set text color to black
        decoration: InputDecoration(
          labelText:
          isEmailFocused || _emailController.text.isNotEmpty ? '' : 'Email',
          // Show label only when not focused and field is empty
          hintText: 'Enter your email',
          // Hint text when no text is entered
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
        onTap: () {
          setState(() {
            isEmailFocused = true; // Set the email field focused
          });
        },
        onEditingComplete: () {
          setState(() {
            isEmailFocused = false; // Set the email field not focused
          });
        },
        onChanged: (value) {
          setState(
                  () {}); // Update the state to rebuild the widget when the text changes
        },
      ),
    );
  }

  // Widget for password text field
  Widget _buildPasswordField() {
    final passwordFocusNode =
    FocusNode(); // Create a focus node for the password field
    bool isPasswordFocused = false; // Track if the password field is focused

    return SizedBox(
      width: 300.0,
      child: TextField(
        focusNode: passwordFocusNode,
        // Assign the focus node to the password field
        controller: _passwordController,
        style: const TextStyle(color: Colors.black),
        // Set text color to black
        obscureText: true,
        decoration: InputDecoration(
          labelText: isPasswordFocused || _passwordController.text.isNotEmpty
              ? ''
              : 'Password',
          // Show label only when not focused and field is empty
          hintText: 'Enter your password',
          // Hint text when no text is entered
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
        onTap: () {
          setState(() {
            isPasswordFocused = true; // Set the password field focused
          });
        },
        onEditingComplete: () {
          setState(() {
            isPasswordFocused = false; // Set the password field not focused
          });
        },
        onChanged: (value) {
          setState(
                  () {}); // Update the state to rebuild the widget when the text changes
        },
      ),
    );
  }

  // Widget for login button
  Widget _buildLoginButton() {
    return SizedBox(
      width: 300.0,
      height: 50.0,
      child: ElevatedButton(
        onPressed: () {
          // Handle login button press
          login();
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.teal, // Button color
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
        child: const Text(
          'Login',
          style: TextStyle(
            fontSize: 18.0,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget _buildRegisterButton(BuildContext context) {
    return SizedBox(
      width: 300.0,
      height: 50.0,
      child: TextButton(
        onPressed: () {
          // Navigate to the registration page
          navigateToRegisterPage(context);
        },
        style: TextButton.styleFrom(
          backgroundColor: Colors.teal, // Button color
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
        child: const Text(
          'Register',
          style: TextStyle(
            fontSize: 18.0,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}