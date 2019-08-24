program act3tp9;
uses
  crt;
type
  st15=string[16];

  TViaje=record
  codexc:byte;
  desc:st15;
  precioB:real;
  PrecioC:real;
  end;

  TB=record//tipo boleto
  codexc:byte;//codigo excursion
  num:word;
  com:char;
  end;
               //const
  TV=array [1..50]of TViaje;
  TAB=file of TB;

//procesos y funciones________________________________________________________//
procedure leetxt(var vec:tv);
var
  viaje:tviaje;
  arch:text;
  //i:byte;
begin
 assign(arch,'turismo.txt');
 reset(arch);
 //i:=0;
 while not eof(arch)do
   begin
   //i:=i+1;
   readln(arch,viaje.codexc,viaje.desc,viaje.precioB,viaje.precioC);
   vec[viaje.codexc]:=viaje;
   //vec[i]:=viaje;
   end;
 close(arch);
end;

procedure carga(var dat:tab);
var
  nioqui:char;
  arch:text;
  paso:tb;
begin
  assign(arch,'boleteria.txt');
  reset(arch);
  rewrite(dat);
  while not eof(arch) do
    begin
    readln(arch,paso.codexc,paso.num,nioqui,paso.com);
    write(dat,paso);
    end;

end;

procedure Listado(vec:tv; var dat:tab);
var
  paso:tb;
  //arch:text;
  codact,cantB,CantC:byte;
  total:real;
  //nioqui:char;
begin
  reset(dat);
  writeln('Excursion/Cantidad De boletos/Cantidad de comida /Monto total');
  read(dat,paso);
  //readln(arch,paso.codexc,paso.num,nioqui,paso.com);//leo codigo actual, numero de boleto actual y comida actual
  while not eof(dat) do
    begin
    codAct:=paso.codexc;
    cantB:=0;
    CantC:=0;
    Total:=0;
    while (codact=paso.codexc) do
      begin
      cantB:=cantB+1;
      if Upcase(paso.com)='S'then
        cantC:=CantC+1;
      read(dat,paso);
      end;
    total:=(vec[codact].preciob*CantB)+(VEC[codact].precioc*CantC);
    writeln('///',codact,vec[codact].desc,' / ',CANTB,' /' ,cANTC,' / ', total:8:2);
    end;
end;
//P.P--------------------------------------------------//
var
  tabla:tv;
  boleteria:tab;
begin
  clrscr;
  leetxt(tabla);
  assign(boleteria,'boleteria.dat');
  carga(boleteria);
  listado(tabla,boleteria);
  readln;
end.