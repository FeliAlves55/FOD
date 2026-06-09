program mascotas;
type
	mascota = record
		cod:integer;
		nombre:String;
		edad:integer;
		especie:String;
		nomDue:String;
		telefono:integer;
		end;
		
	archivo = file of mascota;
	
function existeMascota (var a:archivo;num:integer):integer;
var
	pos:integer;
	ok:boolean;
	m:mascota;
begin
	pos:=0;
	ok:=false;
	while(not EOF(a)) and (not ok) do begin
		read(a,m);
		if(p.cod = num) then begin
			ok:=true;
			pos:=filePos(a) - 1;
			end;
		end;
	existeMascota:=pos;
end;


procedure leerMascota(var m:mascota);
begin
readln(m.cod);
readln(m.nombre);
readln(m.edad);
readln(m.especie);
readln(m.nomDue);
readln(m.telefono);
end;

procedure altaMascota (var a:archivo);
var
	cab,m,aux: mascota;
	pos,libre:integer;
begin
	reset(a);
	leerMascota(m);
	pos:=existeMascota(a,m.cod);
	if(pos <> 0) then begin
		writeln('Esta mascota ya existe');
		end
	else begin
		seek(a,0);
		read(a,cab);
		if(cab.cod < 0) then begin
			libre:=abs(cab.cod);
			seek(a,libre);
			read(a,aux);
			
			cab.cod:=aux.cod;
			seek(a,0);
			write(a,cab);
			
			seek(a,libre);
			write(a,m);
			end
		else begin
			seek(a,fileSize(a));
			write(a,m);
			end;
		end;
	close(a);
end;


procedure bajaMascota (var a:archivo);
var
	cab,aux:mascota;
	pos,borrar:integer;
begin
	reset(a);
	writeln('Ingrese el codigo de la mascota que desea eliminar: ');
	readln(borrar);
	pos:=existeMascota(a,borrar);
	if(pos = 0) then begin
		writeln('La mascota no existe');
		end
	else begin
		seek(a,0);
		read(a,cab);
		
		aux.cod:=cab.cod;
		cab.cod:= -pos;
		
		write(a,cab);
		
		seek(a,pos);
		write(a,aux);
		close(a);
		end;
end;
		







