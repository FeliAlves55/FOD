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

procedure minimo (var d:vec_det; var reg: vec_reg);
var
	min,posMin,i:integer;
begin
	min:=valorAlto;
	for i:= 1 to DF do begin
		reg

