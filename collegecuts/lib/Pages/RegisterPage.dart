import 'package:flutter/material.dart';
import 'package:validators/validators.dart' as validator;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() {
  runApp(const RegisterApp());
}

class RegisterApp extends StatelessWidget {
  const RegisterApp({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Register Page',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colors.blue[900], // Background color
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.blueGrey, // AppBar background color
        ),
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.teal, // Primary color for the app
        ),
      ),
      home: const RegisterPage(),
    );
  }
}

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  late TextEditingController _firstNameController;
  late TextEditingController _lastNameController;
  late TextEditingController _phoneNumberController;
  bool showError = false;
  bool registrationComplete = false;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _firstNameController = TextEditingController();
    _lastNameController = TextEditingController();
    _phoneNumberController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _phoneNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Welcome!'),
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                'Register',
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
              _buildTextField('Email', 'Enter your email', _emailController),
              const SizedBox(height: 20.0),
              _buildTextField(
                  'Password', 'Enter your password', _passwordController,
                  isObscure: true),
              const SizedBox(height: 20.0),
              _buildTextField(
                  'First Name', 'Enter your first name', _firstNameController),
              const SizedBox(height: 20.0),
              _buildTextField(
                  'Last Name', 'Enter your last name', _lastNameController),
              const SizedBox(height: 20.0),
              _buildTextField('Phone Number', 'Enter your phone number',
                  _phoneNumberController),
              const SizedBox(height: 20.0),
              _buildRegisterButton(),
              Visibility(
                visible: showError, // Display error text if showError is true
                child: const Text(
                  'Details are incorrect / password must be minimum 8 characters.',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.red),
                ),
              ),
              Visibility(
                visible: registrationComplete, // Display success message if registrationComplete is true
                child: const Text(
                  'Registration complete!',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.green),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, String hint,
      TextEditingController controller, {bool isObscure = false}) {
    return SizedBox(
      width: 300.0,
      child: TextField(
        controller: controller,
        style: const TextStyle(color: Colors.black),
        obscureText: isObscure,
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          floatingLabelBehavior: FloatingLabelBehavior.never,
          // Hide the label when focused or has input
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
        onChanged: (value) {
          // Update state or handle changes
        },
      ),
    );
  }

  Widget _buildRegisterButton() {
    return SizedBox(
      width: 300.0,
      height: 50.0,
      child: ElevatedButton(
        onPressed: () {
          _registerValidation();
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.teal,
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

  void _registerValidation() async {
    // Retrieve text from controllers
    String email = _emailController.text;
    String password = _passwordController.text;
    String firstName = _firstNameController.text;
    String lastName = _lastNameController.text;
    String phoneNumber = _phoneNumberController.text;

    // Validate the inputs
    if (email.isNotEmpty &&
        validator.isEmail(email) &&
        password.isNotEmpty &&
        password.isNotEmpty &&  // Ensure password meets minimum length requirement
        firstName.isNotEmpty &&
        lastName.isNotEmpty &&
        phoneNumber.isNotEmpty &&
        phoneNumber.isNotEmpty) {
      try {
        UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );

        // Get the newly created user's ID
        String userId = userCredential.user!.uid;
        // Save user details to Firestore database
        await FirebaseFirestore.instance.collection('users').doc(userId).set({
          'email': email,
          'firstName': firstName,
          'lastName': lastName,
          'phoneNumber': phoneNumber,
          // Add more fields as needed
        });

        // Registration successful
        setState(() {
          registrationComplete = true;
          showError = false;
        });
      } catch (e) {
        // Handle any errors that occur during registration
        print("Error during registration: $e");
        setState(() {
          registrationComplete = false;
          showError = true;
        });
      }
    } else {
      // At least one field is empty or does not meet validation criteria, set showError to true
      setState(() {
        registrationComplete = false;
        showError = true;
      });
    }
  }


// void _registerValidation() async {
  //   // Retrieve text from controllers
  //   String email = _emailController.text;
  //   String password = _passwordController.text;
  //   String firstName = _firstNameController.text;
  //   String lastName = _lastNameController.text;
  //   String phoneNumber = _phoneNumberController.text;
  //
  //   // Validate the inputs
  //   if (email.isNotEmpty &&
  //       validator.isEmail(email) &&
  //       password.isNotEmpty &&
  //       password.length >= 8 &&
  //       firstName.isNotEmpty &&
  //       lastName.isNotEmpty &&
  //       phoneNumber.isNotEmpty &&
  //       phoneNumber.length == 11) {
  //     UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
  //       email: email,
  //       password: password,
  //     );
  //     // Get the newly created user's ID
  //     String userId = userCredential.user!.uid;
  //     // Save user details to Firestore database
  //     await FirebaseFirestore.instance.collection('users').doc(userId).set({
  //       'email': email,
  //       'firstName': firstName,
  //       'lastName': lastName,
  //       'phoneNumber': phoneNumber,
  //       // Add more fields as needed
  //     });
  //
  //     // Registration successful
  //     setState(() {
  //       registrationComplete = true;
  //       showError = false;
  //     });
  //     // All fields are filled and meet validation criteria, proceed with registration
  //     setState(() {
  //       registrationComplete = true; // Set registrationComplete to true
  //       showError = false; // Reset showError state if validation succeeds
  //     });
  //   } else {
  //     // At least one field is empty or does not meet validation criteria, set showError to true
  //     setState(() {
  //       registrationComplete = false; // Reset registrationComplete to false
  //       showError = true; // Show error message
  //     });
  //   }
  // }
}
