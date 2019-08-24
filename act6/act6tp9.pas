program act6tp9;
uses crt;
type
  st3=string[3];
  st20=string[20];

  emp=record
  legajo:st3;
  nya:st20;
  totven:real;
  nroFac:st3;//numero de factura de mayor venta del mes
  impMay:real;
  end;

  venta=record
  legajo:st3;
  nrofac:st3;
  imp:real;
  end;

  tae=file of emp;
  tav=file of venta;
//-----------------------------------------------------------//
procedure leearch(var date:tae;var datv:tav);
var
  nioqui:char;
  arch:text;
  aux:emp;
  aux2:venta;
begin
  assign(arch,'EMPLEADOS.TXT');
  reset(arch);
  rewrite(date);
  while not eof(arch) do
    begin
    readln(arch,aux.legajo,nioqui,aux.nya,aux.totven,nioqui,aux.nrofac,aux.impmay);
    write(date,aux);
    end;
  close(arch);
  close(date);
  assign(arch,'VENTAS.TXT');
  reset(arch);
  rewrite(datv);
  while not eof(arch) do
    begin
    readln(arch,aux2.legajo,nioqui,aux2.nrofac,aux2.imp) ;
    write(datv,aux2);
    end;
  close(datv);
  close(arch);
end;
//funciones y procedimientos-------------------------------------//
procedure actualiza(var date:tae; var datv:tav);
var
  aux:emp;
  empAct:st3;//empleado actual
  aux2:venta;
begin
  reset(datv);//este lo leo
  reset(date);//actualizo este
//  read(date,aux);
  read(datv,aux2);
  while not eof (datv) do
    begin
    read(date,aux);
    empact:=aux.legajo;
    while (aux2.legajo=empact) do
      begin
      if (aux2.imp>aux.impmay) then
        begin
        aux.impmay:=aux2.imp;
        aux.nrofac:=aux2.nrofac;
        end;
      aux.totven:=aux.totven+aux2.imp;//actualizo el aux1
      read(datv,aux2);
      end;
    //termino de cargar las ventas correspondientes al mismo empleado
    seek(date,filepos(date)-1);
    write(date,aux);
    //read(date,aux);
    end;
end;
procedure listado(var date:tae);
var
  aux:emp;
begin
  reset(date);
  while not eof(date) do
    begin
    read(date,aux);
    writeln('Empleado: ',aux.nya);
    writeln('Total Ventas: ', aux.totven:8:2);
    writeln('Importe correspondiente: ',(aux.totven*0.005):8:2);
    writeln('Mayor venta: ',aux.impmay:8:2);
    writeln();
    end;
end;
//programa principal--------------------------------------------//
var
  date:tae;
  datv:tav;
begin
  clrscr;
  assign(date,'EMPLEADOS.DAT');
  assign(datv,'VENTAS.DAT');
  leearch(date,datv);//ahora tengo cargados los archivos dat
  actualiza(date,datv);
  listado(date);
  readln;
end.