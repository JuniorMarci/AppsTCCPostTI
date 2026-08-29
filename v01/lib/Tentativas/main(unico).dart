import 'package:flutter/material.dart';

import 'assincrona.dart';
import 'sequencial.dart';

void main() {
  runApp(const MeuAplicativo());
}

class MeuAplicativo extends StatelessWidget {
  const MeuAplicativo({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Execução de funções',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const TelaComeco(),
    );
  }
}

class TelaComeco extends StatelessWidget {
  const TelaComeco({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tela Começo'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const TelaSequencial(),
                  ),
                );
              },
              child: Card(
                child: const Padding(
                  padding: EdgeInsets.all(20),
                  child: Text(
                    'Executar sequencial',
                    style: TextStyle(fontSize: 24),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),

            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const TelaAssincrona(),
                  ),
                );
              },
              child: Card(
                child: const Padding(
                  padding: EdgeInsets.all(20),
                  child: Text(
                    'Executar assíncrono',
                    style: TextStyle(fontSize: 24),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}






///////////////////////
//// Tela Sequencial
///////////////////////

class TelaSequencial extends StatelessWidget {
  const TelaSequencial({super.key});

  String formatarResultado(
    (DateTime, DateTime, Duration) resultado,
  ) {
    return '${resultado.$1} - ${resultado.$2} - ${resultado.$3}';
  }

  @override
  Widget build(BuildContext context) {
    final resultados = sequencial();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Execução sequencial'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              formatarResultado(resultados.$1),
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),

            Text(
              formatarResultado(resultados.$2),
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),

            Text(
              formatarResultado(resultados.$3),
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}





///////////////////////
//// Tela Assincrona
///////////////////////

class TelaAssincrona extends StatelessWidget {
  const TelaAssincrona({super.key});

  String formatarResultado(
    (DateTime, DateTime, Duration) resultado,
  ) {
    return '${resultado.$1} - ${resultado.$2} - ${resultado.$3}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Execução assíncrona'),
      ),
      body: FutureBuilder<
          (
            (DateTime, DateTime, Duration),
            (DateTime, DateTime, Duration),
            (DateTime, DateTime, Duration),
          )>(
        future: assincrona(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Text(
                'Erro: ${snapshot.error}',
                style: const TextStyle(color: Colors.red),
              ),
            );
          }

          if (!snapshot.hasData) {
            return const Center(
              child: Text('Nenhum resultado encontrado.'),
            );
          }

          final resultados = snapshot.data!;

          return Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  formatarResultado(resultados.$1),
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 16),

                Text(
                  formatarResultado(resultados.$2),
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 16),

                Text(
                  formatarResultado(resultados.$3),
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
