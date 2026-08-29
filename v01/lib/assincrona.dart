import 'dart:isolate';
import 'f.dart';

Future<(
  (DateTime, DateTime, Duration),
  (DateTime, DateTime, Duration),
  (DateTime, DateTime, Duration),
)> assincrona(int limite) async {
  final futuros = [
    Isolate.run(() => f(1,limite)),
    Isolate.run(() => f(2,limite)),
    Isolate.run(() => f(3,limite)),
  ];

  final resultados = await Future.wait(futuros);

  return (
    resultados[0],
    resultados[1],
    resultados[2],
  );
}
