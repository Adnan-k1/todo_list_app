import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_list_app/controller/auth_controller.dart';

// --- Reusable UI Components ---
const Color _primaryColor = Color(0xFF7ACFB0);
const Color _darkTextColor = Color(0xFF2C3E50);
const Color _scaffoldBackgroundColor = Color(0xFFF7F9FB);

/// Custom Clipper untuk panel dekoratif kiri
class CustomWaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, size.height);

    var firstControlPoint = Offset(size.width * 0.2, size.height - 40);
    var firstEndPoint = Offset(size.width * 0.4, size.height - 20);
    path.quadraticBezierTo(
        firstControlPoint.dx, firstControlPoint.dy, firstEndPoint.dx, firstEndPoint.dy);

    var secondControlPoint = Offset(size.width * 0.65, size.height + 10);
    var secondEndPoint = Offset(size.width, size.height - 50);
    path.quadraticBezierTo(
        secondControlPoint.dx, secondControlPoint.dy, secondEndPoint.dx, secondEndPoint.dy);

    path.lineTo(size.width, 0);
    path.lineTo(0, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}

/// Custom Text Field
class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final IconData prefixIcon;
  final bool obscureText;
  final Widget? suffixIcon;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.prefixIcon,
    this.obscureText = false,
    this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    const double borderRadius = 30.0;
    return TextField(
      controller: controller,
      obscureText: obscureText,
      style: const TextStyle(color: _darkTextColor, fontSize: 16),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(color: Colors.grey.shade500),
        prefixIcon: Icon(prefixIcon, color: _primaryColor.withOpacity(0.8)),
        suffixIcon: suffixIcon,
        contentPadding: const EdgeInsets.symmetric(vertical: 18, horizontal: 20),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: BorderSide(color: Colors.grey.shade200, width: 2),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: const BorderSide(color: _primaryColor, width: 2.5),
        ),
      ),
    );
  }
}

/// Custom Button
class CustomButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;

  const CustomButton({super.key, required this.label, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: _primaryColor,
          elevation: 8,
          shadowColor: _primaryColor.withOpacity(0.4),
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        onPressed: onPressed,
        child: Text(
          label,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w900,
            color: Colors.white,
            letterSpacing: 1.2,
          ),
        ),
      ),
    );
  }
}

/// Logo Widget (bisa menampilkan child seperti Image.asset)
class LogoWidget extends StatelessWidget {
  final Widget? child;
  final Color boundaryColor;
  final Color backgroundColor;

  const LogoWidget({
    super.key,
    this.child,
    this.boundaryColor = _primaryColor,
    this.backgroundColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      height: 150,
      decoration: BoxDecoration(
        color: backgroundColor,
        shape: BoxShape.circle,
        border: Border.all(color: boundaryColor.withOpacity(0.5), width: 4),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 20, offset: Offset(0, 10)),
        ],
      ),
      child: Center(
        child: child ?? Icon(Icons.assignment_turned_in_rounded, size: 80, color: _primaryColor),
      ),
    );
  }
}

/// --- Login Page ---
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
              // Wide screen layout (split panel)
              return Center(
                child: Container(
                  constraints: const BoxConstraints(maxWidth: 1200, maxHeight: 700),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 50, offset: const Offset(0, 20)),
                    ],
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 5,
                        child: ClipRRect(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(24),
                            bottomLeft: Radius.circular(24),
                          ),
                          child: decorationPanel,
                        ),
                      ),
                      Expanded(
                        flex: 5,
                        child: Center(
                          child: ConstrainedBox(
                            constraints: const BoxConstraints(maxWidth: 400),
                            child: SingleChildScrollView(
                              padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 32),
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
              // Mobile layout
              return SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      height: constraints.maxHeight * 0.35,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(30),
                        child: decorationPanel,
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
    return ClipPath(
      clipper: CustomWaveClipper(),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [_primaryColor.withOpacity(0.95), _primaryColor.withOpacity(0.75)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(32),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
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
                  style: TextStyle(fontSize: 18, color: Colors.white70, height: 1.4),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLoginForm(BuildContext context) {
    final controller = Get.isRegistered<AuthController>() ? Get.find<AuthController>() : Get.put(AuthController());

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Text(
          "Welcome Back!",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: _primaryColor),
        ),
        const SizedBox(height: 4),
        const Text(
          "LOGIN",
          style: TextStyle(fontSize: 42, fontWeight: FontWeight.w900, color: _darkTextColor),
        ),
        const SizedBox(height: 8),
        Text(
          "Please enter your credentials below.",
          style: TextStyle(fontSize: 16, color: Colors.grey.shade600),
        ),
        const SizedBox(height: 40),
        CustomTextField(
          controller: controller.usernameController,
          hintText: "Email/Username",
          prefixIcon: Icons.mail_outline,
        ),
        const SizedBox(height: 20),
        Obx(
          () => CustomTextField(
            controller: controller.passwordController,
            hintText: "Password",
            prefixIcon: Icons.lock_outline,
            obscureText: controller.isPasswordHidden.value,
            suffixIcon: IconButton(
              icon: Icon(
                controller.isPasswordHidden.value ? Icons.visibility_off_rounded : Icons.visibility_rounded,
                color: Colors.grey.shade500,
              ),
              onPressed: () => controller.isPasswordHidden.value = !controller.isPasswordHidden.value,
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
              style: TextStyle(color: _primaryColor, fontWeight: FontWeight.w500, fontSize: 14),
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
            Text("Don't have an account? ", style: TextStyle(color: Colors.grey.shade600)),
            GestureDetector(
              onTap: () {},
              child: const Text("Sign Up", style: TextStyle(color: _primaryColor, fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      ],
    );
  }
}
