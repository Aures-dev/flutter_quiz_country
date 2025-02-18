import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final bool isPassword;
  final IconData icon;
  final TextEditingController controller; // Ajout du controller

  const CustomTextField({
    super.key,
    required this.hintText,
    this.isPassword = false,
    required this.icon,
    required this.controller, // Obligatoire 
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller, // Lier le champ au controller
      obscureText: isPassword,
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: Colors.blue),
        hintText: hintText,
        filled: true,
        fillColor: Colors.grey.shade200,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
