import 'package:flutter/material.dart';
import 'planet.dart';
import 'api_service.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Système Solaire',
      home: Directionality(
        textDirection: TextDirection.rtl,
        child: PlanetListScreen(),
      ),
    );
  }
}

class PlanetListScreen extends StatefulWidget {
  const PlanetListScreen({super.key});

  @override
  _PlanetListScreenState createState() => _PlanetListScreenState();
}

class _PlanetListScreenState extends State<PlanetListScreen> {
  late Future<List<Planet>> planets;

  @override
  void initState() {
    super.initState();
    planets = ApiService().fetchPlanets(); // Charge les planètes depuis l'API
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<Planet>>(
        future: planets, // Récupère les planètes depuis l'API
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator()); // Affiche un indicateur de chargement
          } else if (snapshot.hasError) {
            return Center(child: Text('خطأ: ${snapshot.error}')); // Affiche l'erreur en cas de problème
          } else if (!snapshot.hasData) {
            return Center(child: Text('لا توجد بيانات')); // Affiche un message si aucune donnée n'est récupérée
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length, // Compte le nombre de planètes
              itemBuilder: (context, index) {
                Planet planet = snapshot.data![index];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.0),
                      color: Colors.transparent,
                    ),
                    child: ExpansionTile(
                      title: Text(
                        planet.name,
                        style: const TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 16.0),
                              Text(
                                planet.description,
                                style: TextStyle(
                                  fontSize: 18.0,
                                  color: Colors.black,
                                ),
                                textAlign: TextAlign.justify,
                              ),
                              SizedBox(height: 8.0),
                              Text(
                                'المسافة من الشمس: ${planet.distanceFromSun}',
                                style: TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
