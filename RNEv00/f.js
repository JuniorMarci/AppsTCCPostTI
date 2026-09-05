export function f(ordem, limite) {
  const inicio = new Date();
  let valor = 0x12345678;

  for (let i = 0; i < Math.pow(limite, 1.8); i++) {
    valor = _hash(valor, i + ordem);
  }
	
  const fim = new Date();

  // Impede que o compilador considere o cálculo descartável
  if (valor === -1) {
    console.log(`Resultado improvável: ${valor}`);
  }

  const r = {
    "inicio": inicio.toJSON(),
    "fim": fim.toJSON(),
    "duracao": fim - inicio // em milissegundos
  }
  
  return r;//{"inicio":1000};
}

function _hash(valor, entrada) {
  let resultado = valor ^ entrada;

  resultado = (resultado * 0x45d9f3b) & 0xFFFFFFFF;
  resultado ^= resultado >> 16;
  resultado = (resultado * 0x45d9f3b) & 0xFFFFFFFF;
  resultado ^= resultado >> 16;

  return resultado;
}
