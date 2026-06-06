{9. Se cuenta con un archivo que posee información de las ventas que realiza una empresa a los diferentes
clientes. 

Se necesita obtener un reporte con las ventas organizadas por cliente. Para ello, se deberá
informar por pantalla: los datos personales del cliente, el total mensual (mes por mes cuánto compró) y
finalmente el monto total comprado en el año por el cliente. 

Además, al finalizar el reporte, se debe informar el monto total de ventas obtenido por la empresa.

El formato del archivo maestro está dado por: cliente (cod cliente, nombre y apellido), año, mes, día y
monto de la venta. El orden del archivo está dado por: cod cliente, año y mes.
 
Nota: tenga en cuenta que puede haber meses en los que los clientes no realizaron compras. No es
necesario que informe tales meses en el reporte.
}
program ejercicio9;
const
valorAlto = 999;
type 
cliente = record
	cod:integer;
	nombre:String;
	apellido:String;
	end;
maestro_info = record
	cli:cliente;
	anio:integer;
	mes:integer;
	dia:integer;
	monto:real;
	end;
	
maestro = file of maestro_info;

procedure leer(var a:maestro; var r:maestro_info);
begin
if(not EOF(a)) then
	read(a,r)
else
	r.cli.cod := valorAlto;
end;

procedure imprimirDatos(cli:cliente);
begin
writeln('-------------------------');
writeln('Codigo:',cli.cod);
writeln('Nombre:',cli.nombre);
writeln('Apellido:',cli.apellido);
writeln('-------------------------');
end;

procedure procesarArchivo(var a:maestro);
var
codActual,mesActual,anioActual:integer;
r:maestro_info;
totalMes,totalAnio,totalEmpresa: real;
begin
reset(a);
leer(a,r);
totalEmpresa:=0;
while(r.cli.cod <> valorAlto) do begin
	codActual := r.cli.cod;
	imprimirDatos(r.cli);
	while(r.cli.cod = codActual) do begin
		totalAnio := 0;
		anioActual:= r.anio;
		while(r.cli.cod = codActual) and (anioActual = r.anio) do begin
			totalMes:=0;
			mesActual:=r.mes;
			while (r.cli.cod = codActual) and (anioActual = r.anio)and(mesActual = r.mes) do begin
					totalMes:= totalMes + r.monto;
					leer(a,r);
					end;
			totalAnio:=totalAnio + totalMes;
			writeln('Mes: ',mesActual,' recaudo una cantidad de: ', totalMes);
			end;
		writeln('Año: ',anioActual,' recaudo una cantidad de: ',totalAnio);
		totalEmpresa:= totalEmpresa + totalAnio;
		end;
	end;
writeln('Monto total de la empresa', totalEmpresa);
end;

var
a:maestro;
begin
assign(a,'Archivo empresa');
procesarArchivo(a);
end.


