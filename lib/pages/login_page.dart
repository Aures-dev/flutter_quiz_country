import 'package:flutter/material.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/custom_button.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // Création des contrôleurs pour les champs
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<void> _submitForm()async {
    String email = emailController.text;
    String password = passwordController.text;
    final loginInfo = {
      "email": email,
      "password": password
    };

    // Convertir user en json pour l'envoi de requête
    final loginInfoJson = json.encode(loginInfo);

    print("Email: $email");
    print("Mot de passe: $password");

    //Url de l'API.
    final String url = 'http://localhost:3000/login';
    try {
      // Faire une requête POST avec les en-têtes JSON
      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'}, // en-têtes de la requête
        body: loginInfoJson,
      );

      // Vérification du statut de la réponse
      if (response.statusCode == 200) {
        // 200 pour la réussite de connexion
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
            const Icon(Icons.lock, size: 80, color: Colors.blue),
            const SizedBox(height: 30),

            // Champs Email et Mot de passe
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

            // Bouton de connexion avec la fonction de soumission
            CustomButton(text: "Se connecter", onPressed: _submitForm),
            const SizedBox(height: 20),

            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, "/register");
              },
              child: const Text(
                "Créer un compte",
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
