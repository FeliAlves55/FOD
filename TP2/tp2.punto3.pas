program punto3;
const
    valor_alto = 'ZZZZ'; // Para marcar el fin de archivo
type
argentina=record
	provincia:String;
	alfabetizados:integer;
	encuestados:integer;
	end;
	
censo=record
	provincia:String;
	codigo:integer;
	cantAlfa:integer;
	encuestados:integer;
	end;

maestro= file of argentina;

detalle= file of censo;
procedure leer(var archivo: detalle; var dato: censo);
begin
    if (not eof(archivo)) then
        read(archivo, dato)
    else
        dato.provincia := valor_alto;
end;
procedure minimo (var r1,r2:censo;var det1,det2:detalle ;var min:censo);
begin
if(r1.provincia <= r2.provincia) then begin
	min:=r1;
	leer(det1,r1)
else begin
	min:=r2;
	leer(det2,r2);
	end;
end;
end;	
var
mae:maestro;
det1,det2:detalle;
a:argentina;
c1,c2:censo;
begin
assign(mae,'maestro');
assign (det1, 'det1');
assign (det2, 'det2');
rewrite (maestro);
reset (det1); reset (det2);
leer(det1,c1);leer(det2,c2);
minimo(c1,c2,det1,det2,min);
while(min.provincia <> valor_alto) do begin

	read(mae, regM);
    
    // Avanzo en el maestro hasta encontrar la provincia que coincide con el detalle
    while (regM.nombre <> min.nombre) do
        read(mae, regM);
        
	while (min.nombre = regM.nombre) do
    begin
        regM.alfabetizados := regM.alfabetizados + min.alfabetizados;
        regM.encuestados := regM.encuestados + min.encuestados;
        minimo(regD1, regD2, det1, det2, min);
    end;
    seek(mae,filepos(mae)-1);
    write(mae, regM);
end;
close(mae);
close(det1);
close(det2);
end.
