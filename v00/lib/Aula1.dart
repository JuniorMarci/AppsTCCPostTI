import 'package:flutter/material.dart';

main(){
runApp( Tela(texto1: "Tex1", texto2: "T2") );
}


class Tela extends StatelessWidget {

// Inicio Variaveis
final String texto1;
final String? texto2;

const Tela({Key? key, required this.texto1, this.texto2}): super(key:key);
// Fim Variaveis

@override
Widget build(BuildContext context) {
	return Container(

			child: GestureDetector(
			
			child: Text(
			"texto1",
			textDirection: TextDirection.ltr,
			style: TextStyle(
				color: Colors.yellow, backgroundColor: Colors.blue, fontSize: 50.0
				) // EstiloTexto
			), // Texto			
			
			onTap: () { print("OK"); }
			) // Clicável
			
			
			); // Container
			
} // Build
}