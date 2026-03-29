import 'package:flutter/material.dart';

class FluxifyInputField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final bool isPassword;
  final double borderRadius;
  final VoidCallback? onToggleVisibility;
  final bool isVisible;

  const FluxifyInputField({
    super.key,
    required this.controller,
    required this.label,
    this.isPassword = false,
    this.borderRadius = 25.0, // Default to AuthView style
    this.onToggleVisibility,
    this.isVisible = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: isPassword && !isVisible,
      cursorColor: Colors.white,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.white, fontSize: 14),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        filled: true,
        fillColor: Colors.black,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: BorderSide(
            color: Colors.white.withOpacity(0.8),
            width: 1.2,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: const BorderSide(
            color: Colors.white,
            width: 1.5,
          ),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
        suffixIcon: isPassword
            ? IconButton(
          icon: Icon(
            isVisible ? Icons.visibility : Icons.visibility_outlined,
            color: Colors.white.withOpacity(0.6),
            size: 20,
          ),
          onPressed: onToggleVisibility,
        )
            : null,
      ),
    );
  }
}