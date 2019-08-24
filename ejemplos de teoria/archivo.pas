program archivos;

uses
  crt;
type
//  st6=string[6];
  TR=record
    c1:real;
    c2:string[5];
  end;
  Tv=array [1..10] of word;
  Tarch1=file of word;  //las componentes son enteros//dentro del archivo hay numeros pero no los podes ver
  Tarch2=file of TR;//las componentes son registros
  tarch3=file of TV;// las componentes son arreglos

//procedimientos y funciones-----------------------------------------------//
procedure graba1(var arch:tarch1);
var
  m:word;
begin
  rewrite(arch);
  readln(m);
  while m<>0 do
    begin
      write(arch,m);
      readln(m);
    end;
  close(arch);
end;

procedure graba2(var A2:tarch2);
var
  R:TR;
begin
  rewrite(A2);
  readln(R.C1);
  while R.C1<>0 do
    begin
      readln(R.C2);
      write(A2,R);
      readln(r.c1);
    end;
  close(A2);
end;

procedure lista1(var Arch:tarch1);
var
   aux:word;
begin
  reset(arch);
  while not eof (arch) do
    begin
    read(arch,aux);
    write(aux:6);
    end;
  writeln;
  close(arch);
end;

procedure Lista2(var A2:tarch2);
var
  r:tr;
begin
  reset(A2);
  while not eof(A2) do
    begin
    read(A2,R);
    write(R.c1:6:2,R.c2:6)
    end;
  writeln;
  close(A2);
end;
//Programa-Principal-------------------------------------------------------//
var
  arch1:tarch1;
  arch2:tarch2;
  arch3:tarch3;
begin
  clrscr;
  assign(arch1,'archivo.Dat');
  //graba(arch1);
  lista1(arch1);
  assign(arch2,'Datos2.Dat');
  //graba2(arch2);
  lista2(arch2);
  readln;
end.
