Program act4tp9;
uses   crt;

type
  st3=string[3];

  Art=record
  cod_art:st3;
  talle:char;
  color:byte;
  cant:word;
  precio:real;
  end;

  TAA= file of art; //tipo archivo articulos

///////carga stock.dat
procedure leearch(var dat:taa);
var
  arch:text;
  aux:art;
  nioqui:char;
begin
  assign(arch,'stock.txt');
  reset(arch);
  rewrite(dat);
  while not eof (arch) do
    begin
    readln(arch,aux.cod_art,nioqui,aux.talle,aux.color,aux.cant,aux.precio);
    write(dat,aux);
    end;
  close(arch);
  close(dat);
end;
///////////funciones y procedimientos
procedure listado(var dat:taa);
var
  ar:art;
  codAct:st3;
  CantT,CantN:word;//cantidad Total y Cantidad de prendas Negras
begin
  reset(dat);
  read(dat,ar);
  CantT:=0;
  CantN:=0;
  while not eof(dat) do
    begin
    codAct:=ar.cod_art;
    writeln('Codigo:',codAct);
    writeln('Talle/   cantidad/   precio costo');
    while codAct=ar.cod_art do
      begin
      Writeln(ar.talle,'  ',ar.Cant:8,'  ',ar.precio:16:2);
      if ar.color=1 then
        CantN:=CantN+ar.cant;
      CantT:=CantT+ar.Cant;
      read(dat,ar)
      end;
    end;
  close(dat);
  writeln('Cantidad total: ',CantT);
  writeln('Porcetaje de prendas negras: ',(CantN*100/CantT):8:2,'%');
end;


////////programa principal///////
var
  dat:taa;
begin
  clrscr;
  assign(dat,'stock.dat');
  leearch(dat);
  listado(dat);
  readln;
end.
