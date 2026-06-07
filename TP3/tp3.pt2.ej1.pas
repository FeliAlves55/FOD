{1. El encargado de ventas de un negocio de productos de limpieza desea administrar el stock de los
productos que vende. Para ello, genera un archivo maestro donde figuran todos los productos que
comercializa. De cada producto se maneja la siguiente información: código de producto, nombre
comercial, precio de venta, stock actual y stock mínimo. 

Diariamente se genera un archivo detalle donde se registran todas las ventas de productos realizadas. 

De cada venta se registran: código de  producto y cantidad de unidades vendidas. Resuelve los siguientes puntos:

a. Se pide realizar un procedimiento que actualice el archivo maestro con el archivo detalle,
teniendo en cuenta que:

i. Los archivos no están ordenados por ningún criterio.

ii. Cada registro del maestro puede ser actualizado por 0, 1 ó más registros del archivo
detalle.


b. ¿Qué cambios realizaría en el procedimiento del punto anterior si se sabe que cada registro
del archivo maestro puede ser actualizado por 0 o 1 registro del archivo detalle?
}
program ej1;
const
	valorAlto = 9999;
type
	producto = record
		cod:integer;
		nombre:String;
		precio:real;
		st_actual:integer;
		st_min:integer;
		end;
	venta = record
		cod:integer;
		cant:integer;
		end;
		
	maestro = file of producto;
	detalle = file of venta;


procedure actualizarMaestro (var m:maestro; var d:detalle);
var
	p:producto;
	v:venta;
	ok:boolean;
begin
	reset(d);
	reset(m);
	while (not EOF(d)) do begin
		read(d,v);
		
		seek(m,0);
		ok:=false;
		while (not EOF(m)) and (not ok) do begin
			read(m,p);
			if(v.cod = p.cod) then begin
				ok:=true;
				p.st_actual := p.st_actual - v.cant;
				seek(m,filePos(m)-1);
				write(m,p);
			end;
		end;
	end;
	close(m);
	close(d);
end;		
	
	
	
	




