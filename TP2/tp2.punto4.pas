program punto4;
const
N=30;
valor_alto=9999;
type 
producto = record
        codigo, stock, stockMin: integer;
        nombre, descripcion: string;
        precio: real;
    end;

    detalle = record
        codigo, cantVendida: integer;
    end;
    
maestro = file of producto;
detalle_file= file of detalle

// Vectores para manejar las 30 sucursales
    vDetalles = array[1..N] of detalle_file;
    vRegistros = array[1..N] of detalle;

procedure leer(var archivo:detalle_file; var dato:detalle);
begin
if(not EOF(archivo)) then
	read(archivo,dato);
else
	dato.codigo := valor_alto;
end;

procedure minimo (var v:vDetalles; var r:vRegistros; min:detalle);
var
	i,posMin:integer;
begin
	min.codigo:=valor_alto;
	posMin:=-1;
	for i:= 1 to N do begin
		if(v[i].codigo < min.codigo) then begin
			min:=v[i];
			posMin:=i;
			end;
		if (posMin <> -1) then
        leer(vD[posMin], vR[posMin]);
	end;
end;

procedure actualizarMaestro (var mae:maestro; var v:vDetalles);
var
vR: vRegistros;
    min: detalle;
    p: producto;
    i: integer;
    texto: text;
begin
	assign(texto,'bajo_stock.txt');
	rewrite(texto);
	
	reset(mae);
	for i := 1 to N do begin
        reset(vD[i]);
        leer(vD[i], vR[i]);
    end;
    minimo(vD, vR, min);
    while(min.codigo <> valor_alto) do begin
		read(mae,p);
		
		while(mae.codigo <> min.codigo) do begin
			read(mae,p);
			end;
		// 3. Procesar todas las ventas de todas las sucursales para este producto
        while (min.codigo = regM.codigo) do begin
            p.stock := p.stock - min.cantVendida;
            minimo(vD, vR, min);
        end;
        
        seek(mae,filepos(mae)-1);
        write(mae,p);
        f (regM.stock < regM.stockMin) then
            writeln(texto, regM.nombre, ' ', regM.descripcion, ' ', regM.stock, ' ', regM.precio:0:2);
    end;

    // Cerrar todo
    close(mae); close(texto);
    for i := 1 to N do close(vD[i]);
end;
        
