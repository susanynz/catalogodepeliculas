import 'package:flutter/material.dart';
import '../models/movie.dart';
import 'add_movie_screen.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({super.key});

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  void _deleteMovie(Movie movie) {
    setState(() {
      dummyMovies.remove(movie);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Película eliminada del catálogo')),
    );
  }

  Future<void> _goToAddMovie() async {
    final newMovie = await Navigator.push<Movie>(
      context,
      MaterialPageRoute(
        builder: (_) => const AddMovieScreen(),
      ),
    );

    if (newMovie != null) {
      setState(() {
        dummyMovies.add(newMovie);
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Película agregada al catálogo')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Administrar catálogo'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Películas en el catálogo:',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 8),

            // Botón para ir a la pantalla de alta
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: _goToAddMovie,
                icon: const Icon(Icons.add),
                label: const Text('Agregar película'),
              ),
            ),

            const SizedBox(height: 16),

            // Lista de películas con opción de eliminar
            Expanded(
              child: ListView.builder(
                itemCount: dummyMovies.length,
                itemBuilder: (context, index) {
                  final movie = dummyMovies[index];
                  return ListTile(
                    title: Text(movie.title),
                    subtitle: Text('${movie.year} • ${movie.genre}'),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () => _deleteMovie(movie),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
