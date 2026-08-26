import 'package:flutter/material.dart';

main(){
runApp( TelaInicio(texto1: "T1", texto2: "T2") );
}



//////////////////////////////////////////////////////////////


/*
class Tela extends StatelessWidget {

// Inicio Variaveis
final String texto1;
final String texto2;

const Tela({Key? key, required this.texto1,required this.texto2}): super(key:key);
// Fim Variaveis

@override
Widget build(BuildContext context) {
	return TelaInicio(texto1: texto1, texto2: texto2);
						
} // Build
}
*/


//////////////////////////////////////////////////////////////



class TelaInicio extends StatefulWidget {

// Inicio Variaveis
final String texto1;
final String texto2;

const TelaInicio({Key? key, required this.texto1,required this.texto2}): super(key:key);
// Fim Variaveis

@override
State<TelaInicio> createState() { return TelaInicioEstado(); }
}



class TelaInicioEstado extends State<TelaInicio> {


// Inicio Variaveis
//final String texto1;
//final String texto2;
int contador = 0;

//let TelaInicioEstado({required this.texto1,required this.texto2});
// Fim Variaveis


@override
Widget build(BuildContext context) {
	return Container(


			child: GestureDetector(
			
			child: Text(
			"${widget.texto1} -- $contador",
			textDirection: TextDirection.ltr,
			style: TextStyle(
				color: Colors.yellow, backgroundColor: Colors.blue, fontSize: 50.0
				) // EstiloTexto




			), // Texto			
			
			onTap: () { setState((){
						contador = contador+1; print(contador); });
						} // Toque
			
			), // Clicável
			
			
			body: Container()
			
			
			
			); // Container
						
} // Build

}