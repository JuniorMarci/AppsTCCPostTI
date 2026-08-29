import 'dart:typed_data';
import 'dart:math';

typedef Resultado = (DateTime, DateTime, Duration);

Resultado f(int ordem, int limite) {
  final inicio = DateTime.now();

  var valor = 0x12345678;

  for (var i = 0; i < pow(limite,1.8); i++) {
    valor = _hash(valor, i + ordem);
  }

  final fim = DateTime.now();

  // Impede que o compilador considere o cálculo descartável.
  if (valor == -1) {
    print('Resultado improvável: $valor');
  }

  return (
    inicio,
    fim,
    fim.difference(inicio),
  );
}

int _hash(int valor, int entrada) {
  var resultado = valor ^ entrada;

  resultado = (resultado * 0x45d9f3b) & 0xFFFFFFFF;
  resultado ^= resultado >> 16;
  resultado = (resultado * 0x45d9f3b) & 0xFFFFFFFF;
  resultado ^= resultado >> 16;

  return resultado;
}



/*
(DateTime,DateTime,Duration) f(int ordem, int limite) {
var inicio = DateTime.now();
for (var i=0;i<limite;i++){
	print("$ordem - $i");
	}
var fim = DateTime.now();
var dif = fim.difference(inicio);
return (inicio,fim,dif);
}
*/