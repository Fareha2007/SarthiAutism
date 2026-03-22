import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sarthi_flutter_project/models/models.dart';
import 'package:sarthi_flutter_project/screens/home_screen.dart';
import 'package:sarthi_flutter_project/screens/main_shell.dart';
import 'signup_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _email = TextEditingController();
  final _pass = TextEditingController();

  @override
  void dispose() {
    _email.dispose();
    _pass.dispose();
    super.dispose();
  }

  Future<void> _sendPasswordReset() async {
    final resetEmailController = TextEditingController();

    await showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Reset Password'),
        content: TextField(
          controller: resetEmailController,
          keyboardType: TextInputType.emailAddress,
          decoration: const InputDecoration(
            hintText: 'Enter your email',
            border: OutlineInputBorder(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              final email = resetEmailController.text.trim();
              Navigator.pop(ctx);
              if (email.isEmpty) return;
              try {
                await FirebaseAuth.instance
                    .sendPasswordResetEmail(email: email);
                print('Reset email sent to $email'); // ← debug inside here
                if (!context.mounted) return;
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                      content: Text('Reset email sent! Check your inbox.')),
                );
              } on FirebaseAuthException catch (e) {
                print('Error: ${e.code} — ${e.message}'); // ← and here
                if (!context.mounted) return;
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(e.message ?? 'Error sending email')),
                );
              } finally {
                resetEmailController.dispose();
              }
            },
            child: const Text('Send'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;
    final fieldWidth = width * 0.8;
    final fieldHeight = height * 0.06;
    final logoHeight = height * 0.22;
    final textSize = width * 0.045;

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
          child: //ConstrainedBox(
              //constraints: BoxConstraints(minHeight: height),
              //  child:
              Column(
            children: [
              SizedBox(height: height * 0.1),

              Image.asset(
                "assets/images/sarthi_logo.png",
                height: logoHeight,
              ),

              SizedBox(height: height * 0.05),

              // Email
              Container(
                width: fieldWidth,
                height: fieldHeight,
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
                  controller: _email,
                  style: TextStyle(fontSize: textSize),
                  decoration: const InputDecoration(
                    hintText: "Email",
                    border: InputBorder.none,
                  ),
                ),
              ),

              SizedBox(height: height * 0.025),

              // Password
              Container(
                width: fieldWidth,
                height: fieldHeight,
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
                  controller: _pass,
                  obscureText: true,
                  style: TextStyle(fontSize: textSize),
                  decoration: const InputDecoration(
                    hintText: "Password",
                    border: InputBorder.none,
                  ),
                ),
              ),

              SizedBox(height: height * 0.05),

              // Login Button
              GestureDetector(
                onTap: () async {
                  final email = _email.text.trim();
                  final password = _pass.text.trim();

                  if (email.isEmpty || password.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text('Please enter email and password')),
                    );
                    return;
                  }

                  try {
                    final result =
                        await FirebaseAuth.instance.signInWithEmailAndPassword(
                      email: email,
                      password: password,
                    );

                    final uid = result.user?.uid;
                    if (uid == null) return;

                    final doc = await FirebaseFirestore.instance
                        .collection('users')
                        .doc(uid)
                        .collection('child')
                        .doc('profile')
                        .get();

                    if (!context.mounted) return;

                    final child = doc.exists
                        ? ChildProfile.fromMap(doc.data()!)
                        : ChildProfile();

                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (_) => MainShell(child: child),
                      ),
                    );
                  } on FirebaseAuthException catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(e.message ?? "Login failed")),
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
                  child: Center(
                    child: Text(
                      "Log in",
                      style: TextStyle(
                        fontSize: width * 0.05,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF5B7E95),
                      ),
                    ),
                  ),
                ),
              ),

              SizedBox(height: height * 0.03),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: _sendPasswordReset, // ← moved here
                    child: Text(
                      "Forgot password?",
                      style: TextStyle(
                        color:
                            const Color(0xFF5B7E95), // ← make it look tappable
                        fontSize: width * 0.038,
                      ),
                    ),
                  ),
                  const Text(" | "),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const SignupScreen()),
                      );
                    },
                    child: Text(
                      "Create Account",
                      style: TextStyle(
                        color: const Color(0xFF5B7E95),
                        fontSize: width * 0.038,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: height * 0.05),
            ],
          ),
        ),
      ),
    );
  }
}
