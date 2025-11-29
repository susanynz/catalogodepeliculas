import 'package:flutter/material.dart';
import '../models/movie.dart';
import 'details_screen.dart';
import 'admin_screen.dart';

class CatalogScreen extends StatefulWidget {
  const CatalogScreen({super.key});

  @override
  State<CatalogScreen> createState() => _CatalogScreenState();
}

class _CatalogScreenState extends State<CatalogScreen> {
  Future<void> _goToAdmin() async {
    // Esperamos a que se cierre la pantalla de administración
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const AdminScreen(),
      ),
    );

    // Cuando regresa, forzamos que se reconstruya el catálogo
    setState(() {
      // No hace falta cambiar nada aquí, solo disparar el rebuild
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Catálogo de Películas"),
        actions: [
          IconButton(
            icon: const Icon(Icons.admin_panel_settings),
            onPressed: _goToAdmin,
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: dummyMovies.length,
        itemBuilder: (context, index) {
          final movie = dummyMovies[index];

          return ListTile(
            leading: Image.network(
              movie.imageUrl,
              width: 60,
              fit: BoxFit.cover,
            ),
            title: Text(movie.title),
            subtitle: Text("${movie.year} • ${movie.genre}"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => DetailsScreen(movie: movie),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
