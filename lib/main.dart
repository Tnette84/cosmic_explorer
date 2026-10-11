
import 'package:flutter/material.dart';

void main() {
  runApp(const CosmicExplorerApp());
}

// Planet data model
class Planet {
  final String name;
  final String type;
  final String description;

  const Planet({
    required this.name,
    required this.type,
    required this.description,
  });
}

// Planetary database
class PlanetCatalog {
  static const List<Planet> planets = [
    Planet(
      name: 'Mercury',
      type: 'Terrestrial Planet',
      description: 'The closest planet to the Sun.',
    ),
    Planet(
      name: 'Mars',
      type: 'Terrestrial Planet',
      description: 'The red planet, known for its rocky surface.',
    ),
    Planet(
      name: 'Jupiter',
      type: 'Gas Giant',
      description: 'The largest planet in our solar system.',
    ),
    Planet(
      name: 'Kepler-186f',
      type: 'Exoplanet',
      description: 'An Earth-sized planet outside our solar system.',
    ),
    Planet(
      name: 'Proxima Centauri b',
      type: 'Exoplanet',
      description: 'A planet orbiting the closest star to the Sun.',
    ),
  ];
}

// Main application
class CosmicExplorerApp extends StatelessWidget {
  const CosmicExplorerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Cosmic Explorer',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
        ),
        useMaterial3: true,
      ),
      home: const MissionControl(),
    );
  }
}

// Mission Control screen
class MissionControl extends StatelessWidget {
  const MissionControl({super.key});

  Future<void> openPlanet(
    BuildContext context,
    Planet planet,
  ) async {
    final String? result = await Navigator.push<String>(
      context,
      MaterialPageRoute(
        builder: (context) => PlanetDetail(planet: planet),
      ),
    );

    if (!context.mounted) return;

    if (result != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(result),
          duration: const Duration(seconds: 3),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cosmic Explorer - Mission Control'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: ListView.builder(
        itemCount: PlanetCatalog.planets.length,
        itemBuilder: (context, index) {
          final planet = PlanetCatalog.planets[index];

          return ListTile(
            leading: const Icon(Icons.public),
            title: Text(planet.name),
            subtitle: Text(planet.type),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              openPlanet(context, planet);
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const DockingBay(),
            ),
          );
        },
        icon: const Icon(Icons.rocket_launch),
        label: const Text('Docking Bay'),
      ),
    );
  }
}

// Planet detail screen
class PlanetDetail extends StatelessWidget {
  final Planet planet;

  const PlanetDetail({
    super.key,
    required this.planet,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(planet.name),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              planet.name,
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 15),
            Text('Type: ${planet.type}'),
            const SizedBox(height: 15),
            Text(planet.description),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(
                  context,
                  'Visit confirmed: ${planet.name}',
                );
              },
              child: const Text('Confirm Visit'),
            ),
          ],
        ),
      ),
    );
  }
}

// Docking Bay screen
class DockingBay extends StatelessWidget {
  const DockingBay({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Docking Bay Telemetry'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Return to Control'),
        ),
      ),
    );
  }
}
