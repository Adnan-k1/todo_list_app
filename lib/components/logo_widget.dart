import 'package:flutter/material.dart';

const Color _primaryColor = Color(0xFF7ACFB0);

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
          BoxShadow(
            color: Colors.black12,
            blurRadius: 20,
            offset: Offset(0, 10),
          ),
        ],
      ),
      child: Center(
        child:
            child ??
            Icon(
              Icons.assignment_turned_in_rounded,
              size: 80,
              color: _primaryColor,
            ),
      ),
    );
  }
}
