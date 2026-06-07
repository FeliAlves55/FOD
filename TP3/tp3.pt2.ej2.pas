program punto2;
type 
	info = record
		cod:integer;
		num:integer;
		votos:integer
		end;
	archivo = file of info;
	auxiliar = file of integer;
	
procedure procesarArchivo (var a:archivo);
var
	aux:auxiliar;
	reg,regAux:info;	
	total,procesado,codAct,votos:integer;
	ok:boolean;
begin
	asssign(aux,'archivo cuentas');
	rewrite(aux);
	reset(a);
	
	total := 0;
    
    writeln('Código de Localidad', '      ', 'Total de Votos');
    writeln('------------------------------------------');
	while(not EOF(a)) do begin
		read(a,reg);
		codActual:=reg.cod;
		
		seek(aux,0)
		ok:=false;
		while(not EOF(aux)) and (not ok) do begin
			read(aux,procesado);
			if(procesado.cod = codActual) then
				ok:=true;
			end;
		if (not encontrado) then begin
			seek(aux, fileSize(aux));
			write(aux, codActual);
			
			votos:=0;
			seek(a,0);
			
			while(not EOF(a)) do begin
				read(a,regAux);
				if(regAux.cod = codActual) then 
					votos:=votos + regAux.votos;
			end;
		writeln(codActual,'  ', votos);
		total:= total + votos;
	end;
	writeln('Votos totales: ',total);
	close(a);
    close(aux);
    erase(aux); { Borramos el archivo auxiliar del disco al terminar }
end;
		
