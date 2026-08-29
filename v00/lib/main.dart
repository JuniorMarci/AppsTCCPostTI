import 'package:flutter/material.dart';

main(){
runApp( TelaInicio(texto1: "T1", texto2: "T2") );
}





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
int contador1 = 0;
int contador2 = 0;

//let TelaInicioEstado({required this.texto1,required this.texto2});
// Fim Variaveis


@override
Widget build(BuildContext context) {
	return Container(
     padding: const EdgeInsets.all(20),
	   child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
	  
	  Column(children: [
		GestureDetector(
			
			child: Text(
          "${widget.texto1} -- teste",
          textDirection: TextDirection.ltr,
          style: TextStyle(fontSize: 32, color: Colors.white)
		  ), // Texto 1
		  
		  onTap: () { setState((){
						contador1 = contador1+1; print("Cont1 $contador1"); });
						} // Toque
		  ),
		  
		Text(
          "${widget.texto2} -- outra linha",
          textDirection: TextDirection.ltr,
          style: TextStyle(fontSize: 32, color: Colors.yellow)
		  ), // Texto 2
		  
			]) // Lista Column
	  
	  ]) //Row
    ); // Container
  } // Build
} // Classe
