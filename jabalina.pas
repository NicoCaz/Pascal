program jabalina;
uses
  crt;
const
  r=20;
type
  st = string[3];
  TVR = array [1..r] of real;
  TR = record
    Nombre: st;
    intentos: byte;
    Tiros: TVR;
  end;
  TVTR= array [1..r] of TR;
  TVS= array [1..r] of st;
//------------------------------------------//
procedure IntentosEnCero(var resultados:TVTR);
  var
    i:byte;
  begin
    for i:= 1 to r do
      resultados[i].intentos:=0;
  end;
//------------------------------------------//
procedure indices(var resultados:TVTR;var comp:byte; nombre:st;distancia:real);
  var
    cont:byte;
  begin
    cont:=1;
    while (comp>=cont) AND (nombre<>resultados[cont].nombre) do
      cont:= cont +1;
    if resultados[cont].nombre <> nombre then
      begin
        resultados[cont].nombre:= nombre;
        comp:=comp + 1;
      end;
    resultados[cont].intentos:=resultados[cont].intentos + 1;
    resultados[cont].Tiros[resultados[cont].intentos]:=distancia;
  end;
//------------------------------------------//
procedure leerdat(var resultados:TVTR; var comp:byte);
  var
    arch:text;
    nombre:st;
    distancia:real;
  begin
    assign(arch,'jabalina.txt');
    reset(arch);
    comp:=0;
    while not eof(arch) do
      begin
        read(arch,nombre);
        readln(arch,distancia);
        indices(resultados,comp,nombre,distancia);
      end;
  end;
//------------------------------------------//
function MayorIntentos(resultados:TVTR;comp,indice,mayor:byte):byte;
  begin
    if comp=1 then
      if resultados[comp].intentos > mayor then
        MayorIntentos:= comp
      else
        MayorIntentos:=indice
    else
      if resultados[comp].intentos > mayor then
        begin
          mayor:= resultados[comp].intentos;
          indice:=comp;
          MayorIntentos:=MayorIntentos(resultados,comp-1,indice,mayor);
        end
      else
        MayorIntentos:=MayorIntentos(resultados,comp-1,indice,mayor);
  end;
//------------------------------------------//
function suma(resultados:TVTR;indice,intentos:byte):real;
  begin
    if intentos= 1 then
      suma:= resultados[indice].tiros[intentos]
    else
      suma:= resultados[indice].tiros[intentos] + suma(resultados,indice,intentos-1);
  end;
//------------------------------------------//
procedure promedio(resultados:TVTR;comp:byte);
  var
    indice:byte;
  begin
    indice:=MayorIntentos(resultados,comp-1,comp,resultados[comp].intentos);
    writeln('el promedio es: ', (suma(resultados,indice,resultados[indice].intentos)/resultados[indice].intentos):1:2);
  end;
//------------------------------------------//
function PosicionMin(resultados:TVTR; comp:byte):byte;
  var
    min:byte;
  begin
    if comp = 1 then
      min:= 1
    else
      begin
        min:=posicionmin(resultados,comp-1);
        if (resultados[min].tiros[1])> (resultados[comp].tiros[1]) then
          min:=comp;
      end;
    posicionmin:=min;
  end;
//------------------------------------------//
procedure MinimoTiro(resultados:TVTR; comp:byte);
  var
    indice:byte;
  begin
    indice:= posicionmin(resultados,comp);
    writeln(resultados[indice].nombre,' hizo el menor primer tiro con ', resultados[indice].tiros[1]:2:2);
  end;
//------------------------------------------//
function BusquedaX(resultados:TVTR; indice:byte; X:real):boolean;
  var
   j:byte;
  begin
    j:=1;
    while (j<resultados[indice].intentos) and ((X) >= (resultados[indice].tiros[j])) do
      j:= j + 1;
    BusquedaX:= (X)<=(resultados[indice].tiros[j]);
  end;
//------------------------------------------//
procedure MayorAX(resultados:TVTR; comp:byte;var cont:byte;var mejores:TVS);
  var
    X:real;
    i:byte;
  begin
    writeln('ingrese un valor X');
    readln(X);
    cont:=0;
    for i:= 1 to comp do
      if busquedaX(resultados,i,X) then
        begin
          cont:= cont + 1;
          mejores[cont]:= resultados[i].nombre;
        end;
    end;
//------------------------------------------//
procedure mostrarvec(mejores:TVS;cont:byte);
  begin
    if cont = 1 then
      write(mejores[cont],' ')
    else
      begin
        write(mejores[cont],' ');
        mostrarvec(mejores,cont-1);
      end;
  end;
//------------------------------------------//
var
  resultados:TVTR;
  mejores:TVS;

  comp,cont:byte;
begin
  clrscr;
  IntentosEnCero(resultados);
  leerdat(resultados,comp);
  promedio(resultados,comp);
  MinimoTiro(resultados,comp);
  MayorAX(resultados,comp,cont,mejores);
  mostrarvec(mejores,cont);
  Readkey;
end.






