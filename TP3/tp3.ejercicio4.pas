{Se desea implementar un sistema de gestión de flores utilizando un archivo con reutilización de
espacio.
● Las bajas lógicas se realizan apilando los registros eliminados.
● Las altas deben reutilizar los espacios libres disponibles antes de agregar nuevos registros al final
del archivo.
● El registro en la posición 0 se utiliza como cabecera de la pila de registros borrados.
Política de reutilización:
	● Si el campo código del registro cabecera es 0, significa que no hay registros borrados
	disponibles.
	● Si el campo código es -N, indica que el próximo registro libre se encuentra en la posición N del
	archivo.
	● Cada registro borrado debe almacenar en su campo codigo el valor negativo que apunte al
	siguiente registro libre, formando así una pila enlazada.


a. Implementación requerida
Implementar el siguiente módulo:
Abre el archivo y agrega una flor, recibida como parámetro,
respetando la política de reutilización de espacio descripta 

procedure agregarFlor (var a: tArchFlores; nombre: string; codigo: integer);

 
b. Listado del archivo
Realizar un procedimiento que liste el contenido del archivo omitiendo las flores eliminadas (es
decir, aquellos registros que forman parte de la pila de libres).
Se permite modificar o agregar estructuras auxiliares si se considera necesario para obtener
correctamente el listado.


c. Implemente el siguiente módulo:
Abre el archivo y elimina la flor recibida como parámetro manteniendo la
política descripta anteriormente
procedure eliminarFlor (var a: tArchFlores; flor:reg_flor);
* }
program ejer3;
type
reg_flor = record
	nombre: String[45];
	codigo: integer;
 end;

archivo = file of reg_flor;


//A
procedure agregarFlor (var a: archivo; nombre: string; codigo: integer);
var
	f,cab,libre:reg_flor;
	pos:integer;
begin
	reset(a);
	
	f.nombre:=nombre;
	f.codigo:=codigo;
	
	
	seek(a,0);
	read(a,cab);
	
	if(cab.codigo < 0) then begin
	//agarro la pos que apunta la cabecera
		pos:= abs(cab.codigo);
		
		seek(a,pos);
		read(a,libre); //Leemos el registro borrado para obtener el sig. enlace 
		
		//La cabecera ahora apunta al siguiente en la lista invertida 
		cab.codigo:=libre.codigo;
		seek(a,0);
		write(a,cab);
		
		//Escribimos el nuevo libro en el lugar recuperado 
		seek(a,pos);
		write(a,f);
		end
	else begin
		seek(a,fileSize(a));
		write(a,f);
		end;
	close(a);
	end;
		
//B
procedure listarFlores (var a:archivo);
var
	f:reg_flor;
begin
	reset(a);
	seek(a,0);
	read(a,f);
	while( not EOF(a)) do begin
		if(f.codigo > 0) then
			writeln('Nombre: ', f.nombre,'Codigo: ', f.codigo);
		read(a,f);
	end;
	close(a);
end;
