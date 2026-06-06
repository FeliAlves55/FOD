program punto5;
const
valor_alto = 9999;
type 
archivo = record
	codigo:integer;
	fecha:String;
	tiempo:real;
	end;
archivoMae = record
	codigo:integer;
	fecha:integer;
	tiempoTotal:real;
	end;
	
maestro = file of archivoMae;
detalle = file of archivo;

vDetalle= array[1..5] of detalle;
vRegistro= array[1..5] of archivo;

procedure leer( var det:detalle; var a:archivo);
begin
if(not EOF(det)) then
	read(det,a);
else
	a.codigo := valor_alto;
end;

procedure minimo (var vD:vDetalle; var vR:vRegistros; var min:archivo);
var
i,posMin:integer;
begin
min.codigo:=valor_alto;
mim.fecha:= '99/99/99';
posMin:=-1;
for i:= 1 to 5 do begin
	if(vR[i].codigo < min.codigo) or ((vR[i].codigo = min.codigo) and (vR[i].fecha < min.fecha)) then begin
            min := vR[i];
            posMin := i;
        end;
    end;
if (posMin <> -1) then
     leer(vD[posMin], vR[posMin]);
end;


procedure generarMaestro (var vD:vDetalle);
var
vR:vRegistro;
min:archivo;
mae:maestro;
regM:archivoMae;
codAct:integer; fechaAct:String;
i:integer;
begin
assign(mae,'/var/log/maestro_sesiones.dat');
rewrite(mae);

// Inicializar detalles
    for i := 1 to 5 do begin
        reset(vD[i]);
        leer(vD[i], vR[i]);
    end;
    
minimo(vD, vR, min);

while (min.cod <> valor_alto) do begin
        // 1. Nueva combinación Usuario-Fecha
        codAct := min.cod;
        fechaAct := min.fecha;
        regM.tiempoTotal := 0;

        // 2. Acumular todos los registros que coincidan en Usuario Y Fecha
        while (min.cod = codAct) and (min.fecha = fechaAct) do begin
            regM.tiempoTotal := regM.tiempoTotal + min.tiempo;
            minimo(vD, vR, min);
        end;

        // 3. Escribir el registro consolidado en el maestro
        regM.cod := codAct;
        regM.fecha := fechaAct;
        write(mae, regM);
    end;

    close(mae);
    for i := 1 to N do close(vD[i]);
end;



