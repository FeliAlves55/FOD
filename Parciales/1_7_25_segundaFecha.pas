program ligaProfesional;
const
	valorAlto = '99999';
	DF = 12;
type
	maestro_info = record
		cod:String;
		nombre:String;
		cantJugados:integer;
		cantGan:integer;
		cantEmp:integer;
		cantPer:integer;
		cantPuntos:integer;
		end;
		
	detalle_info = record
		cod:String;
		fecha:String;
		cantPuntos:integer;
		codRival:String
		end;
		
	maestro = file of maestro_info;
	
	detalle = file of detalle_info;
	vecDet = array[1..DF] of detalle;
	vecReg = array[1..DF] of detalle_info;
	
procedure leer (var d:detalle; var reg:detalle_info);
begin
if (not EOF(d)) then
	read(d,reg)
else
	reg.cod:=valorAlto;
end;

procedure leerPrimeros (var d:vecDet; var reg:vecReg);
var
	i:integer;
begin
for i := 1 to DF do begin
	reset(d[i]);
	read(d[i],reg[i])
	end;
end

procedure minimo (var d:vecDet; var reg:verReg; var min:detalle_info);
var
	i,posMin:integer;
begin
	min.cod:=valorAlto;
	posMin:=-1;
	for i:= 1 to DF do begin
		if(reg[i].cod < min.cod) then begin
			min.cod:=reg[i].cod;
			posMin:=i;
			end;
		end;
	if(posMin <> -1) then
		leer(d[posMin],reg[posMin]);
end;

procedure cerrarArchivos(var d:vecDet);
var
	i:integer;
begin
for i:= 1 to DF do begin
	close(d[i]);
	end;
end;

procedure reiniciarAux (var aux:maestro_info);
begin 
aux.cantJugados:=0;
aux.cantGan:=0;
aux.cantEmp:=0;
aux.cantPer:=0;
aux.cantPuntos:=0;
end;
procedure sumarMaestro( aux:maestro_info; var reg:maestro_info);
begin
reg.cantJugados:=reg.cantJugados + aux.cantJugados;
reg.cantGan:=reg.cantGan + aux.cantGan;
reg.cantEmp:=regCantEmp + aux.cantEmp;
reg.cantPer:=regCantPer + aux.cantPer;
reg.cantPuntos:= regCantPuntos + aux.cantPuntos;
end;

procedure actualizarMaestro(var m:maestro; var d:vecDet; var reg:vecReg);
var
	codActual,maxEquipo:String;
	regM,aux:maestro_info;
	min:detalle_info;
	totalPuntosAnio:integer;
begin
	reset(m);
	leerPrimeros(d,reg);
	minimo(d,reg,min);
	totalPuntosAnio:= -1;
	
	read(m,regM);
	
	while (min.cod <> valorAlto) do begin
		codActual:=min.cod;
		reiniciarAux(aux);
		
		while(codActual = min.cod) do begin
			aux.cantJugados:= aux.cantJugados + 1;
			aux.cantPuntos :=aux.cantPuntos + min.cantPuntos;
			
			if(min.cantPuntos = 3) then
				aux.cantGan:=aux.cantGan + 1;
			else if(min.cantPuntos = 1) then
				aux.cantEmp:=aux.cantEmp + 1;
			else
				aux.cantPer:=aux.cantPer + 1;
				
			minimo(d,reg,min);
			end;
		while(not EOF(m)) and (regM.cod <> codActual) do begin
				read(m,regM);
				end;
				
		if(totalPuntosAnio < aux.cantPuntos) then begin
			totalPuntosAnio := aux.cantPuntos;
			maxEquipo:=codActual;
			end;
			
		sumarMaestro(aux,regM);
		seek(m,filePos(m)-1);
		write(m,aux);
		end;
	writeln('El equipo que mas sumo fue:', maxEquipo);
	cerrarArchivos(d);
	close(m);
end;
var
	m:maestro;
	d:vecDet;
	reg:vecReg;
	nom:String;
	i:integer;
begin
	assign(m,'Archivo Maestro');
	for i:= 1 to DF do begin
		writeln('Escribir nombre del archivo: ',i,' ', readln(nom));
		assign(d[i],nom);
	end;
	actualizarMaestro(m,d,reg);
end.
