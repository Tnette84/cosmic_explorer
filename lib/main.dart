
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

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

// Application routes
final GoRouter appRouter = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const MissionControl(),
    ),
    GoRoute(
      path: '/docking-bay',
      builder: (context, state) => const DockingBay(),
    ),
    GoRoute(
      path: '/planet/:id',
      builder: (context, state) {
        final id = int.tryParse(state.pathParameters['id'] ?? '');

        if (id == null ||
            id < 0 ||
            id >= PlanetCatalog.planets.length) {
          return const InvalidPlanetScreen();
        }

        return PlanetDetail(
          planet: PlanetCatalog.planets[id],
        );
      },
    ),
  ],
);

// Main application
class CosmicExplorerApp extends StatelessWidget {
  const CosmicExplorerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Cosmic Explorer',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
        ),
        useMaterial3: true,
      ),
      routerConfig: appRouter,
    );
  }
}

// Mission Control screen
class MissionControl extends StatelessWidget {
  const MissionControl({super.key});

  Future<void> openPlanet(
    BuildContext context,
    int index,
  ) async {
    final result = await context.push<String>('/planet/$index');

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
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.deepPurple,
              ),
              child: Text(
                'Cosmic Explorer Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Mission Control'),
              onTap: () {
                Navigator.pop(context);
                context.go('/');
              },
            ),
            ListTile(
              leading: const Icon(Icons.rocket_launch),
              title: const Text('Docking Bay'),
              onTap: () {
                Navigator.pop(context);
                context.push('/docking-bay');
              },
            ),
          ],
        ),
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
              openPlanet(context, index);
            },
          );
        },
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
                context.pop('Visit confirmed: ${planet.name}');
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
            if (context.canPop()) {
              context.pop();
            } else {
              context.go('/');
            }
          },
          child: const Text('Return to Control'),
        ),
      ),
    );
  }
}

// Invalid planet route
class InvalidPlanetScreen extends StatelessWidget {
  const InvalidPlanetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Planet Not Found'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () => context.go('/'),
          child: const Text('Return to Mission Control'),
        ),
      ),
    );
  }
}
