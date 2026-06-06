program tp2.punto2;
type 
producto = record
	codP:integer;
	nombre:String;
	precio:real;
	stAct:integer;
	stMin:integer;
	end;
	
venta=record
	cod:integer;
	cant:integer;
	end;
	
maestro = file of producto;

detalle = file of venta;

var
mae:maestro;
det:detalle;
p:producto;
v:venta;

begin
assign(mae,'maestro.dato');
assign(det,'detalle.dat');
reste(mae);
reset(det);

while(not EOF(det)) do beign
	read(mae,p);
	read(det,v);
	
	while(p.cod <> v.cod) do begin
		read(mae,p);
		end;
	p.stAct:= p.stAct - v.cant;
	seek(mae,filepos(mae)-1);
	write(mae,p);
	close(det);
	close(mae)
	end.
