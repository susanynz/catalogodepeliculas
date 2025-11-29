import 'package:flutter/material.dart';
import '../models/movie.dart';

class AddMovieScreen extends StatefulWidget {
  const AddMovieScreen({super.key});

  @override
  State<AddMovieScreen> createState() => _AddMovieScreenState();
}

class _AddMovieScreenState extends State<AddMovieScreen> {
  final _formKey = GlobalKey<FormState>();

  final _titleController = TextEditingController();
  final _yearController = TextEditingController();
  final _directorController = TextEditingController();
  final _genreController = TextEditingController();
  final _synopsisController = TextEditingController();
  final _imageUrlController = TextEditingController();

  void _saveMovie() {
    if (_formKey.currentState!.validate()) {
      final movie = Movie(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        title: _titleController.text,
        year: int.tryParse(_yearController.text) ?? 0,
        director: _directorController.text,
        genre: _genreController.text,
        synopsis: _synopsisController.text,
        imageUrl: _imageUrlController.text,
      );

      // 👇 Clave: REGRESAMOS la película a la pantalla anterior
      Navigator.pop(context, movie);
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _yearController.dispose();
    _directorController.dispose();
    _genreController.dispose();
    _synopsisController.dispose();
    _imageUrlController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Agregar película'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(labelText: 'Título'),
                validator: (value) =>
                    value == null || value.isEmpty ? 'Ingresa un título' : null,
              ),
              TextFormField(
                controller: _yearController,
                decoration: const InputDecoration(labelText: 'Año'),
                keyboardType: TextInputType.number,
                validator: (value) =>
                    value == null || value.isEmpty ? 'Ingresa el año' : null,
              ),
              TextFormField(
                controller: _directorController,
                decoration: const InputDecoration(labelText: 'Director'),
                validator: (value) =>
                    value == null || value.isEmpty ? 'Ingresa el director' : null,
              ),
              TextFormField(
                controller: _genreController,
                decoration: const InputDecoration(labelText: 'Género'),
                validator: (value) =>
                    value == null || value.isEmpty ? 'Ingresa el género' : null,
              ),
              TextFormField(
                controller: _synopsisController,
                decoration: const InputDecoration(labelText: 'Sinopsis'),
                maxLines: 3,
                validator: (value) =>
                    value == null || value.isEmpty ? 'Ingresa la sinopsis' : null,
              ),
              TextFormField(
                controller: _imageUrlController,
                decoration:
                    const InputDecoration(labelText: 'URL de la imagen'),
                validator: (value) => value == null || value.isEmpty
                    ? 'Ingresa la URL de la imagen'
                    : null,
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _saveMovie,
                  child: const Text('Guardar película'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
