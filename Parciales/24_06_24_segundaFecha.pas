program Dengue;
const
	valorAlto = 9999;
	DF = 30;
type
	maestro_info = record
		cod:integer;
		nombre:String[20];
		cantCasos:integer;
		end;
	detalle_info = record
		cod:integer;
		cantCasos:integer;
		end;
	
	maestro = file of maestro_info;
	
	detalle = file of detalle_info;
	vec_det = array[1..DF] of detalle;
	vec_reg = array[1..DF] of detalle_info;
	
procedure leer(var d:detalle; var r:detalle_info);
begin
if(not EOF(d)) then
	read(d,r)
else
	r.cod:=valorAlto;
end;

procedure leerPrimeros(var d:vec_det; var reg:vec_reg);
var
	i:integer;
begin
	for i:= 1 to DF do begin
		reset(d[i]);
		leer(d[i];reg[i]);
		end;
end;

procedure minimo (var d:vec_det; var reg: vec_reg; var min:detalle_info);
var
	posMin,i:integer;
begin
	min.cod:=valorAlto;
	posMin:= -1;
	for i:= 1 to DF do begin
		if(reg[i].cod < min.cod) then begin
			min:=reg[i].cod;
			posMin:=i;
			end;
		end;
	if(posMin <> -1) then
		leer(d[posMin],reg[posMin]);
end;

procedure cerrarDetalles(var d:vec_det);
var
	i:integer;
begin
	for i:= 1 to DF do begin
		close(d[i]);
		end;
end;
procedure procesarArchivo (var m:maestro; var d:vec_det; var reg:vec_reg);
var
	codActual:integer;
	nomActual,cant:String;
	regM:maestro_info;
	min:detalle_info;
begin
	reset(m);
	read(m,regM);
	leerPrimeros(d,reg);
	minimo(d,reg,min);
	
	while(min.cod <> valorAlto) do begin
		codActual:=min.cod;
		nomActual:=min.nombre;
		while(codActual = min.cod) do begin
			cant:= cant + min.cantCasos;
			minimo(d,reg,min);
			end;
		while(not EOF(m)) and (regM.cod <> codActual) do begin
			read(m,regM);
			end;
		regM.cantCasos := regM.cantCasos + cant;
		if(regM.cantCasos > 15) then 
			writeln('El municipio: ',nomActual,' codigo: ',codActual,' supero los 15 casos');
		seek(m,filePos(m)-1);
		write(m,regM);
		end;
	close(m);
	cerrarDetalles(d);
end;

var
	m:maestro;
	reg:vec_reg;
	d:vec_det;
	i:integer;
	nom:String;
begin
	assign(m,'Archivo maestro');
	for i:= 1 to DF do begin
		writeln('Escriba el nombre del archivo ', i, ':'); readln(nom);
		assign(d[i], nom);
	end;
	actualizarMaestro(m,d,reg);
end;
