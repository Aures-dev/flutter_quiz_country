import 'package:flutter/material.dart';
import 'package:flutter_quiz_country/models/user.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/custom_button.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<void> _submitForm() async {
    String name = nameController.text;
    String email = emailController.text;
    String password = passwordController.text;
    final user = User(
        username: name,
        email: email,
        password: password,
        createdAt: DateTime.now());

    // Convertir user en json pour l'envoi de requête
    // Convertir l'objet User en JSON
    final userJson = jsonEncode(user.toJson());

    print("Nom: $name");
    print("Email: $email");
    print("Mot de passe: $password");

    //Url de l'API.
    final String url = 'http://localhost:3000/register';
    try {
      // Faire une requête POST avec les en-têtes JSON
      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'}, // en-têtes de la requête
        body: userJson,
      );

      // Vérification du statut de la réponse
      if (response.statusCode == 201) {
        // 201 pour création d'utilisateur
        Navigator.pushNamed(context, '/');
        print("Réponse du serveur: ${response.body}");
      } else {
        // Erreur de connexion liée aux informations de l'utilisateur
        print("Erreur de connexion: ${response.body}");
      }
    } catch (e) {
      // Erreur de lancement de la requête
      print("Une erreur est survenue : $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.person_add, size: 80, color: Colors.blue),
            const SizedBox(height: 30),
            CustomTextField(
                hintText: "Nom",
                icon: Icons.person,
                controller: nameController),
            const SizedBox(height: 20),
            CustomTextField(
                hintText: "Email",
                icon: Icons.email,
                controller: emailController),
            const SizedBox(height: 20),
            CustomTextField(
                hintText: "Mot de passe",
                icon: Icons.lock,
                isPassword: true,
                controller: passwordController),
            const SizedBox(height: 30),
            CustomButton(text: "S'inscrire", onPressed: _submitForm),
            const SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, '/login');
              },
              child: const Text(
                "J'ai déjà un compte",
                style: TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
