program convertor;
uses crt;
type
  st6=string[6];
  fech=array[1..3] of byte;     //[a¤o,mes,dia]
  tcot=array[1..2] of word;   //cota de los bonos

  tax=record
   pat:st6;
   c_viajes:word;
   recau:real;
   Bonos:real;
   kmt:real;
   km:real;
   fecha:fech;
  end;

  viajes=record
   pat:st6;
   can_fi:word;
  end;

  bono=record
  cot:tcot;
  prebono:real;
  end;

  TAbono=file of bono;
  TAtaxi=file of tax;
  TAviajes=file of viajes;

//---------------------------------------------------------------------------------------------------------------------
procedure leerArch(var A_viajes:Taviajes);
var espacio:char;
  arch:text;
  X:viajes;
begin
  assign(arch,'archivo_viajes.txt');
  reset(arch);
  rewrite(a_viajes);
  while not eof(arch) do
    begin
    READLN(arch,x.pat,espacio,x.can_fi);
    write(a_viajes,x);
    end;
  close(ARCH);
  close(a_viajes);
end;
//-------------------------------------------------------------------------------------------------------------------
procedure leerArch2(var A_taxis:tataxi);
var espacio:char;
  espacio3:string[3];
  arch:text;
  X:tax;
begin
  assign(arch,'archivotaxi.txt');
  reset(arch);
  rewrite(a_taxis);
  while not eof(arch) do
    begin
    READLN(arch,x.pat,espacio,x.c_viajes,espacio,x.recau,espacio,x.bonos,espacio,x.kmt,espacio,x.km,espacio,x.fecha[1],espacio3,x.fecha[2],espacio3,x.fecha[3]);
    write(a_taxis,x);
    end;
  close(ARCH);
  close(a_taxis);
end;
//----------------------------------------------------------------------------------------------------------------
procedure leerarch3 (var a_bono:tabono);
var
   aux:bono; arch:text;espacio:char;
begin
   assign(arch,'tabla_de_bonos.txt');reset(arch);
   rewrite(a_bono);
   while not eof(arch) do
     begin
     readln(arch,aux.cot[1],espacio,aux.cot[2],espacio,aux.prebono);
     write(a_bono,aux);
     end;
   close(arch);
   close(a_bono);
   end;
//-----------------------------------------------------------------------------------------------------------------
procedure listaTax(var a_taxis:tataxi);
var
  aux:tax;
begin
  reset(a_taxis);
  writeln('Patente  CantViajes MontoRecaudado BonosTotales KmTotales KmRecorrido FechaUltControl');
  while not eof(a_taxis)do
    begin
    read(a_taxis,aux);
      with aux do
      writeln(pat:6,c_viajes:6,'           $',recau:3:2,'      $',bonos:3:2,kmt:13:2,km:8:2,fecha[1]:8,'/',fecha[2],'/',fecha[3]);
    end;
  close(a_taxis);
end;

procedure listaViajes(var a_viajes:taviajes);
var
  aux:viajes;
begin
  reset(a_viajes);
  writeln;
  writeln('Archivo Viajes');
  writeln('Patente  CantFichas');
  while not eof(a_viajes)do
    begin
    read(a_viajes,aux);
    with aux do
      writeln(pat:6,can_fi:8);
    end;
end;

procedure ListaBonos(var a_bono:tabono);
var
  aux:bono;
begin
  reset(a_bono);
  writeln;
  writeln('Archivo Bonos');
  writeln('[a,b]:=abono');
  while not eof (a_bono)do
    begin
    read(a_bono,aux);
    writeln('    [',aux.cot[1],',',aux.cot[2],']:=',aux.prebono:5:2);
    end;
end;
//--------------------------------------------------------------------------------------------------------------------
var
   A_taxis:TAtaxi;
   A_viajes:TAviajes;
   A_bono:TAbono;
begin
  clrscr;
  assign(a_taxis,'taxis.dat');
  leerArch2(A_taxis);
  listaTax(a_taxis);
  assign(a_viajes,'viajes.dat');
  leerArch(A_viajes);
  listaViajes(a_viajes);
  assign(a_bono,'tabla_de_bonos.dat');
  leerarch3 (a_bono);
  listabonos(a_bono);
  readln;
end.
