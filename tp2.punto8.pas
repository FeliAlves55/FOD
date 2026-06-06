{8. Se desea gestionar la información correspondiente al consumo de yerba mate en las distintas provincias
de la Argentina.

Para ello, se dispone de un archivo maestro que contiene la siguiente información: código de provincia,
nombre de la provincia, cantidad de habitantes y cantidad total histórica de kilos de yerba consumidos.
* 
Mensualmente, se reciben 16 archivos detalle con información relevada sobre el consumo de yerba mate
en distintos puntos del país. Cada archivo detalle contiene: código de provincia y cantidad de kilos de yerba
consumidos en ese relevamiento.
* 
Un archivo detalle puede contener información correspondiente a una o varias provincias, y una misma
provincia puede aparecer cero, uno o más veces en los distintos archivos detalle.
Tanto el archivo maestro como los archivos detalle están ordenados por código de provincia.
Se solicita desarrollar un programa que actualice el archivo maestro a partir de la nueva información de
consumo.
* 
Además, se debe informar por pantalla aquellas provincias (código y nombre) cuya cantidad total histórica
de yerba consumida supere los 10.000 kilos, indicando también el promedio de consumo por habitante.
Para este informe deben considerarse tanto las provincias actualizadas como aquellas que no hayan
recibido modificaciones.
Nota: Cada archivo debe recorrerse una única vez.
}
program punto8;
const
valorAlto = 9999;
DF = 16;
type
maestro_info = record
	cod:integer;
	nombre:String;
	habitantes:integer;
	yerba:integer;
	end;
	
detalle_info = record
	cod:integer;
	kilo_yerba:integer;
	end;

maestro = file of maestro_info;
detalle = file of detalle_info;

vec_det = array[1..DF] of detalle;
vec_reg = array[1..DF] of detalle_info;

procedure leer(var d:detalle;var reg:detalle_info);
begin
if(not EOF(d)) then
	read(d,reg)
else
	reg.cod := valorAlto;
end;

procedure leerPrimeros(var d:vec_det; var reg:vec_reg);
var
i:integer;
begin
for i:=1 to DF do begin
	reset(d[i]);
	leer(d[i], reg[i]);
	end;
end;

procedure minimo (var det:vec_det; var reg:vec_reg; var min:detalle_info);
var
i,posMin:integer;
begin
min.cod:=valorAlto;
for i:= 1 to DF do begin
	if(reg[i].cod < min.cod)then begin
		min := reg[i];
		posMin := i;
		end;
	end;
if (posMin <> -1) then
        leer(det[posMin], reg[posMin]);
end;

procedure procesarArchivo(var mae:maestro; var det:vec_det; var reg:vec_reg);
var
actual,total:integer;
regM: maestro_info;
min: detalle_info;
begin
reset(mae);
leerPrimeros(det,reg);
minimo(det,reg,min);
read(mae,regM);
while(min.cod<>valorAlto) do begin
	actual:=min.cod;
	total:=0;
	while(min.cod<>valorAlto) and (min.cod = actual) do begin
		total:= total + min.kilo_yerba;
		minimo(det,reg,min);
		end;
	
	while(not EOF(mae)) and (regM.cod <> actual) do begin
		read(mae,regM);
		end;
	regM.yerba:= regM.yerba + total;
	seek(mae,filePos(mae)-1);
	write(mae,regM);
	end;
end;
procedure cerrarArchivos(var det:vec_det);
var
i:integer;
begin
for i:= 1 to DF do begin
	close(det[i]);
	end;
end;
procedure maestroHistorico(var mae:maestro);
var
regM:maestro_info;
prom:real;
begin
read(mae,regM);
while(not EOF(mae)) do begin
	if(regM.yerba > 10000) then begin
		if (regM.habitantes > 0) then
                prom := regM.yerba / regM.habitantes
            else
                prom := 0;
                
            writeln('La provincia ', regM.nombre, ' con el codigo: ', regM.cod, ' tiene un promedio de: ', prom:2:2, ' kg por habitante.');
        end;
    end;
end;
var
i:integer;
mae:maestro;
det:vec_det;
reg:vec_reg;
begin
assign(mae,'archivo maestro');
for i := 1 to DF do begin
     assign(det[i], 'detalle' + i + '.dat'); 
end;
procesarArchivo(mae,det,reg);
cerrarArchivos(det);
maestroHistorico(mae);
close(mae);
end.
