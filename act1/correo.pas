program correo;
uses
  crt;
type

  st3=string[3];

  TRP=record
  Cod_Paq:st3;
  peso:byte;
  cod_Des:byte;
  Monto:word;
  end;

  TArchR=file of TRP; //destinos

  TRD=record
  Desc:string[15];
  cantPaq:byte;
  end;

  TVD=array[1..30]of TRD;//vector de destinos

procedure leeArch(var arch:tarchR);//lee texto y genera dat
var
  artxt:text;
  aux:trp;
begin
  rewrite(arch);
  assign(Artxt,'paquetazo.txt');
  reset(artxt);
  while not eof(artxt) do
    begin
    readln(artxt,aux.Cod_Paq,aux.peso,aux.cod_des,aux.monto);
    write(arch,aux);
    end;
  close(artxt);
  close(arch);
end;

procedure leeArchDes(var v1:tvd);
var
  arch:text;
  R:trd;
  i:byte;
begin
  assign(arch,'Destinazo.txt');
  reset(arch);
  i:=0;
  while not eof(Arch)do
  begin
  read(arch,r.desc);
  r.cantpaq:=0;
  i:=i+1;
  v1[i]:=r;
  end;
  close(arch);
end;


//pograma principal----------------------------------------------------//
var
  arch:TArchR;
begin
  clrscr;
  assign(arch,'paquetazo.dat');
  leeArch(arch);
  //CargaTabla(arch);
  readln;
end.