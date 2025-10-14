import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_list_app/controller/auth_controller.dart';
import 'package:todo_list_app/components/custom_wave_clipper.dart';
import 'package:todo_list_app/components/custom_text_field.dart';
import 'package:todo_list_app/components/logo_widget.dart';
import 'package:todo_list_app/components/custom_button.dart';

const Color _primaryColor = Color(0xFF7ACFB0);
const Color _darkTextColor = Color(0xFF2C3E50);
const Color _scaffoldBackgroundColor = Color(0xFFF7F9FB);

class LoginWidePage extends GetView<AuthController> {
  const LoginWidePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _scaffoldBackgroundColor,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final bool isWideScreen = constraints.maxWidth > 600;
            final Widget decorationPanel = _buildDecorationPanel();
            final Widget loginForm = _buildLoginForm(context);

            if (isWideScreen) {
              return Center(
                child: Container(
                  constraints: const BoxConstraints(
                    maxWidth: 1200,
                    maxHeight: 700,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 50,
                        offset: const Offset(0, 20),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 5,
                        child: ClipPath(
                          clipper: CustomWaveClipper(),
                          child: ClipRRect(
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(24),
                              bottomLeft: Radius.circular(24),
                            ),
                            child: SingleChildScrollView(
                              child: decorationPanel,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 5,
                        child: Center(
                          child: ConstrainedBox(
                            constraints: const BoxConstraints(maxWidth: 400),
                            child: SingleChildScrollView(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 48,
                                vertical: 32,
                              ),
                              child: loginForm,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            } else {
              return SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      height: constraints.maxHeight * 0.35,
                      child: ClipPath(
                        clipper: CustomWaveClipper(),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(30),
                          child: SingleChildScrollView(child: decorationPanel),
                        ),
                      ),
                    ),
                    const SizedBox(height: 32),
                    loginForm,
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }

  Widget _buildDecorationPanel() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            _primaryColor.withOpacity(0.95),
            _primaryColor.withOpacity(0.75),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            LogoWidget(
              child: Image.asset(
                "lib/assets/images/logo.png",
                width: 135,
                height: 135,
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(height: 32),
            const Text(
              "TO DO LIST",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.w900,
                color: Colors.white,
                letterSpacing: 1.5,
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              "Everything you need, organized here.\nLog in to manage your productivity.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                color: Colors.white70,
                height: 1.4,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLoginForm(BuildContext context) {
    final controller = Get.isRegistered<AuthController>()
        ? Get.find<AuthController>()
        : Get.put(AuthController());

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Text(
          "Welcome Back!",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: _primaryColor,
          ),
        ),
        const SizedBox(height: 4),
        const Text(
          "LOGIN",
          style: TextStyle(
            fontSize: 42,
            fontWeight: FontWeight.w900,
            color: _darkTextColor,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          "Please enter your credentials below.",
          style: TextStyle(fontSize: 16, color: Colors.grey.shade600),
        ),
        const SizedBox(height: 40),
        CustomTextField(
          controller: controller.usernameController,
          hint: "Email/Username",
          prefixIcon: Icons.mail_outline,
        ),
        const SizedBox(height: 20),
        Obx(
          () => CustomTextField(
            controller: controller.passwordController,
            hint: "Password",
            prefixIcon: Icons.lock_outline,
            obscureText: controller.isPasswordHidden.value,
            suffixIcon: IconButton(
              icon: Icon(
                controller.isPasswordHidden.value
                    ? Icons.visibility_off_rounded
                    : Icons.visibility_rounded,
                color: Colors.grey.shade500,
              ),
              onPressed: () => controller.isPasswordHidden.value =
                  !controller.isPasswordHidden.value,
            ),
          ),
        ),
        const SizedBox(height: 16),
        Align(
          alignment: Alignment.centerRight,
          child: GestureDetector(
            onTap: () {},
            child: const Text(
              "Forgot Password?",
              style: TextStyle(
                color: _primaryColor,
                fontWeight: FontWeight.w500,
                fontSize: 14,
              ),
            ),
          ),
        ),
        const SizedBox(height: 40),
        CustomButton(
          label: "LOG IN",
          onPressed: () => controller.login(context),
        ),
        const SizedBox(height: 24),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Don't have an account? ",
              style: TextStyle(color: Colors.grey.shade600),
            ),
            GestureDetector(
              onTap: () {},
              child: const Text(
                "Sign Up",
                style: TextStyle(
                  color: _primaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
