import 'package:flutter/widgets.dart';

import 'assincrona.dart';
import 'sequencial.dart';

void main() {
  runApp(const MeuAplicativo());
}

// Um resultado individual
typedef Resultado = (
  DateTime,
  DateTime,
  Duration,
);

// Conjunto dos três resultados
typedef Resultados = (
  Resultado,
  Resultado,
  Resultado,
);

enum TipoExecucao {
  sequencial,
  assincrona,
}

enum TelaAtual {
  menu,
  configuracao,
  resultado,
}

class MeuAplicativo extends StatefulWidget {
  const MeuAplicativo({super.key});

  @override
  State<MeuAplicativo> createState() {
    return MeuAplicativoEstado();
  }
}

class MeuAplicativoEstado extends State<MeuAplicativo> {
  TelaAtual telaAtual = TelaAtual.menu;

  TipoExecucao? tipoExecucao;

  int quantidade = 100;

  void abrirConfiguracao(TipoExecucao tipo) {
    setState(() {
      tipoExecucao = tipo;
      quantidade = 100;
      telaAtual = TelaAtual.configuracao;
    });
  }

  void iniciarExecucao() {
    setState(() {
      telaAtual = TelaAtual.resultado;
    });
  }

  void alterarQuantidade(int valor) {
    setState(() {
      quantidade = valor;
    });
  }

  void voltarMenu() {
    setState(() {
      telaAtual = TelaAtual.menu;
      tipoExecucao = null;
    });
  }

  void voltarConfiguracao() {
    setState(() {
      telaAtual = TelaAtual.configuracao;
    });
  }

  Widget construirTela() {
    if (telaAtual == TelaAtual.menu) {
      return MenuPrincipal(
        abrirSequencial: () {
          abrirConfiguracao(TipoExecucao.sequencial);
        },
        abrirAssincrona: () {
          abrirConfiguracao(TipoExecucao.assincrona);
        },
      );
    }

    if (telaAtual == TelaAtual.configuracao) {
      return TelaConfiguracao(
        tipo: tipoExecucao!,
        quantidade: quantidade,
        alterarQuantidade: alterarQuantidade,
        iniciar: iniciarExecucao,
        voltar: voltarMenu,
      );
    }

    if (tipoExecucao == TipoExecucao.sequencial) {
      return TelaResultadoSequencial(
        quantidade: quantidade,
        voltar: voltarConfiguracao,
      );
    }

    return TelaResultadoAssincrona(
      quantidade: quantidade,
      voltar: voltarConfiguracao,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: construirTela(),
    );
  }
}

// ------------------------------------------------------------
// MENU PRINCIPAL
// ------------------------------------------------------------

class MenuPrincipal extends StatelessWidget {
  final VoidCallback abrirSequencial;
  final VoidCallback abrirAssincrona;

  const MenuPrincipal({
    super.key,
    required this.abrirSequencial,
    required this.abrirAssincrona,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      color: const Color(0xFF202020),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          BotaoTexto(
            texto: 'Executar sequencial',
            onTap: abrirSequencial,
            cor: const Color(0xFFFFFFFF),
            tamanho: 24,
          ),

          const SizedBox(height: 20),

          BotaoTexto(
            texto: 'Executar assíncrono',
            onTap: abrirAssincrona,
            cor: const Color(0xFFFFFFFF),
            tamanho: 24,
          ),
        ],
      ),
    );
  }
}

// ------------------------------------------------------------
// TELA DE CONFIGURAÇÃO
// ------------------------------------------------------------

class TelaConfiguracao extends StatelessWidget {
  final TipoExecucao tipo;
  final int quantidade;
  final ValueChanged<int> alterarQuantidade;
  final VoidCallback iniciar;
  final VoidCallback voltar;

  const TelaConfiguracao({
    super.key,
    required this.tipo,
    required this.quantidade,
    required this.alterarQuantidade,
    required this.iniciar,
    required this.voltar,
  });

  @override
  Widget build(BuildContext context) {
    final String nomeExecucao = tipo == TipoExecucao.sequencial
        ? 'Sequencial'
        : 'Assíncrona';

    return Container(
      padding: const EdgeInsets.all(20),
      color: const Color(0xFF202020),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BotaoTexto(
            texto: '< Voltar',
            onTap: voltar,
            cor: const Color(0xFF80CBC4),
            tamanho: 18,
          ),

          const SizedBox(height: 30),

          Text(
            'Execução $nomeExecucao',
            style: const TextStyle(
              fontSize: 24,
              color: Color(0xFFFFFFFF),
            ),
          ),

          const SizedBox(height: 25),

          const Text(
            'Escolha a quantidade:',
            style: TextStyle(
              fontSize: 18,
              color: Color(0xFFFFFFFF),
            ),
          ),

          const SizedBox(height: 15),

          LinhaQuantidade(
            texto: '100',
            selecionada: quantidade == 100,
            onTap: () {
              alterarQuantidade(100);
            },
          ),

          LinhaQuantidade(
            texto: '1 000',
            selecionada: quantidade == 1000,
            onTap: () {
              alterarQuantidade(1000);
            },
          ),

          LinhaQuantidade(
            texto: '10 000',
            selecionada: quantidade == 10000,
            onTap: () {
              alterarQuantidade(10000);
            },
          ),
		  
          LinhaQuantidade(
            texto: '100 000',
            selecionada: quantidade == 100000,
            onTap: () {
              alterarQuantidade(100000);
            },
          ),
		  
          LinhaQuantidade(
            texto: '130 000',
            selecionada: quantidade == 130000,
            onTap: () {
              alterarQuantidade(130000);
            },
          ),

          const SizedBox(height: 25),

          Text(
            'Quantidade selecionada: $quantidade',
            style: const TextStyle(
              fontSize: 18,
              color: Color(0xFFFFEB3B),
            ),
          ),

          const SizedBox(height: 25),

          BotaoTexto(
            texto: 'Iniciar execução',
            onTap: iniciar,
            cor: const Color(0xFF80CBC4),
            tamanho: 20,
          ),
        ],
      ),
    );
  }
}

