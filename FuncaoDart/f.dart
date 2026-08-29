(DateTime,DateTime,Duration) f(int ordem) {
var inicio = DateTime.now();
for (var i=0;i<1000;i++){
	print("$ordem - $i");
	}
var fim = DateTime.now();
var dif = fim.difference(inicio);
return (inicio,fim,dif);
}