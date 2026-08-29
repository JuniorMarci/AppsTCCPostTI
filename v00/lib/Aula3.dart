import 'package:flutter/material.dart';

main(){
runApp( MyApp() );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
     padding: const EdgeInsets.all(20),
	   child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
	  
	  Column(children: [
		const Text(
          'World',
          textDirection: TextDirection.ltr,
          style: TextStyle(fontSize: 32, color: Colors.white)
		  ), // Texto 1
		  
		const Text(
          'Ufaa',
          textDirection: TextDirection.ltr,
          style: TextStyle(fontSize: 32, color: Colors.yellow)
		  ), // Texto 2
		  
			]) // Lista Column
	  
	  ]) //Row
    ); // Container
  } // Build
} // Classe
