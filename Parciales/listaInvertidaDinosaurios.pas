program dinosaurios;
type
	dinosaurio = record
		cod:integer;
		tipo:String;
		altura:integer;
		peso:real;
		descr:String;
		zona:String;
		end;
		
	archivo =file of dinosaurio;
	
procedure agregarDino (var a:archivo; dino:dinosaurio);
var
	cab,aux:dinosaurio;
	libre:integer;
begin
	reset(a);
	seek(a,0);
	read(a,cab);
	if(cab.cod < 0) then begin
		libre:= abs(cab.cod);
		seek(a,libre);
		read(a,aux);
		
		
		cab.cod:=aux.cod;
		seek(a,0);
		write(a,cab);

		seek(a,libre);
		write(a,dino);
		end
	else begin
		seek(a,fileSize(a));
		write(a,dino);
		end;
	close(a);
end;

procedure eliminarDinos(var a:archivo; tipo:String);
var
	cab,aux:dinosaurio;
	pos:integer;
begin
	reset(a);
	while(not EOF(a)) do begin
		read(a,aux);
		if(aux.tipo = tipo) then begin
			pos:= filePos(a) -1;
			seek(a,0);
			read(a,cab);
			
			aux.cod:=cab.cod;
			cab.cod:= -pos;
			
			write(a,cab);
			
			seek(a,pos);
			write(a,aux);
			end;
		end;
end;

procedure leer(var a:archivo; d:dinosaurio);
begin
if(not EOF(a)) then
	read(a,d)
else
	d.cod:=9999;
end;
procedure archivoTexto (var txt:texto);
var
	d:dinosaurio;
begin
	reset(a);
	assign(txt,'Listado texto');
	rewrite(txt);
	leer(a,d);
	while(d.cod <> 9999) do begin
		if(d.cod > 0) then
			writeln(txt, d.cod, d.tipo, d.altura, d.peso, d.descr, d.zona);
		leer(a,d);
		end;
		
	close(a);
	close(txt);


end;


