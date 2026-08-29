import 'package:flutter/widgets.dart';

import 'assincrona.dart';
import 'sequencial.dart';

void main() {
  runApp(const TelaComeco());
}

class TelaComeco extends StatefulWidget {
  const TelaComeco({super.key});

  @override
  State<TelaComeco> createState() {
    return TelaComecoEstado();
  }
}

class TelaComecoEstado extends State<TelaComeco> {
  Widget telaAtual = const MenuPrincipal();

  void abrirTela(Widget tela) {
    setState(() {
      telaAtual = tela;
    });
  }

  void voltarMenu() {
    setState(() {
      telaAtual = const MenuPrincipal();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: telaAtual is MenuPrincipal
          ? MenuPrincipal(
              abrirSequencial: () {
                abrirTela(
                  TelaSequencial(
                    voltar: voltarMenu,
                  ),
                );
              },
              abrirAssincrona: () {
                abrirTela(
                  TelaAssincrona(
                    voltar: voltarMenu,
                  ),
                );
              },
            )
          : telaAtual,
    );
  }
}



////////
// Menu Principal
////////

class MenuPrincipal extends StatelessWidget {
  final VoidCallback? abrirSequencial;
  final VoidCallback? abrirAssincrona;

  const MenuPrincipal({
    super.key,
    this.abrirSequencial,
    this.abrirAssincrona,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      color: const Color(0xFF202020),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          GestureDetector(
            onTap: abrirSequencial,
            child: const Padding(
              padding: EdgeInsets.all(20),
              child: Text(
                'Executar sequencial',
                style: TextStyle(
                  fontSize: 24,
                  color: Color(0xFFFFFFFF),
                ),
              ),
            ),
          ),

          const SizedBox(height: 20),

          GestureDetector(
            onTap: abrirAssincrona,
            child: const Padding(
              padding: EdgeInsets.all(20),
              child: Text(
                'Executar assíncrono',
                style: TextStyle(
                  fontSize: 24,
                  color: Color(0xFFFFFFFF),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}


//////
// Sequencial
//////

class TelaSequencial extends StatelessWidget {
  final VoidCallback voltar;

  const TelaSequencial({
    super.key,
    required this.voltar,
  });

  String formatarResultado(
    (DateTime, DateTime, Duration) resultado,
  ) {
    return '${resultado.$1} - ${resultado.$2} - ${resultado.$3}';
  }

  @override
  Widget build(BuildContext context) {
    final resultados = sequencial(100);

    return Container(
      padding: const EdgeInsets.all(20),
      color: const Color(0xFF202020),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: voltar,
            child: const Text(
              '< Voltar',
              style: TextStyle(
                fontSize: 18,
                color: Color(0xFF80CBC4),
              ),
            ),
          ),

          const SizedBox(height: 30),

          Text(
            formatarResultado(resultados.$1),
            style: const TextStyle(
              fontSize: 16,
              color: Color(0xFFFFFFFF),
            ),
          ),

          const SizedBox(height: 16),

          Text(
            formatarResultado(resultados.$2),
            style: const TextStyle(
              fontSize: 16,
              color: Color(0xFFFFFFFF),
            ),
          ),

          const SizedBox(height: 16),

          Text(
            formatarResultado(resultados.$3),
            style: const TextStyle(
              fontSize: 16,
              color: Color(0xFFFFFFFF),
            ),
          ),
        ],
      ),
    );
  }
}




////////
// Assincrona
////////

class TelaAssincrona extends StatefulWidget {
  final VoidCallback voltar;

  const TelaAssincrona({
    super.key,
    required this.voltar,
  });

  @override
  State<TelaAssincrona> createState() {
    return TelaAssincronaEstado();
  }
}

class TelaAssincronaEstado extends State<TelaAssincrona> {
  late Future<
      (
        (DateTime, DateTime, Duration),
        (DateTime, DateTime, Duration),
        (DateTime, DateTime, Duration),
      )> resultado;

  @override
  void initState() {
    super.initState();

    resultado = assincrona(100);
  }

  String formatarResultado(
    (DateTime, DateTime, Duration) resultado,
  ) {
    return '${resultado.$1} - ${resultado.$2} - ${resultado.$3}';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      color: const Color(0xFF202020),
      child: FutureBuilder<
          (
            (DateTime, DateTime, Duration),
            (DateTime, DateTime, Duration),
            (DateTime, DateTime, Duration),
          )>(
        future: resultado,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text(
              'Executando...',
              style: TextStyle(
                fontSize: 20,
                color: Color(0xFFFFFFFF),
              ),
            );
          }

          if (snapshot.hasError) {
            return Text(
              'Erro: ${snapshot.error}',
              style: const TextStyle(
                fontSize: 18,
                color: Color(0xFFFF5252),
              ),
            );
          }

          if (!snapshot.hasData) {
            return const Text(
              'Nenhum resultado encontrado.',
              style: TextStyle(
                fontSize: 18,
                color: Color(0xFFFFFFFF),
              ),
            );
          }

          final resultados = snapshot.data!;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: widget.voltar,
                child: const Text(
                  '< Voltar',
                  style: TextStyle(
                    fontSize: 18,
                    color: Color(0xFF80CBC4),
                  ),
                ),
              ),

              const SizedBox(height: 30),

              Text(
                formatarResultado(resultados.$1),
                style: const TextStyle(
                  fontSize: 16,
                  color: Color(0xFFFFFFFF),
                ),
              ),

              const SizedBox(height: 16),

              Text(
                formatarResultado(resultados.$2),
                style: const TextStyle(
                  fontSize: 16,
                  color: Color(0xFFFFFFFF),
                ),
              ),

              const SizedBox(height: 16),

              Text(
                formatarResultado(resultados.$3),
                style: const TextStyle(
                  fontSize: 16,
                  color: Color(0xFFFFFFFF),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
