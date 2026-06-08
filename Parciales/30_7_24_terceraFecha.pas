program empresa;
type
	empleado = record
		num:integer;
		nombre:String[15];
		apellido:String[20];
		fecha:String[20];
		genero:String[15];
		end;
	archivo = file of empleado;
	
function existeEmpleado (var a:archivo; num:integer):integer;
var
	e:empleado;
	ok:boolean;
	pos:integer;
begin
	pos:=0;
	ok:=false;
	while(not EOF(a)) and (not ok) do begin
		read(a,e);
		if(e.num = num) then begin
			ok:=true;
			pos:= filePos(a) - 1;
			end;
		end;
	existeEmpleado:=pos;
end;

procedure leerEmpleado (var e:empleado);
begin
writeln('Ingrese numero: ',readln(e.num));
writeln('Ingrese nombre: ',readln(e.nombre));
writeln('Ingrese apellido: ',readln(e.apellido));
writeln('Ingrese fecha de nacimiento: ',readln(e.fecha));
writeln('Ingrese genero: ',readln(e.genero));
end;

procedure altaEmpleado (var a:archivo);
var
	cab,e,aux:empleado;
	pos,libre:integer;
begin
	reset(a);
	leerEmpleado(e);
	pos:=existeEmpleado(a,e.num);
	if(pos <> 0) then begin
		writeln('Este empleado ya existe');
		end
	else begin
		seek(a,0);
		read(a,cab);
		if(cab.num < 0) then begin
			libre:=abs(cab.num);
			 seek(a,libre);
			 read(a,aux);
			 
			 cab.num:=aux.num;
			 seek(a,0);
			 write(a,cab);
			 
			 seek(a,libre);
			 write(a,e);
			 end
		else begin
			seek(a,fileSize(a));
			write(a,e);
			end;
	end;
	close(a);
end;
	
procedure bajaEmpleado (var a:archivo);
var
	cab,aux:empleado;
	pos,borrar:integer;
begin
	reset(a);
	writeln('Ingrese el empleado a borrar', readln(borrar));
	pos:=existeEmpleado(a,borrar);
	if(pos = 0) then begin
		writeln('Ese empleado no existe');
		end
	else begin
		seek(a,0);
		read(a,cab);
		
		aux.num:=cab.num;
		
		cab.num:=-pos;
		
		write(a,cab);
		
		seek(a,pos);
		write(a,aux);
		close(a);
		end;
end;

	
	
	
	
	
	
	
	
