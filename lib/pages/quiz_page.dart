import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class QuizPage extends StatefulWidget {
  const QuizPage({super.key});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  int score = 0;
  int questionIndex = 0;
  final String url = 'https://restcountries.com/v3.1/all';

  List<Map<String, dynamic>> countriesData = [];
  List<String> randomCountryNames = [];
  Map<String, dynamic>? currentCountry;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchCountries();
  }

  Future<void> fetchCountries() async {
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final List<dynamic> jsonList = json.decode(response.body);
        setState(() {
          countriesData = jsonList.cast<Map<String, dynamic>>();
          setRandomOptions(); // Sélectionne une première question après le chargement
          isLoading = false;
        });
      } else {
        throw Exception('Erreur lors de la récupération des pays');
      }
    } catch (e) {
      print("Erreur: $e");
    }
  }

  void setRandomOptions() {
    if (countriesData.isEmpty) return;

    // Sélectionner un pays aléatoire
    currentCountry = countriesData[Random().nextInt(countriesData.length)];

    List<String> countryNames =
        countriesData.map((el) => el['name']['common'] as String).toList();

    // Sélectionner 3 pays aléatoires
    randomCountryNames = getRandomElements(countryNames, 3);

    // Ajouter le pays correct dans les options
    if (currentCountry != null) {
      randomCountryNames.add(currentCountry!['name']['common']);
    }

    // Mélanger les options pour éviter que la bonne réponse soit toujours à la même place
    randomCountryNames.shuffle();
  }

  List<T> getRandomElements<T>(List<T> list, int n) {
    Random rand = Random();
    List<T> copy = List<T>.from(list);
    List<T> result = [];

    for (int i = 0; i < n; i++) {
      if (copy.isEmpty) break;
      int randomIndex = rand.nextInt(copy.length);
      result.add(copy[randomIndex]);
      copy.removeAt(randomIndex);
    }
    return result;
  }

  void checkAnswer(String choice) {
    if (choice == currentCountry!['name']['common']) {
      setState(() {
        score++;
        setRandomOptions();
      });
    } else {
      setState(() {
      // print("Dans quiz page on a : $score");
      
      //On passe sur la page sur la page des résultats avec le score en argument
      Navigator.pushNamed(context, "/result-page", arguments: score);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.blue.shade100,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Text(
                      "Can you guess who I am?",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 100),
                  //Affichage du drapeau
                  Center(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        currentCountry?["flags"]["png"] ?? '',
                        width: 200,
                        height: 200,
                        fit: BoxFit.contain,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            width: 100,
                            height: 60,
                            color: Colors.grey[300],
                            child: const Icon(Icons.error, color: Colors.red),
                          );
                        },
                      ),
                    ),
                  ),
                  const Spacer(),
                  // Affichage des options de réponses
                  GridView.builder(
                    shrinkWrap: true,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      childAspectRatio: 3,
                    ),
                    itemCount: randomCountryNames.length,
                    itemBuilder: (context, index) {
                      return ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue.shade300,
                          padding: const EdgeInsets.symmetric(vertical: 18),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onPressed: () {
                          checkAnswer(randomCountryNames[index]);
                        },
                        child: Text(
                          randomCountryNames[index],
                          style: const TextStyle(
                              fontSize: 16, color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 20),
                  //Affichage du score actuel du joueur
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      "Score: $score",
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
    );
  }
}
