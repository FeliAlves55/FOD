{2. Definir un programa que genere un archivo con registros de longitud fija con información de
productos de un comercio. 

Los datos se ingresan por teclado y de cada producto se almacena:
código de producto, nombre, descripción, precio y stock disponible. Implementar un
procedimiento que, a partir del archivo de datos generado, realice la baja lógica de todos
aquellos productos cuyo stock disponible sea igual a 0.

La baja lógica debe indicarse marcando el registro con un carácter especial que se sitúa como
prefijo en algún campo de tipo string a su elección. Por ejemplo, se puede anteponer el carácter @
al nombre del producto: ‘@Arroz Gallo 1K’
}
program ejercicio2;
const
	valorAlto = '9999'
type
	producto = record
		cod:integer;
		nombre:String[20];
		descr:String[30];
		precio:real;
		stock:integer;
		end;
	archivo = file of producto;
	
procedure cargarDato(var a:archivo);
var
	p:producto;
begin
	assign(a,'Archivo productos');
	rewrite(a);
	
	writeln('Ingrese codigo de producto(0 para finalizar): ') 
	readln(p.cod);
	while(p.cod <> 0) do begin
		writeln('Ingrese nombre: ') 
		readln(p.nombre);
		writeln('Ingrese descripcion del producto: ');
		readln(p.descr);
		writeln('Ingrese precio: ');
		readln(p.precio);
		writeln('Ingrese stock total: ');
		readln(p.stock);
		
		write(a,p);
		
		
		writeln('Ingrese codigo de producto(0 para finalizar): ') 
		readln(p.cod);
		end;
end;

procedure leer (var a:archivo; var p:producto);
begin
	if(not EOF(a)) then begin
		read(a,p)
	else
		p.cod := valorAlto;
		end;
end;


procedure procesarArchivo(var a:archivo);
begin
	reset(a);
	leer(a,p);
	while(p.cod <> valorAlto) do begin
		if(p.stock = 0) then begin
			p.nombre:= '@' + p.nombre;
			seek(a, filePos(a)-1);
			write(a,p);
		end;
		leer(a,p);
	end;
	close(a);
	end;
	
var
a:archivo;
begin
cargarDato(a);
procesarArchivo(a);
end.



