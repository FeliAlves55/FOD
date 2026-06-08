{6. Se cuenta con un archivo que almacena información sobre especies de aves en peligro de
extinción. De cada especie se registran los siguientes datos: código, nombre de la especie, familia,
descripción y zona geográfica. 



El archivo no se encuentra ordenado por ningún criterio.
Se desea desarrollar un programa que permita eliminar especies de aves extintas. Para ello, el
programa deberá contar con dos procedimientos:


Un procedimiento que, dado el código de una especie, la marque como borrada (baja lógica). En
caso de querer eliminar múltiples especies, este procedimiento podrá invocarse repetidamente.


Un procedimiento que realice la compactación del archivo (baja física), eliminando
definitivamente aquellas especies marcadas como borradas. Para ello, cada vez que se elimine un
registro, se deberá reemplazar su posición con el último registro del archivo y luego eliminar dicho
último registro, evitando así dejar espacios vacíos y registros duplicados.


Implemente además una variante de este procedimiento de compactación en la cual el archivo
sea truncado una única vez al finalizar el proceso}

program ejer6;
type 
	especie = record
		cod:integer;
		nombre:String[20];
		familia:String[20];
		descr:String[40];
		zona:String[40];
		end;
		
	archivo = file of especie;
	
procedure borrarEspecie (var a:archivo; cod:integer);
var
	reg:especie;
	ok:boolean;
begin
	reset(a);
	seek(a,0);
	ok:=false;
	while(not EOF(a)) and (not ok) do begin
		read(a,reg);
		if(reg.cod = cod) then begin
			ok:=true;
			reg.cod:=-1;
			end;
		end;
	if(ok) then begin
		seek(a,filePos(a)-1);
		write(a,reg);
		end;
	close(a);
end;

procedure comparctarArchivo (var a:archivo);
var
	reg,ulti:especie;
	pos:integer;
begin
	reset(a);
	while(not EOF(a)) do begin
		read(a,reg);
		if(reg.cod = -1) then begin
			pos:= filePos(a) -1;
			
			seek(a,fileSize(a)-1);
			read(a,ulti);
			
			
			seek(a,pos);
			write(a,ulti);
			
			seek(a,fileSize(a)-1);
			truncate(a);
			
			seek(a,pos);
			end;
		end;
	close(a);
end;
			
	
	
	
	
	
	
