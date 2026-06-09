program golosinaLopez;
const
	valorAlto = '9999999';
	DF = 20;
type
	producto = record
		cod:String;
		nombre:String;
		precio:real;
		stAct:integer;
		stMin:integer;
		end;
	produDeta = record
		cod:String;
		cant:integer;
		end;
			
	maestro = file of producto;
	detalle = file of produDeta;
	
	vecDet = array[1..DF] of detalle;
	vecReg = array[1..DF] of produDeta;
	
procedure leer (var d:detalle; var reg:produDeta);
begin
if(not EOF(d)) then
	read(d,reg)
else
	reg.cod:=valorAlto;
end;

procedure leerPrimeros(var d:vecDet; var reg:vecReg);
var
	i:integer;
begin
	for i:= 1 to DF do begin
		reset(d[i]);
		leer(d[i],reg[i]);
		end;
end;

procedure cerrarDetalles(var d:vecDet);
var 
	i:integer;
begin
	for i:= 1 to DF do begin
		close(d[i]);
		end;
end;

procedure minimo(var d:vecDet; var reg:vecReg; var min:produDeta);
var
	i,posMin:integer;
begin
	posMin:=-1;
	min.cod:=valorAlto;
	for i:= 1 to DF do begin
		if(reg[i].cod < min.cod) then begin
			min:=reg[i];
			posMin:=i;
			end;
		end;
	if(posMin <> -1) then
		leer(d[posMin],reg[posMin]);
end;

procedure procesarArchivo(var m:maestro; var d:vecDet;var reg:vecReg);
var
	regm:producto;
	min,aux:produDeta;
	actual:String;
	txt:text;
	cant:integer;
	total:real;
begin
	assign(txt,'archivo texto');
	rewrite(txt);
	reset(m);
	leerPrimeros(d,reg);
	minimo(d,reg,min);
	read(m,regm);
	while(min.cod <> valorAlto) do begin
		actual:=min.cod;
		cant:=0;total:=0;
		while(actual = min.cod) do begin
			cant:=cant + min.cant;
			minimo(d,reg,min);
			end;
		while(not EOF(m)) and (regm.cod <> codActual) do begin
				read(m,regm);
				end;
		total:= cant * regm.precio;
		if(total > 10000) then 
			write(txt, 'todos los datos de aux')
			
		regm.stAct:=regm.stAct - cant;
		seek(m,filePos(m)-1);
		write(m,regm);
		end;
	close(m);
	cerrarDetalles(d);
	close(txt);
end;
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
