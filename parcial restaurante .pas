program parcialrest;
uses
  crt;
const
  F=5;
  C=5;
  Nivel1=50;
  Nivel2=35;
  Nivel3=18;
  Nivel4=0;
type
  st = string[3];
  TM = array [1..F,1..C] of real;
  TV = array [1..F] of st;
//------------------------------------------------------//
procedure leerdat(var mesas:TM; var mozos:TV; var N,M:byte);
  var
    arch:text;
    i,j:byte;
  begin
    assign(arch,'rest.txt');
    reset(arch);
    read(arch,N);
    readln(arch,M);
    for i:= 1 to N do
      begin
      read(arch,mozos[i]);
      for j:= 1 to M do
        read(arch,mesas[i,j]);
      readln(arch);
      end;
    close(arch);
  end;
//------------------------------------------------------//
function RecTotal(mesas:TM; N,M,C:byte):real;
  begin
    if (N=1) and (M=1) then
      RecTotal:= mesas[N,M]
    else
      if M=1 then
        RecTotal:= mesas[N,M] + RecTotal(mesas,N-1,C,C)
      else
        RecTotal:= mesas[N,M] + RecTotal(mesas,N,M-1,C);
  end;
//------------------------------------------------------//
function RecMozo(mesas:TM; N,M:byte):real;
  begin
    if M=1 then
      RecMozo:= mesas[N,M]
    else
      RecMozo:= mesas[N,M] + RecMozo(mesas,N,M-1);
  end;
//------------------------------------------------------//
function TodasMesas(mesas:TM; N,M:byte):boolean;
  var
    j:byte;
  begin
    j:=M;
    while (j>1) and (mesas[N,j]<>0) do
      j:= j-1;
    if mesas[N,j] = 0 then
      TodasMesas:= false
    else
      TodasMesas:= true;
  end;
//------------------------------------------------------//
procedure ExtraMozo(mesas:TM; mozos:TV; N,M:byte);
  var
    i:byte;
    total,extra:Real;
    porcentaje:integer;
  begin
    total:= RecTotal(mesas,N,M,M);
    for i:= 1 to N do
      begin
        porcentaje:=round(RecMozo(mesas,i,M)*100 / total);
        if TodasMesas(mesas,i,M) then
          extra:=10
        else
          extra:=0;
        case porcentaje of
          0..14: writeln('el mozo ',mozos[i],' obtuvo un extra de $',(Nivel4+extra):1:1);
          15..29: writeln('el mozo ',mozos[i],' obtuvo un extra de $',(Nivel3+extra):1:1);
          30..39: writeln('el mozo ', mozos[i],' obtuvo un extra de $',(Nivel2+extra):1:1);
          40..100: writeln('el mozo ', mozos[i],' obtuvo un extra de $',(Nivel1+extra):1:1);
        end;
      end;
  end;
//------------------------------------------------------//
procedure MaxMesa(mesas:TM;mozos:tv ;N,M:byte);
  var
   maxN,maxM,i,j:byte;
   max:real;
  begin
    for i:= 1 to N do
      for j:= 1 to M do
        if mesas[i,j] > max then
           begin
             max:=mesas[i,j];
             maxN:=i;
             MaxM:=M;
           end;
    writeln('El mozo que mas recuado fue ',mozos[maxN],' en la mesa ', maxM);
  end;
//------------------------------------------------------//
function MesaAtendida(mesas:TM; N,M:byte):boolean;
  begin
    if N=1 then
        if mesas[N,M] = 0 then
          MesaAtendida:= false
        else
          MesaAtendida:= True
    else
      if mesas[N,M] <> 0 then
        MesaAtendida:= MesaAtendida(mesas,N-1,M)
      else
        MesaAtendida:= false;
  end;
//------------------------------------------------------//
procedure AtencionDeMesas(mesas:TM; N,M:byte);
  var
    i,cont:byte;
  begin
    cont:=0;
    for i:= 1 to M do
      if MesaAtendida(mesas,N,i) then
        begin
          writeln('La mesa ',i,' fue atendida por todos los mozos');
          cont:= cont + 1;
        end;
    if cont = 0 then
      writeln('Ninguna mesa fue atendida por todos los mozos')
    else
      writeln(cont,' mesas fueron atendidas por todos los mozos');
  end;
//------------------------------------------------------//
var
  mesas:TM;
  mozos:TV;
  N,M:byte;
begin
  clrscr;
  leerdat(mesas,mozos,N,M);
  ExtraMozo(mesas,mozos,N,M);
  MaxMesa(mesas,mozos,N,M);
  AtencionDeMesas(mesas,N,M);
  Readkey;
end.











