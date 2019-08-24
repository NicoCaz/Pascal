program act5tp9;
uses crt;
type
  st3=string[3];
  nota=1..10;
  Insc=0..1;

  Alum=record//primer archivo dat
  matric:st3;
  Mat:nota;
  Fis:nota;
  Qui:nota;
  end;

  Alumnos=record
  matric:st3;
  qui2:Insc;
  fis2:Insc;
  end;

  TANA=file of alum;//tipo archivo notas alumnos
  TAIA=file of Alumnos;// tipo archivo inscripto alumnos
///////carga de dats-----------------------------------------------//
procedure leearch(var datn:tana;var dati:taia);
var
  arch:text;
  aux1:alum; //notas
  aux2:alumnos;//inscri
begin
  assign(arch,'ALUMNOS.TXT');
  reset(arch);
  rewrite(datn);
  rewrite(dati);
  while not eof(arch)do
    begin
    readln(arch,aux1.matric,aux1.mat,aux1.fis,aux1.qui,aux2.qui2,aux2.fis2);
    aux2.matric:=aux1.matric;
    write(datn,aux1);write(dati,aux2);
    end;
  close(arch);
  close(datn);
  close(dati);
end;
///funciones y procedimie:ntos--------------------------------------//
Procedure listado(var dat:tana);
var
  aux:alum;
begin
  reset(dat);
  writeln('Listado: ');
  while not eof(dat) do
    begin
    read(dat,aux);
    writeln;
    writeln('matricula: ',aux.matric);
    if (aux.mat>=4) and (aux.fis>=4) then
      writeln('  Cumple requisitos para fisica 2')
    else
      writeln('  No cumple requisitos para fisica 2');
    if aux.qui>=4 then
      writeln('  Cumple requisitos para quimica 2')
    else
      writeln('  No cumple requisitos para quimica 2')
    end;
end;
//programa principal-----------------------------------------------//
var
  notas:tana;
  inscripciones:taia;
begin
  clrscr;
  assign(notas,'NOTAS.DAT');
  assign(inscripciones,'INSCRIPCIONES.DAT');
  leearch(notas,inscripciones);//carga los .dat
  listado(notas);
  readln;
end.
