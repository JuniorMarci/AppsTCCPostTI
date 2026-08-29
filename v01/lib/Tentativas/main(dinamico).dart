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

class TelaComeco extends StatefulWidget {
  const TelaComeco({super.key});

  @override
  State<TelaComeco> createState() => _TelaComecoState();
}

class _TelaComecoState extends State<TelaComeco> {
  int limite = 1000;

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
            const Text(
              'Quantidade de iterações:',
              style: TextStyle(fontSize: 18),
            ),

            const SizedBox(height: 8),

            DropdownButton<int>(
              value: limite,
              isExpanded: true,
              items: const [
                DropdownMenuItem(
                  value: 1000,
                  child: Text('1.000'),
                ),
                DropdownMenuItem(
                  value: 10000,
                  child: Text('10.000'),
                ),
                DropdownMenuItem(
                  value: 100000,
                  child: Text('100.000'),
                ),
                DropdownMenuItem(
                  value: 1000000,
                  child: Text('1.000.000'),
                ),
              ],
              onChanged: (valor) {
                if (valor != null) {
                  setState(() {
                    limite = valor;
                  });
                }
              },
            ),

            const SizedBox(height: 30),

            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => TelaSequencial(
                      limite: limite,
                    ),
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
                    builder: (_) => TelaAssincrona(
                      limite: limite,
                    ),
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


/////////////
//// Sequencial
/////////////

class TelaSequencial extends StatelessWidget {
  final int limite;

  const TelaSequencial({
    super.key,
    required this.limite,
  });

  String formatarResultado(
    (DateTime, DateTime, Duration) resultado,
  ) {
    return '${resultado.$1} - ${resultado.$2} - ${resultado.$3}';
  }

  @override
  Widget build(BuildContext context) {
    final resultados = sequencial(limite);

    return Scaffold(
      appBar: AppBar(
        title: Text('Sequencial - $limite iterações'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(formatarResultado(resultados.$1)),
            const SizedBox(height: 16),
            Text(formatarResultado(resultados.$2)),
            const SizedBox(height: 16),
            Text(formatarResultado(resultados.$3)),
          ],
        ),
      ),
    );
  }
}



//////////
// Assincrono
//////////

class TelaAssincrona extends StatelessWidget {
  final int limite;

  const TelaAssincrona({
    super.key,
    required this.limite,
  });

  String formatarResultado(
    (DateTime, DateTime, Duration) resultado,
  ) {
    return '${resultado.$1} - ${resultado.$2} - ${resultado.$3}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Assíncrono - $limite iterações'),
      ),
      body: FutureBuilder<
          (
            (DateTime, DateTime, Duration),
            (DateTime, DateTime, Duration),
            (DateTime, DateTime, Duration),
          )>(
        future: assincrona(limite),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Text('Erro: ${snapshot.error}'),
            );
          }

          if (!snapshot.hasData) {
            return const Center(
              child: Text('Nenhum resultado.'),
            );
          }

          final resultados = snapshot.data!;

          return Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(formatarResultado(resultados.$1)),
                const SizedBox(height: 16),
                Text(formatarResultado(resultados.$2)),
                const SizedBox(height: 16),
                Text(formatarResultado(resultados.$3)),
              ],
            ),
          );
        },
      ),
    );
  }
}
