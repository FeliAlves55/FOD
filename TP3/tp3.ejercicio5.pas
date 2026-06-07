{5. Una cadena de tiendas de indumentaria dispone de un archivo maestro no ordenado que
contiene la información de las prendas que se encuentran a la venta. 

De cada prenda se registran los siguientes datos: cod_prenda, descripción, colores, tipo_prenda, stock y precio_unitario.
Debido a un cambio de temporada, es necesario actualizar las prendas disponibles. Para ello, se
recibe un archivo detalle que contiene los códigos (cod_prenda) de aquellas prendas que
quedarán obsoletas. 


Se deberá implementar un procedimiento que reciba ambos archivos y realice la baja lógica de las prendas indicadas; para ello, se deberá modificar el campo stock de la
prenda correspondiente asignándole un valor negativo como marca de eliminación.


Adicionalmente, se deberá implementar otro procedimiento que permita efectivizar las bajas
lógicas realizadas sobre el archivo maestro. Para ello, se deberá crear un archivo auxiliar en el cual
se copien únicamente aquellas prendas que no estén marcadas como eliminadas (es decir,
aquellas cuyo stock sea mayor o igual a cero).

Finalmente, una vez completado el proceso de compactación, el archivo auxiliar deberá
reemplazar al archivo maestro original, adoptando su mismo nombre.
}
program punto5;
const
	valorAlto:9999;
type
	prenda=record
		cod:integer;
		descr:String;
		colores:String;
		tipo:String;
		stock:integer;
		precio:real;
		end;
		
	maestro = file of prenda;
	detalle = file of integer;
	
procedure leer(var d:detalle; var p:integer);
begin
	if(not EOF(d)) then begin
		read(d,p)
	else
			p.cod := valorAlto;
	end;
end;

procedure bajasLogicas(var m:maestro; var d:detalle);
var
	pM:prenda;
	p:integer;
	encontrado:boolean;
begin
	reset(a);reset(d);
	leer(d,p);
	while(p.cod <> valorAlto) do begin
		seek(m,0);
		encontrado:=false;
		while(not EOF(m)) and (not encontrado) do begin
			read(m,pM);
			if(p.cod = pM.cod) then begin
				encontrado:=true;
				pM.stock:=-1;
				seek(m,filePos(m)-1);
				write(m,pM);
			end;
		end;
		leer(d,p);
	end;
end;

procedure nuevoArchivo(var m:maestro);
var
	nue:meastro;
	aux:prenda;
begin
	assign(nue,'Nuevo Archivo');
	rewrite(nue);
	seek(m,0);
	
	while(not EOF(m)) do begin
		read(m,aux);
		if(aux.cod >=0) then
			write(nue,aux);
		end;
	close(m);close(aux);
	
	{ Reemplazo físico en el disco }
    erase(m); { Borra el archivo viejo con stock negativo }
    rename(aux, 'archivo_maestro.dat'); { El auxiliar toma el nombre del original }
    
    { Volvemos a asociar la variable 'm' con el nombre original por si se usa más adelante }
    assign(m, 'archivo_maestro.dat');
end;
	
			

