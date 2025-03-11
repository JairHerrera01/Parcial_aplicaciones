import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Contador de Palabras',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const ContadorPalabras(),
    );
  }
}

class ContadorPalabras extends StatefulWidget {
  const ContadorPalabras({super.key});

  @override
  State<ContadorPalabras> createState() => _ContadorPalabrasState();
}

class _ContadorPalabrasState extends State<ContadorPalabras> {
  final TextEditingController _controller = TextEditingController();
  Map<String, int> _contadorPalabras = {};

  void _contarPalabras() {
    String texto = _controller.text.toLowerCase();
    
    // Eliminar caracteres especiales y normalizar texto
    texto = texto.replaceAll(RegExp(r'[^\w\s]'), '');
    texto = texto.replaceAll('á', 'a');
    texto = texto.replaceAll('é', 'e');
    texto = texto.replaceAll('í', 'i');
    texto = texto.replaceAll('ó', 'o');
    texto = texto.replaceAll('ú', 'u');
    
    // Dividir el texto en palabras
    List<String> palabras = texto.split(RegExp(r'\s+'))
        .where((palabra) => palabra.isNotEmpty)
        .toList();
    
    // Contar frecuencia de palabras
    Map<String, int> contador = {};
    for (var palabra in palabras) {
      contador[palabra] = (contador[palabra] ?? 0) + 1;
    }
    
    setState(() {
      _contadorPalabras = contador;
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contador de Palabras'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              maxLines: 5,
              decoration: InputDecoration(
                hintText: 'Ingresa tu texto aquí...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                filled: true,
                fillColor: Colors.grey[200],
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _contarPalabras,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              ),
              child: const Text(
                'Contar Palabras',
                style: TextStyle(color: Colors.white),
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: _contadorPalabras.isEmpty
                  ? const Center(
                      child: Text(
                        'Ingresa un texto y presiona el botón para ver el conteo',
                        textAlign: TextAlign.center,
                      ),
                    )
                  : ListView.builder(
                      itemCount: _contadorPalabras.length,
                      itemBuilder: (context, index) {
                        String palabra = _contadorPalabras.keys.elementAt(index);
                        int cantidad = _contadorPalabras[palabra]!;
                        return Card(
                          margin: const EdgeInsets.symmetric(vertical: 4),
                          child: ListTile(
                            title: Text(palabra),
                            trailing: Text(
                              '$cantidad',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
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
