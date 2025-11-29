import 'package:cloud_firestore/cloud_firestore.dart';
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
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const AdminScreen(),
      ),
    );
    setState(() {}); // refresca al volver
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
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('movies')
            .orderBy('title')
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(child: Text('Error al cargar películas'));
          }
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final docs = snapshot.data!.docs;
          if (docs.isEmpty) {
            return const Center(child: Text('No hay películas en el catálogo.'));
          }

          return ListView.builder(
            itemCount: docs.length,
            itemBuilder: (context, index) {
              final movie = Movie.fromDoc(docs[index]);

              return ListTile(
                leading: movie.imageUrl.isNotEmpty
                    ? Image.network(
                        movie.imageUrl,
                        width: 60,
                        fit: BoxFit.cover,
                      )
                    : const Icon(Icons.movie),
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
          );
        },
      ),
    );
  }
}
