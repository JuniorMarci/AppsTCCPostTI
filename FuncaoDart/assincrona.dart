import 'dart:isolate';
import 'f.dart';

Future<(
  (DateTime, DateTime, Duration),
  (DateTime, DateTime, Duration),
  (DateTime, DateTime, Duration),
)> assincrona() async {
  final futuros = [
    Isolate.run(() => f(1)),
    Isolate.run(() => f(2)),
    Isolate.run(() => f(3)),
  ];

  final resultados = await Future.wait(futuros);

  return (
    resultados[0],
    resultados[1],
    resultados[2],
  );
}
