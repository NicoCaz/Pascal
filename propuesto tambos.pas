program propuestolaleche;
uses
  crt;
const
  r=50;
type
  st = string[4];
  TVR = array [1..r] of real;
  TVC = array [1..r] of st;
//----------------------------------------------------------------//
procedure leervec(var N:integer;var COD:TVC;var TOT:TVR; var PROM:TVR;var arch:text);
var
  i,cont:integer;
  sum,aux:real;
begin
  assign(arch,'laleche.txt');
  reset(arch);
  Readln(arch,N);
  for i:= 1 to N do
    Begin
      sum:=0;
      cont:=0;
      Readln(arch,COD[i]);
      read(arch,aux);
      while aux<>0 do
        begin
          cont:= cont + 1;
          sum:= sum + aux;
          read(arch,aux);
        end;
      TOT[i]:= sum;
      PROM[i]:=sum/cont;
      Readln(arch);
    end;
  close(arch);
end;
//----------------------------------------------------------------//
function lechemax(COD:TVC;TOT:TVR;N:integer):st;
  var
    i,indice:integer;
    max:real;
  begin
    max:= TOT[1];
    indice:=1;
    for i:=2 to N do
        if max < TOT[i] then
          begin
            max:= TOT[i];
            indice:= i;
          end;
    lechemax:=COD[indice];
  end;

//----------------------------------------------------------------//
Procedure promediodiario(var X:real; PROM:TVR; N:integer);
  var
    cont,i:integer;
  begin
    cont:=0;
    writeln('ingrese la cantidad de litros que deseea saber cuantos tambos la superaron en promedio diario');
    readln(x);
    for i:=1 to N do
      if PROM[i]>X then
        cont:=cont + 1;
    writeln('La cantidad de tambos que superaron el promedio ', X:1:1,' son ',cont);
  end;

//----------------------------------------------------------------//
function verif(COD:TVC; N:integer; aux:st):integer;
  var
    i:integer;
  begin
    i:=1;
    while (i<N) and (COD[i]<> aux) do
      i:=i+1;
    if COD[i] = aux then
      verif:=i
    else
      verif:=0
  end;
//----------------------------------------------------------------//
Procedure info(COD:TVC; TOT,PROM:TVR; N:integer);
  var
    aux:st;
    conf:byte;
    indice:integer;
  begin
    Repeat
      writeln('ingrese el codigo del tambo del cual desee saber su informacion');
      readln(aux);
      indice:= verif(cod,N,aux);
      if indice = 0 then
        writeln('No existe tambo con el codigo ingresado')
      else
          writeln('el total de leche ingresado es de ', TOT[indice]:1:1,' lts y el promedio diario es de ', PROM[indice]:1:1,' lts');
      writeln('Si desea saber la informacion de otro tambo ingrese 1, si no, ingrese 0 para terminar');
      readln(conf);
      while (conf <> 1) and (conf <> 0) do
        begin
          writeln('ingrese un valor valido, 1 para saber la informacion de otro tambo o 0 para terminar');
          readln(conf);
        end;
    until conf = 0;
 end;
//----------------------------------------------------------------//
var
  TOT, PROM:TVR;
  COD:TVC;
  N:integer;
  X:real;
  arch:text;
Begin
  clrscr;
  leervec(N,COD,TOT,PROM,arch);
  writeln('el codigo del tambo que mas leche entrego es ', lechemax(COD,TOT,N));
  promediodiario(X,PROM,N);
  info(COD,TOT,PROM,N);
  Readkey;
End.
