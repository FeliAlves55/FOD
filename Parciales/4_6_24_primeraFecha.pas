program sucursales;
const
	valorAlto:9999;
type
	prestamo = record
		nroS:integer;
		dni:integer;
		nroP:integer;
		fecha:String;
		monto:real;
		end;
	
	archivo = file of prestamo;

program leer(var a:archivo; reg:prestamo);
begin
if(not EOF(a)) then
	read(a,reg)
else
	reg.nroS := valorAlto;
end;

program procesarVentas (var a:rchivo);
var
	sucAct,dniAct,cantVen,venS,venEm:integer;
	monS,monEm:real;
	txt:text;
	fecAct:String;
	p:prestamo;
begin
	assign(txt, 'Archivo Texto');
	rewrite(txt);
	reset(a);
	leer(a,p);
	venEm:=0;
	monEm:=0;
	writeln(txt,'Informe de ventas de la empresa');
	while(p.codS <> valorAlto) do begin
		venS:=0;
		monS:=0;
		sucAct:=p.nroS;
		writeln(txt,'Sucursal: ',sucAct);
		while(sucAct = p.nroS) do begin
			dniAct:=p.dni;
			cantVen:=0;
			monTotal:=0;
			writeln(txt,'Empleado dni: ',dniAct);
			writeln(txt,'Año          |Cantidad de Ventas       |Monto de Ventas');
			while(sucAct = p.nroS) and (dniAct = p.dni) do begin
				fecAct:=p.fecha;
				while(sucAct = p.nroS) and (dniAct = p.dni) and (fecAct = p.fecha) do begin
					cantVen:=cantVen + 1;
					monTotal:= monTotal + p.monto;
					leer(a,p);
					end;
				writeln(txt,'  ',fecAct,'  ',cantVen,'  ', monTotal);
				end;
			venS:=venS + cantVen;
			monS:= monS + monTotal;
			end;
		writeln(txt,'Cantidad de ventas total de sucursal: ', venS);
		writeln[txt,'Monto total vendido por la sucursal: ',monS);
		venEm:=venEm + venS;
		monEm:=monEm + monS;
	end;
	writeln(txt,'Cantidad de ventas total de Empresa: ', venEm);
	writeln[txt,'Monto total vendido por la Empresa: ',monEm);
	close(a);
	close(txt);
end;	
				
var
	a:archivo;
begin
	assign(a,'Archivo');
	procesarVentas(a);
end.                                              





