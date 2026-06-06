{7. Se dispone de un archivo maestro con información de los alumnos de la Facultad de Informática. Cada
registro del archivo maestro contiene: código de alumno, apellido, nombre, cantidad de cursadas
aprobadas y cantidad de materias con final aprobado. El archivo maestro está ordenado por código de
alumno.
* 
Además, se dispone de dos archivos detalle con información sobre el desempeño académico de los
alumnos: un archivo de cursadas y un archivo de exámenes finales.
El archivo de cursadas contiene información sobre las materias cursadas por los alumnos. Cada registro
incluye: código de alumno, código de materia, año de cursada y resultado (solo interesa determinar si la
cursada fue aprobada o desaprobada).
* 
Por su parte, el archivo de exámenes finales contiene información sobre los exámenes rendidos. Cada
registro incluye: código de alumno, código de materia, fecha del examen y nota obtenida.
* 
Ambos archivos detalle están ordenados por código de alumno y código de materia, y pueden contener
cero, uno o más registros por alumno.
Un alumno puede cursar una misma materia varias veces, así como también rendir el examen final en
múltiples ocasiones.
* 
Se solicita desarrollar un programa que actualice el archivo maestro, modificando la cantidad de cursadas
aprobadas y la cantidad de materias con final aprobado, a partir de la información contenida en los archivos
detalle.
Las reglas de actualización son las siguientes:
● Si un alumno aprueba una cursada, se incrementa en uno la cantidad de cursadas aprobadas.
● Si un alumno aprueba un examen final (nota mayor o igual a 4), se incrementa en uno la cantidad de
materias con final aprobado.
Notas:
● Los archivos deben procesarse en un único recorrido.
● No es necesario verificar inconsistencias en la información de los archivos detalle. En particular, se
garantiza que un alumno no puede aprobar más de una vez la cursada de una misma materia. De
manera análoga, tampoco puede aprobar más de una vez el examen final de una misma materia.
}

program punto7;
const
valor_alto = 99999;
type
maestro_info=record
	cod:integer;
	nombre:String;
	apellido:String;
	curs_ap:integer;
	final_ap:integer;
	end;
	
cursada_info:record
	cod:integer;
	cod_mat:integer;
	ano:integer;
	resultado:boolean;
	end;
	
finales_info=record
	cod:integer;
	cod_mat:integer;
	fecha:String;
	nota:integer;
	end;
	
meastro = file of meastro_info;
cursada = file of cursada_info;
finales = file of finales_info;

procedure leerCursada(var c:cursada; var r:cursada_info);
begin
if(not EOF(c)) then 
	read(c,r)
else
	r.cod:=valor_alto;
end;

procedure leerFinal(var f:finales; var r:finales_info);
begin
if(not EOF(f)) then 
	read(f,r)
else
	r.cod:=valor_alto;
end;


procedure procesarArchivo(var mae:maestro; var f:finales; var c:cursada);
var
regF:finales_info;regC:cursada_info;regM:maestro_info;
codAct:integer;
begin
reset(mae);
reset(f);
reset(c);
leerFinal(f,regF);
leerCursada(c,regC);
while(not EOF(mae))do begin
	read(mae,regM);
	while(regC.cod <> valor_alto) and (regC.cod=regM.cod;)do begin
		if(regC.resultado) then
			regM.cursAp:=regM.cursAp + 1;
		leerCursada(c,regM);
		end;
	while(regF.cod <> valor_alto) and (regF.cod=regM.cod;)do begin
		if(regF.nota >= 4) then
			regM.final_ap:= regM.final_ap + 1;
		leerFinal(f,regF);
		end;
	seek(mae,filePos(mae)-1);
	write(mae,regM)
	end;
end;
var
mea:meastro;
f:finales;
c:cursada;
begin
assign(mae,'Archivo Maestro');
assign(f,'Archivo Finales');
assign(c,'Archivo Cursadas');
procesarArchivo(mae,f,c);
close(mae);
close(f);
close(c);
end.


