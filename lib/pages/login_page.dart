import 'package:flutter/material.dart';
import '../components/input_field.dart';
import '../components/primary_button.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Todo List App",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                const SizedBox(height: 30),

                // Username
                InputField(
                  hintText: "Username",
                  controller: usernameController,
                ),
                const SizedBox(height: 16),

                // Password
                InputField(
                  hintText: "Password",
                  obscureText: true,
                  controller: passwordController,
                ),
                const SizedBox(height: 20),

                // Login Button
                PrimaryButton(
                  text: "Login",
                  onPressed: () {
                    // sementara, belum pakai controller
                    if (usernameController.text == "admin" &&
                        passwordController.text == "123") {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Login Berhasil")),
                      );
                      // TODO: nanti redirect ke dashboard
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Username / Password salah")),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