// ------------------------------------------------------------
// LINHA DE QUANTIDADE
// ------------------------------------------------------------

class LinhaQuantidade extends StatelessWidget {
  final String texto;
  final bool selecionada;
  final VoidCallback onTap;

  const LinhaQuantidade({
    super.key,
    required this.texto,
    required this.selecionada,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Text(
          selecionada ? '[$texto]' : texto,
          style: TextStyle(
            fontSize: 20,
            color: selecionada
                ? const Color(0xFFFFEB3B)
                : const Color(0xFFFFFFFF),
          ),
        ),
      ),
    );
  }
}

// ------------------------------------------------------------
// BOTÃO DE TEXTO
// ------------------------------------------------------------

class BotaoTexto extends StatelessWidget {
  final String texto;
  final VoidCallback onTap;
  final Color cor;
  final double tamanho;

  const BotaoTexto({
    super.key,
    required this.texto,
    required this.onTap,
    required this.cor,
    required this.tamanho,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Text(
          texto,
          style: TextStyle(
            fontSize: tamanho,
            color: cor,
          ),
        ),
      ),
    );
  }
}

// ------------------------------------------------------------
// RESULTADO SEQUENCIAL
// ------------------------------------------------------------

class TelaResultadoSequencial extends StatefulWidget {
  final int quantidade;
  final VoidCallback voltar;

  const TelaResultadoSequencial({
    super.key,
    required this.quantidade,
    required this.voltar,
  });

  @override
  State<TelaResultadoSequencial> createState() {
    return TelaResultadoSequencialEstado();
  }
}

class TelaResultadoSequencialEstado
    extends State<TelaResultadoSequencial> {
  late final Resultados resultados;

  @override
  void initState() {
    super.initState();

    resultados = sequencial(widget.quantidade);
  }

  String formatarResultado(Resultado resultado) {
    return '${resultado.$1} - ${resultado.$2} - ${resultado.$3}';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      color: const Color(0xFF202020),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BotaoTexto(
            texto: '< Voltar',
            onTap: widget.voltar,
            cor: const Color(0xFF80CBC4),
            tamanho: 18,
          ),

          const SizedBox(height: 30),

          Text(
            formatarResultado(resultados.$1),
            style: const TextStyle(
              color: Color(0xFFFFFFFF),
            ),
          ),

          const SizedBox(height: 16),

          Text(
            formatarResultado(resultados.$2),
            style: const TextStyle(
              color: Color(0xFFFFFFFF),
            ),
          ),

          const SizedBox(height: 16),

          Text(
            formatarResultado(resultados.$3),
            style: const TextStyle(
              color: Color(0xFFFFFFFF),
            ),
          ),
        ],
      ),
    );
  }
}

// ------------------------------------------------------------
// RESULTADO ASSÍNCRONO
// ------------------------------------------------------------

class TelaResultadoAssincrona extends StatefulWidget {
  final int quantidade;
  final VoidCallback voltar;

  const TelaResultadoAssincrona({
    super.key,
    required this.quantidade,
    required this.voltar,
  });

  @override
  State<TelaResultadoAssincrona> createState() {
    return TelaResultadoAssincronaEstado();
  }
}

class TelaResultadoAssincronaEstado
    extends State<TelaResultadoAssincrona> {
  late final Future<Resultados> resultado;

  @override
  void initState() {
    super.initState();

    resultado = assincrona(widget.quantidade);
  }

  String formatarResultado(Resultado resultado) {
    return '${resultado.$1} - ${resultado.$2} - ${resultado.$3}';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      color: const Color(0xFF202020),
      child: FutureBuilder<Resultados>(
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
              'Nenhum resultado.',
              style: TextStyle(
                fontSize: 18,
                color: Color(0xFFFFFFFF),
              ),
            );
          }

          final Resultados resultados = snapshot.data!;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BotaoTexto(
                texto: '< Voltar',
                onTap: widget.voltar,
                cor: const Color(0xFF80CBC4),
                tamanho: 18,
              ),

              const SizedBox(height: 30),

              Text(
                formatarResultado(resultados.$1),
                style: const TextStyle(
                  color: Color(0xFFFFFFFF),
                ),
              ),

              const SizedBox(height: 16),

              Text(
                formatarResultado(resultados.$2),
                style: const TextStyle(
                  color: Color(0xFFFFFFFF),
                ),
              ),

              const SizedBox(height: 16),

              Text(
                formatarResultado(resultados.$3),
                style: const TextStyle(
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
