{7. Se cuenta con un archivo con información de las diferentes distribuciones de linux existentes. De
cada distribución se conoce: nombre, año de lanzamiento, número de versión del kernel, cantidad
de desarrolladores y descripción. El nombre de las distribuciones no puede repetirse. 


Este archivo debe ser mantenido realizando bajas lógicas y utilizando la técnica de reutilización de espacio libre
llamada lista invertida. Escriba la definición de las estructuras de datos necesarias y los siguientes
procedimientos:

a. BuscarDistribucion: módulo que recibe por parámetro el archivo, un nombre de
distribución y devuelve la posición dentro del archivo donde se encuentra el registro
correspondiente a la distribución dada (si existe) o devuelve -1 en caso de que no
exista..


b. AltaDistribucion: módulo que recibe como parámetro el archivo y el registro que
contiene los datos de una nueva distribución, y se encarga de agregar la distribución al
archivo reutilizando espacio disponible en caso de que exista. El control de unicidad lo
debe realizar utilizando el módulo anterior. En caso de que la distribución que se quiere
agregar ya exista se debe informar “ya existe la distribución”.


c. BajaDistribucion: módulo que recibe como parámetro el archivo y el nombre de una
distribución, y se encarga de dar de baja lógicamente la distribución dada. Para marcar
una distribución como borrada se debe utilizar el campo cantidad de desarrolladores
para mantener actualizada la lista invertida. Para verificar que la distribución a borrar
exista debe utilizar el módulo BuscarDistribucion. En caso de no existir se debe informar
“Distribución no existente”.
}
program punto7;
type
	info = record
		nombre:String;
		anio:integer;
		version:integer;
		cant:integer;
		descr:String;
		end;
	archivo = file of info;
	
function buscarDistribucion (var a:archivo; nombre:String):integer;
var
	pos:integer;
	ok:boolean;
	d:info;
begin
	reset(a);
	seek(a,1);
	pos:=-1;
	ok:=false;
	while(not EOF(a)) and (not ok) do begin
		read(a,d);
		if(d.nombre = nombre) then begin
			ok:=true;
			pos:= filePos(a)-1;
			end;
		end;
	close(a);
	buscarDistribucion:=pos;
end;	

procedure altaDistribucion(var a:archivo; d:info);
var
	cab,reg:info;
	pos:integer;
begin
	reset(a);
	if(buscarDistribucion(a,d.nombre) <> -1) then
		writeln('Ya existe la distribucion')
	else begin
		seek(a,0);
		read(a,cab);
		if(cab.cant < 0) then begin
			pos:= abs(cab.cant);
			
			seek(a,pos);
			read(a,reg);
			
			cab.cant:=reg.cant;
			seek(a,0);
			write(a,cab);
			
			seek(a,pos);
			write(a,d);
			end
		else begin
			seek(a,fileSize(a));
			write(a,d);
			end;
		end;
	close(a);
	end;
			
			
procedure bajarDistribucion (var a:archivo; nombre:String);
var
	cab,reg:info;
	aux:integer;
begin
	aux:=buscarDistribucion(a,nombre);
	if(aux = -1) then
		writeln('Distribucion no existente')
	else begin
		reset(a);
		seek(a,0);
		read(a,cab);
		
		reg.cant:=cab.cant;
		
		cab.cant:=-aux;
		write(a,cab);
		
		seek(a,aux);
		write(a,reg);
		close(a);
		end;
end;
		
var
a:archivo;
begin
assign(a,'archivo');
end.	






			
			
