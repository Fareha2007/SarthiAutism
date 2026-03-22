import 'package:flutter/material.dart';
import 'parent_setup_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Widget inputField(
    String hint,
    TextEditingController controller,
    double width,
    double height, {
    bool obscure = false,
    TextInputType type = TextInputType.text,
  }) {
    return Container(
      width: width,
      height: height,
      margin: const EdgeInsets.only(bottom: 18),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        border: Border.all(
          color: const Color(0xFFBBA6FF).withOpacity(0.4),
          width: 1.4,
        ),
      ),
      child: TextField(
        controller: controller,
        obscureText: obscure,
        keyboardType: type,
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(color: Colors.grey, fontSize: 14),
          border: InputBorder.none,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final fieldWidth = size.width * 0.8;
    final fieldHeight = size.height * 0.06;
    final logoHeight = size.height * 0.25;

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [0.1, 0.5, 0.9],
            colors: [
              Color(0xFFB4E2FC),
              Color(0xFFF2EFE6),
              Color(0xFFE8D5F2),
            ],
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: size.height * 0.1),
              Image.asset(
                "assets/images/sarthi_logo.png",
                height: logoHeight,
              ),
              SizedBox(height: size.height * 0.05),
              const Text(
                "Create Account",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF6B4FA3),
                ),
              ),
              SizedBox(height: size.height * 0.04),
              inputField("Full Name", nameController, fieldWidth, fieldHeight),
              inputField("Email", emailController, fieldWidth, fieldHeight,
                  type: TextInputType.emailAddress),
              inputField(
                  "Phone Number", phoneController, fieldWidth, fieldHeight,
                  type: TextInputType.phone),
              inputField(
                  "Password", passwordController, fieldWidth, fieldHeight,
                  obscure: true),
              SizedBox(height: size.height * 0.03),
              GestureDetector(
                onTap: () async {
                  final email = emailController.text.trim();
                  final password = passwordController.text.trim();
                  final name = nameController.text.trim();
                  final phone = phoneController.text.trim();

                  if (email.isEmpty || password.isEmpty || name.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Please fill all fields')),
                    );
                    return;
                  }
                  try {
                    final result = await FirebaseAuth.instance
                        .createUserWithEmailAndPassword(
                            email: email, password: password);

                    final uid = result.user?.uid;
                    if (uid == null) return;

                    // Save parent data to Firestore
                    await FirebaseFirestore.instance
                        .collection('users')
                        .doc(uid)
                        .collection('parent')
                        .doc('profile')
                        .set({
                      'name': name,
                      'phone': phone,
                      'city': '',
                      'relationship': 'Mother',
                    });

                    if (!context.mounted) return;

                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (_) => ParentSetupScreen()),
                    );
                  } on FirebaseAuthException catch (e) {
                    if (!context.mounted) return;
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(e.message ?? "Signup failed")),
                    );
                  }
                },
                child: Container(
                  width: fieldWidth,
                  height: fieldHeight,
                  decoration: BoxDecoration(
                    color: const Color(0xFFB4E2FC),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: const Center(
                    child: Text(
                      "Sign Up",
                      style: TextStyle(
                        color: Color(0xFF5B7E95),
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: size.height * 0.03),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Already have an account? ",
                      style: TextStyle(color: Colors.grey, fontSize: 15)),
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Text("Log in",
                        style: TextStyle(
                          color: Color(0xFF5B7E95),
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        )),
                  ),
                ],
              ),
              SizedBox(height: size.height * 0.05),
            ],
          ),
        ),
      ),
    );
  }
}
