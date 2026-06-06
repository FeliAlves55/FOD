{6. Se desea modelar la información necesaria para un sistema de recuento de casos de COVID del
Ministerio de Salud de la Provincia de Buenos Aires.
* 
Diariamente se reciben 10 archivos detalle provenientes de distintos municipios. La información contenida
en cada uno de ellos es la siguiente: código de localidad, código de cepa, cantidad de casos activos,
cantidad de casos nuevos, cantidad de casos recuperados y cantidad de casos fallecidos.
* 
El ministerio cuenta con un archivo maestro que almacena la siguiente información: código de localidad,
nombre de la localidad, código de cepa, nombre de la cepa, cantidad de casos activos, cantidad de casos
nuevos, cantidad de casos recuperados y cantidad de casos fallecidos.
* 
Todos los archivos están ordenados por código de localidad y código de cepa.
* 
Se solicita desarrollar el procedimiento que permita actualizar el archivo maestro a partir de los 10 archivos
detalle, teniendo en cuenta el siguiente criterio:
● A la cantidad de casos fallecidos del maestro se le debe sumar el valor recibido en el detalle.
● A la cantidad de casos recuperados del maestro se le debe sumar el valor recibido en el detalle.
● La cantidad de casos activos del maestro debe actualizarse con el valor recibido en el detalle.
● La cantidad de casos nuevos del maestro debe actualizarse con el valor recibido en el detalle.
Realizar las declaraciones necesarias, el programa principal y los procedimientos que se requieran para
efectuar la actualización solicitada.
3
Además, informar la cantidad de localidades que poseen más de 50 casos activos, independientemente de
que hayan sido actualizadas o no.}

program ejercicio6;
const
valor_alto = 9999;
DF = 10;
type
detalle_info = record
	codigo_lo: integer;
	codigo_cepa: integer;
	casos_act: integer;
	casos_nue: integer;
	casos_recu: integer;
	casos_falle: integer;
	end;
	
maestro_info = record
	codigo_lo: integer;
	nombre_lo: String;
	codigo_cepa: integer;
	nombre_cepa: String;
	casos_act: integer;
	casos_nue: integer;
	casos_recu: integer;
	casos_falle: integer;
	end;
	
meastro = file of maestro_info;

detalle = file of detalle_info;
vec_det = array [1..DF] of detalle;
vec_reg = array [1..DF] of detalle_info;

procedure leer (var a:detalle; var r:detalle_info);
begin
if(not EOF(a)) then begin
	read(a,r);
else
	r.codigo_lo := valor_alto;
	end;
end;

procedure leerPrimerRegistro(var vec: vec_det; var reg: vec_reg);
var
i:integer;
begin
for(i:= 1 to DF) do begin
	reset(vec[i]);
	read(vec[i], reg[i])
	end;
end;

procedure minimo (var vec: vec_det; var reg: vec_reg; var min:detalle_info);
var 
i,posMin:integer;
begin
min.codigo_lo:=valor_alto;
for(i:=1 to DF) do begin
	if(reg[i].codigo_lo < min.codigo_lo) then begin
		min := reg[i];
		posMin := i;
		end
	else if(reg[i].codigo_lo = min.codigo_lo) then begin
		if(reg[i].codigo_cepa < min.codigo_cepa) then begin
			min := reg[i];
			posMin := i;
			end;
		end;
	end;
	leer(vec[posMin], reg[posMin]);
end;
	
			
procedure actualizarMaestro(var archivo:meastro; var regm:meastro_info; fallecidos, recuperados, activos, nuevos, codLocAct, codCepAct: integer);
begin
regm.codigo_lo := codLocAct;
regm.codigo_cepa:= codCepAct;
regm.casos_act:= activos;
regm.casos_nue:= nuevos;
regm.casos_falle:= regm.casos_falle + fallecidos;
regm.casos_recu := regm.casos_recu + recuperados;
seek(archivo, filepos(archivo)-1);
write(archivo, regm); 
end;

procedure actualizarMaestro(var mae: maestro; var det: vec_det; var reg:vec_reg; var min:detalle_info);
var
	fallecidos, recuperados, activos, nuevos, cantLocCumple,codLocAct, codCepAct: integer;
	regm: maestro_info;
begin
	cantLocCumple:=0;
	reset(mae);
	leerPrimerRegistro(det,reg);
	minimo(det,reg,min);
	read(mae,regm);
	
	while(min.codigo_lo <> valor_alto) do begin
		fallecidos, recuperados, activos, nuevos := 0;
		codLocAct := min.cod_loc;
		codCepAct := min.cod_cepa;
		while (codLocAct = min.cod_loc) and (codCepAct = min.cod_cepa) do
		begin
			fallecidos := fallecidos  + min.casos_falle;
			recuperados := recuperados + min.casos_recu;
			activos := activos + min.casos_act;
			nuevos := nuevos + min.casos_nue;
			
			minimo(det, reg, min);
		end;
		while (reg.cod_loc <> codLocAct) or (regm.cod_cepa <> codCepAct) do
		begin
			read(mae,regm);
		end;
		actualizarDatos(mae, regm, fallecidos, recuperados, activos, nuevos,codLocAct,codCepAct);
	end;
end;
	

procedure cerrarArchivos(var det:vec_det)
var
i:integer;
begin
for(i:= 1 to DF) do begin
	close(det[i]);
	end;
end;

procedure contarLocalidades(var mae:maestro);
var
cant,total,act:integer;
regm:maestro_info;
begin
reset(mae);
total:=0;
read(mae,regm);
while(regm.codigo_lo <> valor_alto) do begin
	cant:=0;
	act:=regm.codigo_lo;
	while(act = regm.codigo_lo) do begin
		cant:= cant + regm.casos_act;
		if(not EOF(mae)) then
			read(mae,regm)
		else
			regm.codigo_lo := valor_alto;
		end;
	end;
	if(cant > 50) then 
		total:= total + 1;
writeln('La cantidad de localidades con mas de 50 casos activos es: ', total);
end;

var
det:vec_det; reg:vec_reg; min:detalle_info;
mea:meastrol
{PROGRAMA PRINCIPAL}
begin
	assign(mae, 'maestro');
	actualizarMaestro(mea,det, reg, min);
	cerrarArchivos(det);
	contarLocalidades(mae);
	close(mae);
end.



 
